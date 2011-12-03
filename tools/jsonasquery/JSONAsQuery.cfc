<cfcomponent displayname="JSONAsQuery" hint="I return the data in a JSON file as a CF query object">
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="jsonLibrary" type="string" required="true">
		<cftry>
			<cfset variables.jsonLibrary= CreateObject("component",arguments.jsonLibrary)>
			<cfcatch type="any">
				<cfthrow message="The specified JSON library CFC was not found.">
			</cfcatch>
		</cftry>
		<cfreturn this />
	</cffunction>
	
	<cffunction name="alterSelectedTable" access="private" returntype="query" output="false">
		<cfargument name="qry" type="query" required="true" />
		<!---Transform the query or query data in some fashion, then return the result--->
		<cfreturn arguments.qry />
	</cffunction>
	
	<cffunction name="returnAsQuery" access="public" returntype="query" output="false">
		<cfargument name="tableName" type="string" required="true" />
		<cfargument name="dataFolder" type="string" required="true" />
		<cfargument name="dataFile" type="string" required="true" />
		<cfset var fileContent= "">
		<cfset var buildStruct= "">
		<cfset var fieldList= "">
		<cfset var qry= "">
		<cfset var r= "">
		<cfset var field= "">
		   
		<cffile action="read" file="#arguments.dataFolder#/#arguments.dataFile#" variable="fileContent">
		
		<cfset buildStruct= variables.jsonLibrary.deserializeFromJSON(fileContent)>
		<cfloop collection="#buildStruct.data#" item="field">
			<cfset fieldList= ListAppend(fieldList,field)>
		</cfloop>
		
		<cfset qry= queryNew(fieldList)>
		
		<cfloop index="r" from="1" to="#buildStruct.rowcount#">
			<cfset queryAddRow(qry,1)>
			<cfloop collection="#buildStruct.data#" item="field">
				<cfset querySetCell(qry,field,buildStruct.data[field][r])>
			</cfloop>
		</cfloop>
		
		<cfswitch expression="#arguments.tableName#">
			<cfcase value="queryDataNeedsAdjustment">
				<cfreturn alterSelectedTable(qry) />
			</cfcase>
			<cfdefaultcase>
				<cfreturn qry />
			</cfdefaultcase>
		</cfswitch>  
	
	</cffunction>

	

</cfcomponent>