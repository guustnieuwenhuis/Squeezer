<!---
Name:			compileClosureCompilerHandler.cfm
Author:			Guust Nieuwenhuis (info@lagaffe.be)
Description:	Logic that calls the ClosureCompiler.cfc and passes all the information
Last update:	29/04/2010
--->

<cfoutput>

	<cfparam name="ideeventinfo" default="" />
	<cfparam name="session.ideeventinformation" default="" />
	
	<cfscript>
		/* Get the input from the user */
		xmldoc = xmlParse(application[#url.id#]);
		projectview = xmlSearch(xmldoc,"//projectview");
		projectresourceview = xmlSearch(xmldoc,"//projectview/resource");
		response = xmlSearch(xmldoc,"//user");
		
		system = createObject("java", "java.lang.System");
		fileSeparator = system.getProperty("file.separator");
		
		/* Project details */
		project = structNew();
		project.name = projectview[1].xmlAttributes["projectname"];
		project.location = projectview[1].xmlAttributes["projectlocation"];
		project.resource = structNew();
		project.resource.path = projectresourceview[1].xmlAttributes["path"];
		project.resource.type = projectresourceview[1].xmlAttributes["type"];
	</cfscript>
	
	<!--- Read file --->
	<cffile action="read" file="#project.resource.path#" variable="js" /> 
	
	<cfscript>
		/* Create a ClosureCompiler object */
		compiler = createObject("component", "ClosureCompiler").init();
		
		/* Set the compilation level */
		compiler.setCompilationLevel(form.compilationlevel);

		/* Check if the user has passed */
		if(form.compilationlevel == "ADVANCED_OPTIMIZATION" && StructKeyExists(form, "externs"))
		{
			compiler.setExterns(form.externs);
		}
		
		/* Compile the content of the file */
		compileResult = compiler.compile(js);
		
		/* Define the filename */
		filename = "";
		if(form.outputsettings == "SAVE")
		{
			filename = project.resource.path;
		}
		else
		{
			thisDirectory = GetDirectoryFromPath(project.resource.path);
			filename = thisDirectory & form.saveasfile;
		}
	</cfscript>

	<cfif NOT ArrayLen(compileResult.getErrors()) >
		<!--- Write file --->
		<cffile action="write" file="#filename#" output="#compileResult.toSource()#" />
		<cfsavecontent variable="message">
			The file has been successfully compiled...
			<cfif ArrayLen(compileResult.getWarnings())>
				<hr />
				<p>
					Warnings (#ArrayLen(compileResult.getWarnings())#):
				</p>
				<cfloop from="1" to="#ArrayLen(compileResult.getWarnings())#" index="i">
					<p>
						Warning: #compileResult.getWarnings()[i].description#<br />
						Line: #compileResult.getWarnings()[i].lineNumber#
					</p>
				</cfloop>
			</cfif>
		</cfsavecontent>
	<cfelse>
		<cfsavecontent variable="message">
			<p>
				Google's Closure Compiler has found one or more bugs in your code...
			</p>
			<hr />
			<p>
				Errors (#ArrayLen(compileResult.getErrors())#):
			</p>
			<cfloop from="1" to="#ArrayLen(compileResult.getErrors())#" index="i">
				<p>
					Error: #compileResult.getErrors()[i].description#<br />
					Line: #compileResult.getErrors()[i].lineNumber#
				</p>
			</cfloop>
			<hr />
			<p>
				Warnings (#ArrayLen(compileResult.getWarnings())#):
			</p>
			<cfloop from="1" to="#ArrayLen(compileResult.getWarnings())#" index="i">
				<p>
					Warning: #compileResult.getWarnings()[i].description#<br />
					Line: #compileResult.getWarnings()[i].lineNumber#
				</p>
			</cfloop>
		</cfsavecontent>
	</cfif>

	<!--- IDE-response --->
	<cfheader name="Content-Type" value="text/xml">
	<response showresponse="true"> 
		<ide> 
			<!--- Refresh the project folder in the navigator --->
		    <commands> 
				<command type="refreshproject"> 
					<params> 
						<param key="projectname" value="#project.name#" /> 
					</params> 
				</command> 
		    </commands> 
		</ide> 
		<ide> 
			<!--- Let the user know everything went well... --->
			<dialog width="100%" height="650" /> 
			<body>
			<![CDATA[ 
			#message#
			]]> 
			</body> 
		</ide> 
	</response>
</cfoutput>