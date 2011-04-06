<!---
Name:			compileClosureCompilerView.cfm
Author:			Guust Nieuwenhuis (info@lagaffe.be)
Description:	Interface for the settings
Last update:	29/04/2010
--->

<cfoutput>

	<script type="text/javascript" src="jquery.js"></script>
	<script type="text/javascript" src="compileClosureCompilerView.js"></script>
	<link rel="stylesheet" type="text/css" href="style.css" />

	<form action="compileClosureCompilerHandler.cfm?id=#URL.id#" method="POST" accept-charset="utf-8">
		<fieldset>
		<legend>Output details</legend>
			<div id="divOutputsettingsSave" class="input">
				<input id="radOutputsettingsSave" type="radio" name="outputsettings" value="SAVE" />
				Save
			</div>
			<div id="divOutputsettingsSaveas" class="input">
				<input id="radOutputsettingsSaveas" type="radio" name="outputsettings" value="SAVEAS" />
				Save as
			</div>
			<div id="divOutputsettingsSaveasFile" class="subinput">
				<div id="lblOutputsettingsSaveasFile" class="label">
					File: 
				</div>
				<input id="txtOutputsettingsSaveasFile" type="text" name="saveasfile" value="" />
			</div>
		</fieldset>

		<fieldset>
		<legend>Closure Compiler settings</legend>
			<div id="divCompilationlevelWhitespace" class="input">
				<input id="radCompilationlevelWhitespace" type="radio" name="compilationlevel" value="WHITESPACE_ONLY" />
				Whitespace only
			</div>
			<div id="divCompilationlevelSimple" class="input">
				<input id="radCompilationlevelSimple" type="radio" name="compilationlevel" value="SIMPLE_OPTIMIZATION" />
				Simple optimization
			</div>
			<div id="divCompilationlevelAdvanced" class="input">
				<input id="radCompilationlevelAdvanced" type="radio" name="compilationlevel" value="ADVANCED_OPTIMIZATION" />
				Advanced optimization
			</div>
			<div id="divCompilationlevelAdvancedExterns" class="subinput">
				<div id="lblCompilationlevelAdvancedExterns" class="label">
					Externs: 
				</div>
				<input id="txtCompilationlevelAdvancedExterns" type="text" name="externs" value="" />
			</div>
		</fieldset>

		<p>
			<input id="btnSubmit" type="submit" value="Squeeze" />
		</p>
	</form>

</cfoutput>