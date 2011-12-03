<cfcomponent displayname="JSONNativeCF" hint="Uses the built-in CF JSON functions in CF8 and higher">

	<cffunction name="deserializeFromJSON" access="public" output="false" returntype="any">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="strictMapping" type="boolean" required="false" default="true" />
		
		<cfreturn deserializeJson(arguments.data,arguments.strictMapping) />
	</cffunction>
	
	<cffunction name="serializeToJSON" access="public" output="false" returntype="string">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="serializeQueryByColumns" type="boolean" required="false" default="true" />
		
		<cfreturn serializeJson(arguments.data,arguments.serializeQueryByColumns) />
	
	</cffunction>
	
</cfcomponent>