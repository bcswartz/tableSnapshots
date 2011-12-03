<cfcomponent displayname="mysql" hint="I am responsible for translating MySQL field types">

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
				--Blob fields will not work.
				--Date, Datetime, and Year data types do not work, but Time and Timestamp do (not sure if this might just be a JDBC driver issue)
		--->
		
		<cfswitch expression="#arguments.fieldType#">
			
			<!---Numeric fields--->
			<cfcase value="int,bigint,smallint">
				<cfset insertParams.sqlType="cf_sql_numeric" />
			</cfcase>
			
			<cfcase value="float,decimal">
				<cfset insertParams.sqlType="cf_sql_float" />
			</cfcase>
			
			<cfcase value="real">
				<cfset insertParams.sqlType="cf_sql_real" />
			</cfcase>
			
			<cfcase value="double">
				<cfset insertParams.sqlType="cf_sql_double" />
			</cfcase>
			
			<!---Tinyint is the type detected for both tinyint fields and Boolean--->
			<cfcase value="tinyint">            
            	<cfset insertParams.sqlType="cf_sql_tinyint" />            
            </cfcase>	
				
			<!---Date/time fields--->
			<cfcase value="time">
				<cfset insertParams.sqlType="cf_sql_time" />
			</cfcase>	
				
			<cfcase value="timestamp">
				<cfset insertParams.sqlType="cf_sql_timestamp" />
			</cfcase>
			
			<!---Text fields--->
            <cfcase value="long">            
            	<cfset insertParams.sqlType="cf_sql_longvarchar" />            
            </cfcase>
            
            <cfcase value="varchar,text,char">
            	<cfset insertParams.sqlType="cf_sql_varchar" />            
            </cfcase>
            
            <!---Misc--->
			<cfcase value="bit">            
            	<cfset insertParams.sqlType="cf_sql_bit" />            
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