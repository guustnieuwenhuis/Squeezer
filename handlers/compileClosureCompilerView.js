/*
Name:			compileClosureCompilerView.js
Author:			Guust Nieuwenhuis (info@lagaffe.be)
Description:	Javascript code for the handling of the form in the interface
Last update:	29/04/2010
*/

/* When page in load */
$(document).ready(function(){
	/* Set the default settings */
	$("#radOutputsettingsSave").attr("checked","checked");
	$("#radCompilationlevelSimple").attr("checked","checked");
	disableSaveasFile();
	disableAdvancedExterns();
	
	/* Add click-handlers to the form */
	$("#radOutputsettingsSave").click(function(event)
	{
		disableSaveasFile();
	});
	
	$("#radOutputsettingsSaveas").click(function(event)
	{
		enableSaveasFile();
	});
	
	$("#radCompilationlevelSimple").click(function(event)
	{
		disableAdvancedExterns();
	});
	
	$("#radCompilationlevelWhitespace").click(function(event)
	{
		disableAdvancedExterns();
	});
	
	$("#radCompilationlevelAdvanced").click(function(event)
	{
		enableAdvancedExterns();
	});
	
	/* Form checks */
	$("#btnSubmit").click(function(event)
	{
		var returnvalue = true;
		var errormsg = "";
		$("#errorMsg").text('');
		
		/* Check the length of the filename when 'SaveAs' */
		if($("#radOutputsettingsSaveas").attr("checked"))
		{
			if($("#txtOutputsettingsSaveasFile").val().length == 0)
			{
				errormsg += "Please specify a file name!";
				returnvalue =  false;
			}
		}
		
		if(!returnvalue)
		{
			/* show error message */
			$("#errorMsg").text(errormsg);

			/* Cancel form submit */
			event.preventDefault();
			return false;
		}
		
		/* Submit form */
		return true;
	});
});

function enableSaveasFile()
{
	$("#txtOutputsettingsSaveasFile").removeAttr("disabled");
	$("#lblOutputsettingsSaveasFile").css("color","");
}

function disableSaveasFile()
{
	$("#txtOutputsettingsSaveasFile").attr("disabled","disabled");
	$("#lblOutputsettingsSaveasFile").css("color","grey");
}

function enableAdvancedExterns()
{
	$("#txtCompilationlevelAdvancedExterns").removeAttr("disabled");
	$("#lblCompilationlevelAdvancedExterns").css("color","");
}

function disableAdvancedExterns()
{
	$("#txtCompilationlevelAdvancedExterns").attr("disabled","disabled");
	$("#lblCompilationlevelAdvancedExterns").css("color","grey");
}
