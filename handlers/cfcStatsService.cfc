component output="true"{


	remote any function getBaseStats(required string rootPath) returnformat="plain" {
		var cfcStatsObj = getcfcStatsObj(arguments.rootPath);
		return convertQueryToXML(cfcStatsObj.getBaseStats(), "query", "cfcinfo");
	}
	
	remote any function getHintedCounts(required string rootPath){
		
		var cfcStatsObj = getcfcStatsObj(arguments.rootPath);
		var hintCounts = cfcStatsObj.getHintedCounts();
		var results = QueryNew("counttype,count","varchar,integer");
		QueryAddRow(results);
		QuerySetCell(results,"counttype", "Functions not hinted");
		QuerySetCell(results,"count",hintCounts.unhintedudfcount);
		QueryAddRow(results);
		QuerySetCell(results, "counttype",  "Functions hinted");
		QuerySetCell(results,"count",hintCounts.hintedudfcount);
		
		
		
		return convertQueryToXML(results, "query", "count");
	}
	
	remote any function getimplicitCounts(required string rootPath){
		var cfcStatsObj = getcfcStatsObj(arguments.rootPath);
		var implicitCount =cfcStatsObj.getimplicitCounts();
		var results = QueryNew("counttype,count","varchar,integer");
		QueryAddRow(results);
		QuerySetCell(results,"counttype", "Implicit Functions");
		QuerySetCell(results,"count",implicitCount.implicitfunctionscount);
		QueryAddRow(results);
		QuerySetCell(results, "counttype",  "User Defined Functions");
		QuerySetCell(results,"count",implicitCount.udfcount);
		
		
		return convertQueryToXML(results, "query", "count");
	}

	private cfcStats function getcfcStatsObj(required string rootPath){
		var cfcStatsObj = cacheGet(arguments.rootpath);
		
		if (IsNull(cfcStatsObj)){
			var util = New util();
			var cfcStatsObj = New cfcStats(arguments.rootPath, util);
			cachePut(arguments.rootPath, cfcStatsObj, CreateTimeSpan(0,0,0,10));
		}
		return cfcStatsObj;
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
