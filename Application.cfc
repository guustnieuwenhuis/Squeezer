
<cfcomponent >

	<cfscript>
	this.name = "Closure Compiler Extension";
	this.sessionManagement = true;
	</cfscript>
	
	<cffunction name="onRequestStart" returnRequest="boolean" output="false">
		<cfsetting showdebugoutput="false" enablecfoutputonly="false" />
	</cffunction>
	
</cfcomponent>
