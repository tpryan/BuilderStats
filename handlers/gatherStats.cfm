<cfsetting showdebugoutput="FALSE" />
<!---<cfflush interval="1" />--->


<cfscript>

	xmldoc = XMLParse(ideeventInfo); 
	rootFilePath = XMLDoc.event.ide.projectview.resource.XMLAttributes.path;
	
	BaseURL = "http://" & cgi.server_name & ":" & cgi.server_port;
	handlerPath = getDirectoryFromPath(cgi.script_name) & "/displayStats.cfm";
	handlerOptions = "?rootFilePath=#URLEncodedFormat(rootFilePath)#&amp;r=#urlEncodedFormat(createUUID())#";
	handlerURL = BaseURL & handlerPath & handlerOptions;
	
	
</cfscript>	

<cfheader name="Content-Type" value="text/xml">
<cfoutput> 
<response showresponse="true"> 
	<ide url="#handlerURL#" > 
		<dialog width="655" height="700" /> 
	</ide> 
</response> 
</cfoutput>


