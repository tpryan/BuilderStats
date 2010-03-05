component{
	
	/**
     * @hint = Psuedo constructor
     */
	public util function init(){
    	variables.FS = createObject("java", "java.lang.System").getProperty("file.separator");	
    	return This;
    }
    
	
	/**
     * @hint = Counts the number of lines in a passed in file, ignoring blank lines
     */
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
	
	/**
     * @hint = Counts the number of lines in a passed in file, ignoring blank lines
     */
	public string function MakeRelativeFilePath(required string filePath, required string rootPath){
		var result = ReplaceNoCase(arguments.filePath, arguments.rootPath, "", "once");
		if (len(result) eq 0){
			result = FS;
		}
		return result;
	}

	/**
     * @hint = Determines if a passed in path is a file or a directory.
     */
	public boolean function isOnlyAFile(required string rootPath){
		if (not DirectoryExists(arguments.rootPath) and fileExists(arguments.rootPath)){
			return true;
		}
		else{
			return false;
		}
	}

}
