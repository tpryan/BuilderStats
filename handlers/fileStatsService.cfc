component{

	remote query function getLineCountsAll(required string rootPath){
		var fileStatsObj = getFileStats(arguments.rootPath);
		return fileStatsObj.getLineCountsAll();
	}
	
	remote numeric function getGrandTotal(required string rootPath){
		var fileStatsObj = getFileStats(arguments.rootPath);
		return fileStatsObj.getGrandTotal();
	}
	
	remote query function getLinesByExtension(required string rootPath){
		var fileStatsObj = getFileStats(arguments.rootPath);
		return fileStatsObj.getLinesByExtension();
	}
	
	remote query function getLinesByDirectory(required string rootPath){
		var fileStatsObj = getFileStats(arguments.rootPath);
		return fileStatsObj.getLinesByDirectory();
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

}
