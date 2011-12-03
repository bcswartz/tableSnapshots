<cfsetting requesttimeout="#application.args.requesttimeout#">
<cfparam name="url.event" default="">

<cfinclude template="header.cfm">
<cfset startTime= getTickCount()>

<cfswitch expression="#url.event#">
	
	<!---Snapshot events--->
	<cfcase value="generateSnapshots">
		<!---If you want to change the table filter type and value without resetting the application scope, you can 
		pass them in as name parameters in an argument collection--->
		<cfset tableQry= application.snapshotService.getTableList()>
		<cfquery name="sortedQry" dbtype="query">
			select table_name
			from tableQry
			order by table_name ASC
		</cfquery>
		<cfinclude template="views/dspGenerateSnapshots.cfm" />
	</cfcase>
	
	<cfcase value="createSnapshots">
		<cfparam name="form.snaps" default="">
		<cfset args= StructNew()>
		<cfset args.tableList= form.snaps>
		<cfset args.formData= form>
		<cfset application.snapshotService.takeTableSnapshots(argumentCollection=args)>
		<cfinclude template="views/dspCreateSnapshots.cfm" />
	</cfcase>
	
	<cfcase value="listSnapshots">
		<cfset snapQry= application.snapshotService.getSnapshotList()>
		<cfquery name="sortedQry" dbtype="query">
			select name, dateLastModified
			from snapQry
			order by name ASC, dateLastModified DESC
		</cfquery>
		<cfinclude template="views/dspListSnapshots.cfm" />
	</cfcase>
	
	<cfcase value="viewSnapshot">
		<cfset snapshotTable= application.snapshotService.getSnapshotHTMLTable(url.f)>
		<cfset dataTypeTitle= "Snapshot">
		<cfset dataType= "snapshot">
		<cfinclude template="views/dspViewSnapshot.cfm" />
	</cfcase>
	
	<cfcase value="loadSnapshots">
		<cfparam name="form.loads" default="">
		<cfset args= StructNew()>
		<cfset args.snapshotList= form.loads>
		<p>Loading snapshot(s), please wait...</p><cfflush />
		<cfset errArray= application.snapshotService.loadSnapshots(argumentCollection=args)>
		<cfinclude template="views/dspLoadSnapshots.cfm" />
	</cfcase>
	
	<cfcase value="listSnapshotsToDelete">
		<cfset snapQry= application.snapshotService.getSnapshotList()>
		<cfquery name="sortedQry" dbtype="query">
			select name, dateLastModified
			from snapQry
			order by name ASC, dateLastModified DESC
		</cfquery>
		<cfinclude template="views/dspListSnapshotsToDelete.cfm" />
	</cfcase>
	
	<cfcase value="deleteSnapshots">
		<cfparam name="form.deletes" default="">
		<cfset application.snapshotService.deleteSnapshots(form.deletes)>
		<cfinclude template="views/dspDeleteSnapshots.cfm" />
	</cfcase>
	
	<!---Backup events--->
	<cfcase value="listBackups">
		<cfset snapQry= application.snapshotService.getSnapshotList("backups")>
		<cfquery name="sortedQry" dbtype="query">
			select name, dateLastModified
			from snapQry
			order by name ASC, dateLastModified DESC
		</cfquery>
		<cfinclude template="views/dspListBackups.cfm" />
	</cfcase>
	
	<cfcase value="viewBackup">
		<cfset snapshotTable= application.snapshotService.getSnapshotHTMLTable(url.f,"backups")>
		<cfset dataTypeTitle= "Backup">
		<cfset dataType= "backup">
		<cfinclude template="views/dspViewSnapshot.cfm" />
	</cfcase>
	
	<cfcase value="loadBackups">
		<cfparam name="form.loads" default="">
		<cfset args= StructNew()>
		<cfset args.snapshotList= form.loads>
		<cfset args.type= "backups">
		<p>Loading backup(s), please wait...</p><cfflush />
		<cfset errArray= application.snapshotService.loadSnapshots(argumentCollection=args)>
		<cfinclude template="views/dspLoadSnapshots.cfm" />
	</cfcase>
	
	<cfcase value="listBackupsToDelete">
		<cfset snapQry= application.snapshotService.getSnapshotList("backups")>
		<cfquery name="sortedQry" dbtype="query">
			select name, dateLastModified
			from snapQry
			order by name ASC, dateLastModified DESC
		</cfquery>
		<cfinclude template="views/dspListBackupsToDelete.cfm" />
	</cfcase>
	
	<cfcase value="deleteBackups">
		<cfparam name="form.deletes" default="">
		<cfset application.snapshotService.deleteSnapshots(form.deletes,"backups")>
		<cfinclude template="views/dspDeleteBackups.cfm" />
	</cfcase>
	
	<!---Reset and informational events--->
	<cfcase value="reset">
		<cflocation url="index.cfm?appReset=true" addtoken="no" />
	</cfcase>
	
	<cfcase value="gettingStarted">
		<cfinclude template="views/dspGettingStarted.cfm" />
	</cfcase>
	
	<cfcase value="technicalDetails">
		<cfinclude template="views/dspTechnicalDetails.cfm" />
	</cfcase>
	
	<cfcase value="useCases">
		<cfinclude template="views/dspUseCases.cfm" />
	</cfcase>
	
	<cfcase value="credits">
		<cfinclude template="views/dspCredits.cfm" />
	</cfcase>
	
	<cfdefaultcase>
		<cfinclude template="views/dspHome.cfm" />
	</cfdefaultcase>
	
</cfswitch>

<cfset endTime= getTickCount()>
<cfinclude template="footer.cfm" >
