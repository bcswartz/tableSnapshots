<cfcomponent displayname="apacheDerby" hint="I am responsible for translating Apache Derby field types">

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="returnInsertParams" access="public" output="false" returntype="struct">
		<cfargument name="fieldType" type="string" required="true" />
		<cfargument name="nullable" type="string" required="true" />
		<cfargument name="fieldValue" type="any" required="true" />
		<cfset var insertParams= StructNew()>
		<cfset insertParams.sqlType= "cf_sql_varchar">
		
		<cfswitch expression="#arguments.fieldType#">
			
			<!---Numeric fields--->
			<cfcase value="integer,smallInt,float,real,double">
				<cfset insertParams.sqlType="cf_sql_numeric" />
			</cfcase>
			
			<cfcase value="decimal">
				<cfset insertParams.sqlType="cf_sql_decimal" />
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