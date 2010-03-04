<cfsetting showdebugoutput="FALSE" />
<cfparam name="url.rootFilePath" default="#ExpandPath('.')#" />

<cfscript>

	if (not DirectoryExists(url.rootFilePath) and fileExists(url.rootFilePath)){
		onlyAFile = true;
		fileToCount = url.rootFilePath;
		rootFilePath = GetDirectoryFromPath(url.rootFilePath);
		rootFilePath = Left(rootFilePath, Len(rootFilePath) -1);
		rootFileName = GetFileFromPath(url.rootFilePath);
		SQL = "SELECT * FROM resultset WHERE directory ='#rootFilePath#' AND name ='#rootFileName#'";
		
	}
	else{
		onlyAFile = false;
		rootFilePath = url.rootFilePath;
		SQL = "SELECT * FROM resultset WHERE type !='Dir'";
	}

	FS = createObject("java", "java.lang.System").getProperty("file.separator");
	extList = "cfm,cfc,css,xml,htm,html,js";
	extList = listQualify(extList, "'");
	
	
	
	files = DirectoryList(rootFilePath, true, "Query");
	fileStats = QueryNew("file,extension,lines,relativeParent,relativeFile");
	

	qoq = new Query();
    qoq.setAttributes(resultSet = files); 
  	qoq.SetDBType("query");
    files = qoq.execute(sql=SQL).getResult();
	
	for(i=1; i <= files.recordCount; i++){
		filePath = files.directory[i] & FS & files.name[i];
		QueryAddRow(fileStats);
		QuerySetCell(fileStats, "file", filePath);
		QuerySetCell(fileStats, "extension", ListLast(files.name[i], "."));
		QuerySetCell(fileStats, "relativeParent", CleanFilePath(files.directory[i])) ;
		QuerySetCell(fileStats, "relativeFile", CleanFilePath(filePath)) ;
	}
	
	//filter out extensions that we don't want.
	SQL = "SELECT * FROM resultset WHERE extension in(#extList#)";
	qoq = new Query();
    qoq.setAttributes(resultSet = fileStats); 
  	qoq.SetDBType("query");
    fileStats = qoq.execute(sql=SQL).getResult();
	
	
	//Count all of the lines of code
	for(j=1; j <= fileStats.recordCount; j++){
		QuerySetCell(fileStats, "lines", countLines(fileStats.file[j]), j);
	}
	
	//Get the grand total
	SQL = "SELECT sum(cast(lines as integer)) as lines FROM resultset";
	qoq = new Query();
    qoq.setAttributes(resultSet = fileStats); 
  	qoq.SetDBType("query");
    totalLines = qoq.execute(sql=SQL).getResult();
	
	//Query for lines of code by extension.
	SQL = "SELECT count(file) as numberOfFiles, sum(cast(lines as integer)) as lines, extension FROM resultset GROUP BY extension";
	qoq = new Query();
    qoq.setAttributes(resultSet = fileStats); 
  	qoq.SetDBType("query");
    linesByextension = qoq.execute(sql=SQL).getResult();
	
	//Query for lines of code by folder.
	SQL = "SELECT count(file) as numberOfFiles, sum(cast(lines as integer)) as lines, relativeParent FROM resultset GROUP BY relativeParent";
	qoq = new Query();
    qoq.setAttributes(resultSet = fileStats); 
  	qoq.SetDBType("query");
    linesByFolder = qoq.execute(sql=SQL).getResult();
	
