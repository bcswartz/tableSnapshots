
<cfcomponent output="false">
	<cfset this.name = hash( getCurrentTemplatePath() ) />
	<cfset this.applicationTimeout = createTimeSpan(0,5,0,0)>
	<cfset this.clientManagement = true>
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,1,0,0)>

	<cffunction name="onApplicationStart" returnType="boolean" output="true">
		<cfreturn true />
	</cffunction>
	
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>
	
	
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		
		<!---CONFIGURATION SETTINGS--->
		<cfset application.args= StructNew()>
		<cfset application.args.datasource= "cfartgallery"> 
		<!---Allowed filterTypes:  prefix or suffix--->
		<cfset application.args.tableFilterType= "">  
		<cfset application.args.tableFilterValue= "">
		<!---Choose any character for the nameDelimiter EXCEPT for a comma--->
		<cfset application.args.nameDelimiter= "_">  
		<cfset application.args.JSONSerializer= "JSONUtil"> 
		<cfset application.args.JSONDeserializer= "JSONNativeCF"> 
		<cfset application.args.snapshotsFolder= "snapshots">
		<cfset application.args.backupsFolder= "backups">
		<cfset application.args.requesttimeout= 2400>
		<cfset application.args.loopLimit= 100>
		<cfset application.args.insertThreadLimit= 10>
		<cfif StructKeyExists(application,"snapshotService") EQ false OR StructKeyExists(url,"appReset")>
			<cfset application.tableMetadata= StructNew()>
			<cfset application.snapshotService= CreateObject("component","snapshotService").init(argumentCollection=application.args)>
		</cfif>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="onRequest" returnType="void">
		<cfargument name="thePage" type="string" required="true">
		<cfinclude template="#arguments.thePage#">
	</cffunction>

	<cffunction name="onError"> 
    	<cfargument name="exception" type="any" required="true" /> 
    	<cfargument name="eventName" type="string" required="true" />
	    <cfif NOT (arguments.eventName IS "onSessionEnd") OR  (arguments.eventName IS "onApplicationEnd")> 
	        <cfinclude template="views/dspError.cfm" />
	    </cfif> 
	</cffunction>

</cfcomponent>