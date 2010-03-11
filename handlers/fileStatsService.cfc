component{

	remote any function getLineCountsAll(required string rootPath) returnformat="plain" {
		var fileStatsObj = getFileStats(arguments.rootPath);
		return convertQueryToXML(fileStatsObj.getLineCountsAll(),"query","fileinfo");
	}
	
	remote any function getGrandTotal(required string rootPath) returnformat="plain" {
		var fileStatsObj = getFileStats(arguments.rootPath);
		
		var result = CreateObject("java","java.lang.StringBuilder").Init();
		result.append('<?xml version="1.0" encoding="UTF-8"?>');
		result.append("<query>");
		result.append("<result>#fileStatsObj.getGrandTotal()#</result>");
		result.append("</query>");
		
		
		return result.toString();
	}
	
	remote any function getLinesByExtension(required string rootPath) returnformat="plain" {
		var fileStatsObj = getFileStats(arguments.rootPath);
		return convertQueryToXML(fileStatsObj.getLinesByExtension(),"query","extInfo");
	}
	
	remote any function getLinesByDirectory(required string rootPath) returnformat="plain" {
		var fileStatsObj = getFileStats(arguments.rootPath);
		return convertQueryToXML(fileStatsObj.getLinesByDirectory(),"query","dirInfo");
	}

	private fileStats function getFileStats(required string rootPath){
		var fileStatsObj = cacheGet(arguments.rootpath);
		
		if (IsNull(fileStatsObj)){
			var util = New util();
			var onlyAFile = util.isOnlyAFile(arguments.rootPath);
			var fileStatsObj = New fileStats(arguments.rootPath, onlyAFile, util);
			cachePut(arguments.rootPath, fileStatsObj, CreateTimeSpan(0,0,0,10));
		}
		return fileStatsObj;
	}
	
	private any function convertQueryToXML(required query queryToRewrite, string root="query", string item="record"){
		var nl = createObject("java", "java.lang.System").getProperty("line.separator");
		var result = CreateObject("java","java.lang.StringBuilder").Init();
		result.append('<?xml version="1.0" encoding="UTF-8"?>');
		result.append(nl);
		var i = 0;
		var j = 0;
		var q = arguments.queryToRewrite;
		var cols = q.columnList;
		
		result.append("<#arguments.root#>");
		result.append(nl);
		
		for (i = 1; i <= q.recordCount; i++){
			result.append("	<#arguments.item#>");
			result.append(nl);
			for (j = 1; j <= listLen(cols); j++){
				result.append('		<#Lcase(ListGetAt(cols,j))#>');
				result.append('#q[ListGetAt(cols,j)][i]#');
				result.append('</#Lcase(ListGetAt(cols,j))#>');
				result.append(nl);
			}
			result.append("	</#arguments.item#>");
			result.append(nl);
		}
	
	
		result.append("</#arguments.root#>");
	
		return result.toString();
		
	}

}
