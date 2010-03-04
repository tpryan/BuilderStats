<cfsetting showdebugoutput="FALSE" />
<cfparam name="url.rootFilePath" default="#ExpandPath('.')#" />

<cfscript>

	if (not DirectoryExists(url.rootFilePath) and fileExists(url.rootFilePath)){
		onlyAFile = true;
	}
	else{
		onlyAFile = false;
	}

	util = New util();
	fileStatsObj = New fileStats(rootFilePath, onlyAFile, util);
	
	fileStats = fileStatsObj.getLineCountsAll();
	//Get the grand total
    totalLines = fileStatsObj.getGrandTotals();
	//Query for lines of code by extension.
    linesByextension = fileStatsObj.getLinesByExtension();
	//Query for lines of code by folder.
    linesByFolder = fileStatsObj.getLinesByDirectory();
	
</cfscript>	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="jquery.js"></script>
<script src="jquery.tablesorter.min.js"></script>
<script src="lib.js"></script>

</script>
<title>BuilderStats</title>
	<link rel="stylesheet" href="screen.css" type="text/css"/>
	
	</head>
	<body>
<cfoutput>
	<h1>Code Stats</h1>	
	
	<cfif onlyAFile>
		<p>The file <em>#url.rootFilePath#</em> contains <strong>#NumberFormat(totalLines)#</strong> lines of code.	
		<cfabort>
	<cfelse>
		<p>The folder <em>#rootFilePath#</em> contains <strong>#NumberFormat(totalLines)#</strong> lines of code in <strong>#NumberFormat(fileStats.recordCount)#</strong> files.	
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


