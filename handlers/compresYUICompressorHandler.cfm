<!---
Name:			compresYUICompressorHandler.cfm
Author:			Guust Nieuwenhuis (info@lagaffe.be)
Description:	Logic that calls the YUICompressor.cfc and passes all the information
Last update:	29/04/2010
--->

<cfoutput>

	<cfparam name="ideeventinfo" default="" />
	<cfparam name="session.ideeventinformation" default="" />

	<cfparam name="form.linebreak" default="-1" />
	<cfparam name="form.munge" default="false" />
	<cfparam name="form.verbose" default="false" />
	<cfparam name="form.preserveAllSemiColons" default="false" />
	<cfparam name="form.disableOptimizations" default="false" />

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
	
		/* Set the linebreak to '-1' of it's not set by the user */
		if(NOT Len(form.linebreak))
		{
			form.linebreak = "-1";
		}
		
		/* Create a YUICompressor object */
		compressor = createObject("component", "YUICompressor");
		compressor.init(javaLoader = 'javaloader.JavaLoader', libPath = expandPath('./lib'));
		
		/* Define the filename */
		filename = "";
		if(form.outputsettings EQ "SAVE")
		{
			filename = project.resource.path;
		}
		else
		{
			thisDirectory = GetDirectoryFromPath(project.resource.path);
			filename = thisDirectory & form.saveasfile;
		}
		
		/* Compressor the file */
		compressed = compressor.compress(
						inputFilePath = project.resource.path, 
						outputFilePath = filename,
						linebreak = form.linebreak,
						munge = form.munge,
						verbose = form.verbose,
						preserveAllSemiColons = form.preserveAllSemiColons,
						disableOptimizations = form.disableOptimizations
						);
	</cfscript>

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
			The file has been successfully compiled...
			]]> 
			</body> 
		</ide> 
	</response>
</cfoutput>