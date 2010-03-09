<cfsetting showdebugoutput="FALSE" />

<cfscript>
	xmldoc = XMLParse(ideeventInfo); 
	rootFilePath = XMLDoc.event.ide.projectview.resource.XMLAttributes.path;
	
	BaseURL = "http://" & cgi.server_name & ":" & cgi.server_port;
	wsdl = BaseURL & getDirectoryFromPath(cgi.script_name) & "/wsdlCFCStats.cfm";
	handlerPath = getDirectoryFromPath(cgi.script_name) & "/flash/CFCStats.swf###CreateUUID()#";
	handlerOptions = "?rootpath=#rootFilePath#&amp;wsdl=#wsdl#";
	handlerURL = BaseURL & handlerPath & handlerOptions;
	writeLog(handlerURL);
</cfscript>	

<cfheader name="Content-Type" value="text/xml">
<cfoutput> 
<response showresponse="true"> 
	<ide url="#handlerURL#" > 
		<dialog width="855" height="700" /> 
	</ide> 
</response> 
</cfoutput>