</cfscript>	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="jquery.js"></script>
<script src="jquery.tablesorter.min.js"></script>
<script>
$(document).ready(function() {

//From Barney B: http://www.barneyb.com/barneyblog/2009/06/03/jquery-tablesorter-comma-parser/
jQuery.tablesorter.addParser({
  id: "commaDigit",
  is: function(s, table) {
    var c = table.config;
    return jQuery.tablesorter.isDigit(s.replace(/,/g, ""), c);
  },
  format: function(s) {
    return jQuery.tablesorter.formatFloat(s.replace(/,/g, ""));
  },
  type: "numeric"
});

$("#allData").tablesorter({
	headers: {1: {sorter:"commaDigit"}},
	widgets: ["zebra"]
});
$("#extData").tablesorter({
	headers: {2: {sorter:"commaDigit"}},
	widgets: ["zebra"]
});
$("#folderData").tablesorter({
	headers: {2: {sorter:"commaDigit"}},
	widgets: ["zebra"]	
});

})
</script>
<cfoutput><title>BuilderStats</title></cfoutput>

	<style>
		
		thead th { cursor:pointer; }
		
		body{
			font-family: "Adobe Clean", "Myriad Pro", Calibri, Tahoma, Arial, Helvetica, sans-serif;
			font-size: 14px;
			background-color: #2A587A;
			background-image: url(grad.jpg);
			background-repeat: repeat-x;
			padding: 5px;
			
		}
		h1{
			font-size: 17px;
		}
		
		h2{
			font-size: 16px;
			padding-bottom: 0;
			margin-bottom: 0;
		}
		em{ font-style:italic;}
		strong{font-weight:bold;};
		
		table{
			width: 100%;
		}
		
		th{
			text-align: left;
			font-weight: bold;
			background-color: #142a3a;
			padding: 2px;
			color: #DDDDDD;
		}
		
		td{
			padding: 1px 2px;
		}
		tr{
			background-color:#FFFFFF;
		}
		
		td{
			margin: 0;
		}
		
		tr.odd{
			background-color: #DEDEDE;
		}

		tr.header{
			background-color: transparent;
		}
		
		.lines{
			text-align: right;
			width: 100px;	
		}
		.files{
			width: 120px;	
		}
		
		.type{
			width: 180px;
			
		}
		
		.folder{
			width: 180px;
			
		}
		
		.file{
			width: 305px;
			
		}
		
	</style>
	</head>
	<body>
<cfoutput>
	<h1>Code Stats</h1>	
	
	<cfif onlyAFile>
		<p>The file <em>#url.rootFilePath#</em> contains <strong>#NumberFormat(totalLines.lines)#</strong> lines of code.	
		<cfabort>
	<cfelse>
		<p>The folder <em>#rootFilePath#</em> contains <strong>#NumberFormat(totalLines.lines)#</strong> lines of code in <strong>#NumberFormat(fileStats.recordCount)#</strong> files.	
	</cfif>

	<h2>By Extension</h2>	
	<table cellpadding="0" cellspacing="0" id="extData">
	<thead>
	<tr><th class="type">Type &loz;</th><th class="files">Files &loz;</th><th class="lines">Lines of Code &loz;</th></tr>	
	</thead>
	<tbody>
	<cfloop query="linesByextension">
		<tr><td>#extension#</td><td>#NumberFormat(numberofFiles)#</td><td class="lines">#NumberFormat(lines)#</td></tr>
	</cfloop>
	</tbody>
	</table>
	
	<h2>By Folder</h2>
	<table cellpadding="0" cellspacing="0" id="folderData">
	<thead>	
	<tr><th class="folder">Folder &loz;</th><th class="files">Files &loz;</th><th class="lines">Lines of Code &loz;</th></tr>	
	</thead>
	<tbody>
	<cfloop query="linesByFolder">
		<tr><td>#relativeparent#</td><td>#NumberFormat(numberofFiles)#</td><td class="lines">#NumberFormat(lines)#</td></tr>
	</cfloop>
	</tbody>
	</table>
	<h2>All</h2>
	<table cellpadding="0" cellspacing="0" id="allData">
	<thead>
	<tr><th class="file" colspan="2">File &loz;</th><th class="lines">Lines of Code &loz;</th></tr>	
	</thead>
	<tbody>
	<cfloop query="fileStats">
		<tr><td colspan="2">#relativefile#</td><td class="lines">#NumberFormat(lines)#</td></tr>
	</cfloop>
	</tbody>
	</table>
	
	

	
</cfoutput>
</body>
</html>

<cfscript>		
	
	public numeric function countLines(required string filePath){
		var file = FileOpen(arguments.filePath, "read"); 
		var i = 0;
		
		while(NOT FileisEOF(file)) { 
			var line = FileReadLine(file);
			if(Len(Trim(line)) > 0){ 
				i++;
			}
		} 
		
		FileClose(file); 
		return i;
	}
	
	public string function CleanFilePath(required string filePath){
		var result = ReplaceNoCase(arguments.filePath, variables.rootFilePath, "", "once");
		if (len(result) eq 0){
			result = FS;
		}
		return result;
	}
	
</cfscript>	

