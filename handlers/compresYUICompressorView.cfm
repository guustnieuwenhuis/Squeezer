<!---
Name:			compresYUICompressorView.cfm
Author:			Guust Nieuwenhuis (info@lagaffe.be)
Description:	Interface for the settings
Last update:	29/04/2010
--->

<cfoutput>

	<script type="text/javascript" src="jquery.js"></script>
	<script type="text/javascript" src="compresYUICompressorView.js"></script>
	<link rel="stylesheet" type="text/css" href="style.css" />

	<form action="compresYUICompressorHandler.cfm?id=#URL.id#" method="POST" accept-charset="utf-8">
		<p id="errorMsg" class="error">
			
		</p>
		
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
		<legend>YUI Compressor settings</legend>
			<div id="divLinebreak" class="input">
				<div id="lblLinebreak" class="label">
					Linebreak: 
				</div>
				<input id="txtLinebreak" type="text" name="linebreak" value="" />
			</div>
			<div id="divMunge" class="input">
				<input id="chkMunge" type="checkbox" name="munge" value="true" />
				Munge
			</div>
			<div id="divVerbose" class="input">
				<input id="chkVerbose" type="checkbox" name="verbose" value="true" />
				Verbose
			</div>
			<div id="divPreserveAllSemiColons" class="input">
				<input id="chkPreserveAllSemiColons" type="checkbox" name="preserveAllSemiColons" value="true" />
				Preserve all semi colons
			</div>
			<div id="divDisableOptimizations" class="input">
				<input id="chkDisableOptimizations" type="checkbox" name="disableOptimizations" value="true" />
				Disable optimizations
			</div>
		</fieldset>

		<p>
			<input id="btnSubmit" type="submit" value="Squeeze" />
		</p>
	</form>

</cfoutput>