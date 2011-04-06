<!---
Name:			compresYUICompressor.cfm
Author:			Guust Nieuwenhuis (info@lagaffe.be)
Description:	Save the userinput in the application scope and load the interface
Last update:	29/04/2010
--->

<cfoutput>

	<cfparam name="ideeventinfo" >
	
	<!--- Set the appId --->
	<cflock scope="Application" timeout="10">
		<cfset application.appId = (isdefined("application.appId")?application.appId : 0) + 1 />
	</cflock>
	
	<cfscript>
		application[application.appId] = ideeventinfo;
		
		baseURL = "http://" & cgi.server_name & ":" & cgi.server_port;
		messagesPath = getDirectoryFromPath(cgi.script_name) & "/compresYUICompressorView.cfm";
		messagesOptions = "?id=" & application.appId;
		messagesURL = baseURL & messagesPath & messagesOptions;
	</cfscript>	

	<!--- Load the interface --->
	<cfheader name="Content-Type" value="text/xml">
	<response showresponse="true"> 
		<ide url="#messagesURL#" > 
			<dialog width="100%" height="650" /> 
		</ide> 
	</response>
</cfoutput>