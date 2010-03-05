component{

	remote query function getLineCountsAll(required string rootPath){
		var util = New util();
		var onlyAFile = util.isOnlyAFile(arguments.rootPath);
		var fileStatsObj = New fileStats(arguments.rootPath, onlyAFile, util);
		return fileStatsObj.getLineCountsAll();
	}
	
	remote numeric function getGrandTotal(required string rootPath){
		var util = New util();
		var onlyAFile = util.isOnlyAFile(arguments.rootPath);
		var fileStatsObj = New fileStats(arguments.rootPath, onlyAFile, util);
		return fileStatsObj.getGrandTotal();
	}
	
	remote query function getLinesByExtension(required string rootPath){
		var util = New util();
		var onlyAFile = util.isOnlyAFile(arguments.rootPath);
		var fileStatsObj = New fileStats(arguments.rootPath, onlyAFile, util);
		return fileStatsObj.getLinesByExtension();
	}
	
	remote query function getLinesByDirectory(required string rootPath){
		var util = New util();
		var onlyAFile = util.isOnlyAFile(arguments.rootPath);
		var fileStatsObj = New fileStats(arguments.rootPath, onlyAFile, util);
		return fileStatsObj.getLinesByDirectory();
	}


}
