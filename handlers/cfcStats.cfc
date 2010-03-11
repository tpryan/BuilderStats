component 
{

	public cfcStats function init(required string rootpath,required util util){
    	variables.FS = createObject("java", "java.lang.System").getProperty("file.separator");		
    	variables.webroot= ExpandPath("/");
		variables.rootpath= arguments.rootpath;
		variables.util = arguments.util;
		
		variables.baseStats = getCFCStats();
		return This;
    }
    
	public query function getBaseStats(){
		return variables.baseStats;
	}

	private query function getCFCStats(){
		var cfcs = getCFCList(variables.rootpath);
		var i = 0;
		var results = QueryNew("file,relativeParent,relativeFile,functionCount,propertyCount,isHinted,udfCount,implicitFunctionsCount,unhintedudfCount,hintedudfCount");
		
		for (i=1;i <= cfcs.recordCount; i++){
			var cfcinfo = getComponentInfo(cfcs['file'][i]);
			QueryAddRow(results);
			QuerySetCell(results, "file", cfcs['file'][i]);
			QuerySetCell(results, "relativeParent", variables.util.MakeRelativeFilePath(cfcs.directory[i],variables.rootPath)) ;
			QuerySetCell(results, "relativeFile", variables.util.MakeRelativeFilePath(cfcs.file[i],variables.rootPath)) ;
			QuerySetCell(results, "functionCount", cfcInfo['functionCount']);
			QuerySetCell(results, "propertyCount", cfcInfo['propertyCount']);
			QuerySetCell(results, "isHinted", cfcInfo['isHinted']);
			QuerySetCell(results, "udfCount", cfcInfo['udfCount']);
			QuerySetCell(results, "implicitFunctionsCount", cfcInfo['implicitFunctionsCount']);
			QuerySetCell(results, "unhintedudfCount", cfcInfo['unhintedudfCount']);
			QuerySetCell(results, "hintedudfCount", cfcInfo['udfCount'] - cfcInfo['unhintedudfCount']);
			
		}
		
		var SQL = "SELECT * FROM resultset WHERE file not like '%test%'";
		var qoq = new Query();
	    qoq.setAttributes(resultSet = results); 
	  	qoq.SetDBType("query");
	    var results = qoq.execute(sql=SQL).getResult();
		
		return results;
	}
	
	public query function getHintedCounts(){
		//Get the grand total
		var SQL = "SELECT sum(cast(hintedudfcount as integer)) as hintedudfcount, sum(cast(unhintedudfcount as integer)) as unhintedudfcount FROM resultset";
		var qoq = new Query();
	    qoq.setAttributes(resultSet = variables.baseStats); 
	  	qoq.SetDBType("query");
	    var result = qoq.execute(sql=SQL).getResult();
	
		return result;
	}
	
	public query function getimplicitCounts(){
		//Get the grand total
		var SQL = "SELECT sum(cast(udfcount as integer)) as udfcount, sum(cast(implicitfunctionscount as integer)) as implicitfunctionscount FROM resultset";
		var qoq = new Query();
	    qoq.setAttributes(resultSet = variables.baseStats); 
	  	qoq.SetDBType("query");
	    var result = qoq.execute(sql=SQL).getResult();
	
		return result;
	}
	
	public query function getCFCList(required string rootpath){
		var files = DirectoryList(arguments.rootPath, true, "Query");
	
		//filter only CFC's
		SQL = "SELECT directory + '#variables.FS#' + name as file, directory, name  FROM resultset WHERE name like '%.cfc'";
		qoq = new Query();
	    qoq.setAttributes(resultSet = files); 
	  	qoq.SetDBType("query");
	    files = qoq.execute(sql=SQL).getResult();
		
		return files;
	}
	
	public struct function getComponentInfo(required string pathToCfC){
		var cfcInfo = getComponentMetadata(findCFCPathFromFilePath(arguments.pathToCfC)); 
		var returnInfo = {};
		var i = 0;
		var j = 0;
		
		
		
		if(structKeyExists(cfcInfo, "functions")){
			var allfunctions = cfcInfo.functions;
		}
		else{
			var allfunctions = [];
		}
		
		if(structKeyExists(cfcInfo, "properties")){
			var properties = cfcInfo.properties;
		}
		else{
			var properties = [];
		}
		
		
		var udfFunctions = [];
		var unhintedudfFunctions = [];
		var implicitFunctions = [];
		
		returnInfo['functionCount'] = ArrayLen(allfunctions);
		returnInfo['propertyCount'] = ArrayLen(properties);
		returnInfo['isHinted'] = structKeyExists(cfcInfo, "hint");
		
		
		//Calculate implicit vs udf functions
		for (i = ArrayLen(allfunctions); i >0; i-- ){
			var implicit = false;
			for (j=1; j <= ArrayLen(properties); j++){
				if (CompareNoCase(allfunctions[i]['name'], "get" & properties[j].name) eq 0 OR
					CompareNoCase(allfunctions[i]['name'], "set" & properties[j].name) eq 0
				){
					ArrayAppend(implicitFunctions, Duplicate(allfunctions[i]));
					implicit = true;
					break;		
				}
				
			}
			if (not implicit){
				ArrayAppend(udfFunctions, allfunctions[i]);
			}
		}
		
		returnInfo['udfCount'] = ArrayLen(udfFunctions);
		returnInfo['implicitFunctionsCount'] = ArrayLen(implicitFunctions);
		
		//Calculate unhinted udf's
		for (i=1; i <= ArrayLen(udfFunctions); i++){
			if (not StructKeyExists(udfFunctions[i], "hint") OR Len(udfFunctions[i].hint) eq 0){
				ArrayAppend(unhintedudfFunctions, udfFunctions[i]);
			}
		}
		
		returnInfo['unhintedudfCount'] = ArrayLen(unhintedudfFunctions);
		
		
		return returnInfo;
	}
	
	public string function findCFCPathFromFilePath(string path){
		
		var localPath = arguments.path;
		
		
		if (FindNoCase("cfc", listLast(localPath, "."))){
			localPath = left(localPath, Len(localPath) - 4);
		}
		
		var results = "";
		results = replaceNoCase(localPath, webroot, "", "one");
		results = replaceList(results, "/,\", ".,.");
		
		
		
		
		if (compare(right(results, 1), ".") eq 0){
			results = Left(results, len(results) -1);
		}
		
		return results;
	}



}