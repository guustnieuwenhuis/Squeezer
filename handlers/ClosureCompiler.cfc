/*
Name:			ClosureCompiler.cfc
Author:			Guust Nieuwenhuis (info@lagaffe.be)
Description:	Component that handels the compilation of JavaScript with Google's Closure Compiler
Last update:	29/04/2010
*/

/**
* "Compile JavaScipt code to better JavaScript"
* @displayname Closure Compiler
* @output no
* @accessors true
**/
component 
{
	// PROPERTIES
	
	/**
	* Level op optimalization <br />
	* Check "compilationLevelOptions" for the allowed options
	* @type String
	* @required no
	* @getter true
	* @setter true
	* @validate string
	* @default "SIMPLE_OPTIMIZATIONS"
	**/
	property compilationLevel;
	
	/**
	* List with the allowed options for "compilationLevel"
	* @type String
	* @required no
	* @getter true
	* @setter true
	* @validate string
	* @default "WHITESPACE_ONLY,SIMPLE_OPTIMIZATIONS,ADVANCED_OPTIMIZATIONS"
	**/
	property compilationLevelOptions;
	
	/**
	* Externs
	* @type String
	* @required no
	* @getter true
	* @setter true
	* @validate string
	* @default ""
	**/
	property externs;
	
	
	// CONSTRUCTOR
	/**
	* Compilor function
	* @access public
	* @returnType ClosureCompiler
	**/
	function init()
	{
		this.setCompilationLevelOptions("WHITESPACE_ONLY,SIMPLE_OPTIMIZATIONS,ADVANCED_OPTIMIZATIONS");
		this.setCompilationLevel("SIMPLE_OPTIMIZATIONS");
		this.setExterns("");
		
		return this;
	}
	
	
	// GETTERS AND SETTERS
	/**
	* Set the level op optimalization ("compilationLevel") <br />
	* Check "compilationLevelOptions" for the allowed options
	* @access public
	* @returnType void
	**/
	function setCompilationLevel(String compilationLevel)
	{
		if(ListFind(this.getCompilationLevelOptions(), arguments.compilationLevel))
		{
			variables.compilationLevel = arguments.compilationLevel;
		}
	}
	
	
	// PRIVATE FUNCTIONS
	
	
	// PUBLIC FUNCTIONS
	/**
	* Compile function
	* @access public
	* @returnType String
	**/
	function compile(source)
	{
		local.paths = arrayNew(1);
		local.paths[1] = expandPath("lib/compiler.jar");

		//create the loader
		local.loader = createObject("component", "javaloader.JavaLoader").init(local.paths);

		local.compiler = local.loader.create("com.google.javascript.jscomp.Compiler");
		local.instance = local.compiler.init();
		
		local.options = local.loader.create("com.google.javascript.jscomp.CompilerOptions").init();
		local.level = local.loader.create("com.google.javascript.jscomp.CompilationLevel");
		
		Evaluate("local.level.#this.getCompilationLevel()#.setOptionsForCompilationLevel(local.options)");

		local.jsfile = local.loader.create("com.google.javascript.jscomp.JSSourceFile");
		local.extern = local.jsfile.fromCode("externs.js", "#this.getExterns()#");
		local.jscript = local.jsfile.fromCode("input.js", "#arguments.source#");
		local.result = local.instance.compile(local.extern, local.jscript, local.options);
		
		return local.instance;
	}

}