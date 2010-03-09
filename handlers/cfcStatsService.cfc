component{

	remote query function getBaseStats(required string rootPath){
		var cfcStatsObj = getcfcStatsObj(arguments.rootPath);
		return cfcStatsObj.getBaseStats();
	}
	
	remote query function getHintedCounts(required string rootPath){
		
		var cfcStatsObj = getcfcStatsObj(arguments.rootPath);
		var hintCounts = cfcStatsObj.getHintedCounts();
		var results = QueryNew("counttype,count","varchar,integer");
		QueryAddRow(results);
		QuerySetCell(results,"counttype", "Functions not hinted");
		QuerySetCell(results,"count",hintCounts.unhintedudfcount);
		QueryAddRow(results);
		QuerySetCell(results, "counttype",  "Functions hinted");
		QuerySetCell(results,"count",hintCounts.hintedudfcount);
		
		
		
		return results;
	}
	
	remote query function getimplicitCounts(required string rootPath){
		var cfcStatsObj = getcfcStatsObj(arguments.rootPath);
		var implicitCount =cfcStatsObj.getimplicitCounts();
		var results = QueryNew("counttype,count","varchar,integer");
		QueryAddRow(results);
		QuerySetCell(results,"counttype", "Implicit Functions");
		QuerySetCell(results,"count",implicitCount.implicitfunctionscount);
		QueryAddRow(results);
		QuerySetCell(results, "counttype",  "User Defined Functions");
		QuerySetCell(results,"count",implicitCount.udfcount);
		
		
		return results;
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

}
