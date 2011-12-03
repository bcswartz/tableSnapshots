<cfcomponent displayname="oracle" hint="I am responsible for translating Oracle field types">

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="returnInsertParams" access="public" output="false" returntype="struct">
		<cfargument name="fieldType" type="string" required="true" />
		<cfargument name="nullable" type="string" required="true" />
		<cfargument name="fieldValue" type="any" required="true" />
		<cfset var insertParams= StructNew()>
		<cfset insertParams.sqlType= "cf_sql_varchar">
		
		<!---Data type notes:
				--The JSONUtil library, when used in strictMapping as it is in this tool, cannot process float, real, or double-precision fields if they are null/empty:  the snapshot will not be generated and an error will be thrown.  They work fine if all those fields in your table contain data.
				--Binary fields cannot be handled
				--The decimal data type is reported by cfdbinfo as being "number"
		--->
		
		<cfswitch expression="#arguments.fieldType#">
			
			<!---Numeric fields--->
			<cfcase value="number,float">
				<cfif ListLen(arguments.fieldValue,".") GT 1>
					<cfset insertParams.scale= Len(ListGetAt(arguments.fieldValue,2,"."))>
				</cfif>
			</cfcase>
			
			<!---Date/time fields--->
			<cfcase value="date">
				<cfset insertParams.sqlType="cf_sql_date" />
			</cfcase>
			
			<cfcase value="timestamp">
				<cfset insertParams.sqlType="cf_sql_timestamp" />
			</cfcase>
			
			<!---Text fields--->
			<cfcase value="clob">            
            	<cfset insertParams.sqlType="cf_sql_clob" />            
            </cfcase>
            
            <cfcase value="long">            
            	<cfset insertParams.sqlType="cf_sql_longvarchar" />            
            </cfcase>
            
            <cfcase value="varchar2,char,nchar,nvarchar2">
            	<cfset insertParams.sqlType="cf_sql_varchar" />            
            </cfcase>
            
		</cfswitch>
		<!---Default type is then cf_sql_varchar--->
		
		<cfif arguments.nullable>
			<!---In case you use another JSON-conversion library that records empty values as the string "null"--->
			<cfif insertParams.sqlType EQ "cf_sql_varchar" and arguments.fieldValue EQ "null">
				<cfset insertParams.isNull= true>
			<cfelseif arguments.fieldValue EQ "">
				<cfset insertParams.isNull= true>
			<cfelse>
				<cfset insertParams.isNull= false>
			</cfif>
		<cfelse>
			<cfset insertParams.isNull= false>
		</cfif>
		
		<!---In case you need to transform the data value under certain conditions--->
		<cfset insertParams.value= arguments.fieldValue />
		
		<cfreturn insertParams />
	</cffunction>
	
</cfcomponent>