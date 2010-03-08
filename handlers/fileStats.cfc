component{

	public fileStats function init(required string rootPath, string onlyAFile = "directory", required util util){
    	variables.FS = createObject("java", "java.lang.System").getProperty("file.separator");	
		variables.rootPath = arguments.rootPath;
		variables.util = arguments.util;
		variables.extList = "cfm,cfc,css,xml,htm,html,js";
		variables.extList = listQualify(variables.extList, "'");
		variables.onlyAFile = arguments.onlyAFile;
		variables.baseStats = getBaseStats();
			
    	return This;
    }
	
	public query function getLineCountsAll(){
		return variables.baseStats;
	}
	
	public numeric function getGrandTotal(){
	
		//Get the grand total
		var SQL = "SELECT sum(cast(lines as integer)) as lines FROM resultset";
		var qoq = new Query();
	    qoq.setAttributes(resultSet = variables.baseStats); 
	  	qoq.SetDBType("query");
	    var totalLines = qoq.execute(sql=SQL).getResult();
	
		return totalLines.lines;
	}
	
	public query function getLinesByExtension(){
	
		var SQL = "SELECT count(file) as numberOfFiles, sum(cast(lines as integer)) as lines, extension FROM resultset GROUP BY extension";
		var qoq = new Query();
	    qoq.setAttributes(resultSet = variables.baseStats); 
	  	qoq.SetDBType("query");
	    var linesByextension = qoq.execute(sql=SQL).getResult();
	
		return linesByextension;
	}
	
	public query function getLinesByDirectory(){
	
		var SQL = "SELECT count(file) as numberOfFiles, sum(cast(lines as integer)) as lines, relativeParent FROM resultset GROUP BY relativeParent";
		var qoq = new Query();
	    qoq.setAttributes(resultSet = variables.baseStats); 
	  	qoq.SetDBType("query");
	    var linesByFolder = qoq.execute(sql=SQL).getResult();
	
		return linesByFolder;
	}
	
	
	private query function getBaseStats(){
	
		if (variables.onlyAFile){
			var files = DirectoryList(GetDirectoryFromPath(variables.rootPath), true, "Query");
		}
		else{
			var files = DirectoryList(variables.rootPath, true, "Query");
		}
		
		
		var fileStats = QueryNew("file,extension,lines,relativeParent,relativeFile");
		var i = 0;
		var qoq = new Query();
		var SQL ="";
		var pathToCount = "";
		var rootFileName = "";
		
		if (variables.onlyAFile){
			pathToCount = GetDirectoryFromPath(variables.rootPath);
			pathToCount = Left(pathToCount, Len(pathToCount) -1);
			rootFileName = GetFileFromPath(variables.rootPath);
			SQL = "SELECT * FROM resultset WHERE directory ='#pathToCount#' AND name ='#rootFileName#'";
		}	
		else{
			SQL = "SELECT * FROM resultset WHERE type !='Dir'";
		}
		
	    qoq.setAttributes(resultSet = files); 
	  	qoq.SetDBType("query");
	    files = qoq.execute(sql=SQL).getResult();
		
		for(i=1; i <= files.recordCount; i++){
			var filePath = files.directory[i] & FS & files.name[i];
			QueryAddRow(fileStats);
			QuerySetCell(fileStats, "file", filePath);
			QuerySetCell(fileStats, "extension", ListLast(files.name[i], "."));
			QuerySetCell(fileStats, "relativeParent", variables.util.MakeRelativeFilePath(files.directory[i],variables.rootPath)) ;
			QuerySetCell(fileStats, "relativeFile", variables.util.MakeRelativeFilePath(filePath,variables.rootPath)) ;
		}
		
		//filter out extensions that we don't want.
		SQL = "SELECT * FROM resultset WHERE extension in(#extList#) AND file not like '%/.%'";
		qoq = new Query();
	    qoq.setAttributes(resultSet = fileStats); 
	  	qoq.SetDBType("query");
	    fileStats = qoq.execute(sql=SQL).getResult();
		
		//Count all of the lines of code
		for(j=1; j <= fileStats.recordCount; j++){
			QuerySetCell(fileStats, "lines", util.countLines(fileStats.file[j]), j);
		}
	
		return fileStats;
	}
    

}
