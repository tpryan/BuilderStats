<cfsetting showdebugoutput="FALSE" />
<cfflush interval="1" />


<cfscript>

	xmldoc = XMLParse(ideeventInfo); 
	rootFilePath = XMLDoc.event.ide.projectview.resource.XMLAttributes.path;
	
	
	handlerPath = getDirectoryFromPath(cgi.script_name) & "/displayStats.cfm";
	handlerOptions = "?rootFilePath=#URLEncodedFormat(rootFilePath)#";
	handlerURL = "http://" & cgi.server_name & handlerPath & handlerOptions;
	
	
</cfscript>	



<cfheader name="Content-Type" value="text/xml">
<cfoutput> 
<response showresponse="true"> 
	<ide url="#handlerURL#" > 
		<dialog width="655" height="700" /> 
	</ide> 
</response> 
</cfoutput>


