<cfcomponent hint="I manage the task of creating snapshots of table content">

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="datasource" type="string" required="true" />
		<cfargument name="nameDelimiter" type="string" required="true">
		<cfargument name="JSONSerializer" type="string" required="true" />
		<cfargument name="JSONDeserializer" type="string" required="true" />
		<cfargument name="tableFilterType" type="string" required="true" hint="Possible values: prefix, suffix, or empty string" />
		<cfargument name="tableFilterValue" type="string" required="true" />
		<cfargument name="snapshotsFolder" type="string" required="true" />
		<cfargument name="backupsFolder" type="string" required="true" />
		<cfargument name="loopLimit" type="numeric" required="true" />
		<cfargument name="insertThreadLimit" type="numeric" required="true" />
		<cfset var qryDatabaseInfo= "" />
		<cfset variables.datasource= arguments.datasource>
		<cfset variables.nameDelimiter= arguments.nameDelimiter>
		<cftry>
			<cfset variables.JSONSerializer= CreateObject("component",arguments.JSONSerializer)>
			<cfset variables.JSONDeserializer= CreateObject("component",arguments.JSONDeserializer)>
			<cfcatch type="any">
				<cfthrow message="One or more of the specified JSON library CFCs was not found.">
			</cfcatch>
		</cftry>
		
		<cfset variables.tableFilterType= arguments.tableFilterType>
		<cfset variables.tableFilterValue= arguments.tableFilterValue>
		
		<cfif arguments.datasource NEQ "">
			<cfdbinfo type="version" name="qryDatabaseInfo" datasource="#arguments.datasource#">
			<cftry>
				<cfset variables.dbaseLibrary= CreateObject("component",Replace(qryDatabaseInfo.database_productname," ","","ALL"))>
				<cfcatch type="any">
					<cfthrow message= "There is no database library file named #qryDatabaseInfo.database_productname#.cfc to handle database type-specific functions.">
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfset variables.baseFolder= getDirectoryFromPath(getCurrentTemplatePath())>
		<cfset variables.snapshotsFolder= variables.baseFolder &  arguments.snapshotsFolder />
		<cfset variables.backupsFolder= variables.baseFolder & arguments.backupsFolder />
		<cfset variables.loopLimit= arguments.loopLimit />
		<cfset variables.insertThreadLimit= arguments.insertThreadLimit />
		
		<cfset variables.tableHasError= false>
		<cfset variables.threadErrorArray= ArrayNew(1)>
		<cfset variables.tableMetadata= StructNew()>
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="createBackupSnapshot" access="public" output="false" returntype="void"> 
		<cfargument name="datasource" type="string" required="true" />
		<cfargument name="tableName" type="any" required="true" />
		<cfset var tstamp= Now()>
		<cfset var qry= "">
		<cfset var jsonString= "">
		<cfset var snapshotName= "">
		
		<cfquery name="qry" datasource="#arguments.datasource#">
			select * from #arguments.tableName#
		</cfquery>
		
		<cfset jsonString= variables.JSONSerializer.serializeToJSON(qry,true,true)>
		<cfset snapshotName= arguments.tableName & variables.nameDelimiter & "autobackup" & variables.nameDelimiter & DateFormat(tstamp,'yyyy-mm-dd') & variables.nameDelimiter & TimeFormat(tstamp,'TT-hh-mm-ss') & ".txt">
		
		<cffile action="write" file="#variables.backupsFolder#/#snapshotName#" output="#jsonString#">
		
	</cffunction>
	
	<cffunction name="deleteSnapshots" access="public" output="false" returntype="void" description="I delete the selected snapshot files">
		<cfargument name="fileList" type="string" required="true" />
		<cfargument name="type" type="string" required="false" default="snapshots" />
		<cfset var f= "">
		<cfif arguments.type EQ "backups">
			<cfloop index="f" list="#arguments.fileList#" delimiters=",">
				<cffile action="delete" file="#variables.backupsFolder#/#f#">
			</cfloop>
		<cfelse>
			<cfloop index="f" list="#arguments.fileList#" delimiters=",">
				<cffile action="delete" file="#variables.snapshotsFolder#/#f#">
			</cfloop>
		</cfif>
	</cffunction>
	
	
	<cffunction name="getSnapshotHTMLTable" access="public" output="false" returntype="string">
		<cfargument name="snapshotFile" type="string" required="true" />
		<cfargument name="type" type="string" required="false" default="snapshots">
		<cfset var fileContent= "">
		<cfset var buildStruct= "">
		<cfset var htmlTable= "">
		<cfset var r= 0>
		<cfset var c= "">
		<cfset var colCounter= 0>
		<cfif arguments.type EQ "backups">
			<cffile action="read" file="#variables.backupsFolder#/#arguments.snapshotFile#" variable="fileContent">
		<cfelse>
			<cffile action="read" file="#variables.snapshotsFolder#/#arguments.snapshotFile#" variable="fileContent">
		</cfif>
		<cfset buildStruct= variables.JSONDeserializer.deserializeFromJSON(fileContent,true)>
		<cfsavecontent variable="htmlTable">
			<cfoutput>
				<table name="snapDataTable" id="snapDataTable" class="dataTablesTable"  border="1" cellpadding="2" cellspacing="2">
					<thead>
						<tr>
							<cfloop collection="#buildStruct.data#" item="c">
								<th><p>#c#<br /><a class="hideLink" title="#c#" href="#colCounter#">(hide)</a></p></th>
								<cfset colCounter= colCounter+1>
							</cfloop>
						</tr>
					</thead>
					<tbody>
						<cfloop index="r" from="1" to="#buildStruct.rowcount#">
							<tr>
								<cfloop collection="#buildStruct.data#" item="c">
									<td>#buildStruct.data[c][r]#</td>
								</cfloop>
							</tr>
						</cfloop>
					</tbody>
					<tfoot>
						<tr>
							<cfloop collection="#buildStruct.data#" item="c">
								<th><input type="text" class="search_init" title="Search #c#" value="Search #c#"/></th>
							</cfloop>
						</tr>
					</tfoot>
				</table>
			</cfoutput>
		</cfsavecontent>
		<cfreturn htmlTable />
	</cffunction>
	
	
	<cffunction name="getSnapshotList" access="public" output="false" returntype="query">
		<cfargument name="type" type="string" required="false" default="snapshots"/>
		<cfset var qry= "">
		<cfif arguments.type EQ "backups">
			<cfdirectory action="list" directory="#variables.backupsFolder#" name="qry">
		<cfelse>
			<cfdirectory action="list" directory="#variables.snapshotsFolder#" name="qry">
		</cfif>
		<cfreturn qry />
	</cffunction>
	
	
	<cffunction name="getTableList" access="public" output="false" returntype="query">
		<cfargument name="datasource" type="string" required="false" default="#variables.datasource#" /> 
		<cfargument name="tableFilterType" type="string" required="false" default="#variables.tableFilterType#" />
		<cfargument name="tableFilterValue" type="string" required="false" default="#variables.tableFilterValue#" />
		<cfset var qry= "">
		<cfif arguments.tableFilterType EQ "">
			<cfdbinfo type="tables" name="qry" datasource="#arguments.datasource#">
		<cfelse>
			<cfif arguments.tableFilterType EQ "prefix">
				<cfdbinfo type="tables" name="qry" datasource="#arguments.datasource#" pattern="#arguments.tableFilterValue#%">
			<cfelseif arguments.tableFilterType EQ "suffix">
				<cfdbinfo type="tables" name="qry" datasource="#arguments.datasource#" pattern="%#arguments.tableFilterValue#">
			<cfelse>
				<cfdbinfo type="tables" name="qry" datasource="#arguments.datasource#">
			</cfif>
		</cfif>
		<cfreturn qry />
	</cffunction>
	
	<cffunction name="loadSnapshots" access="public" output="true" returntype="array">
		<cfargument name="snapshotList" type="string" required="true" />
		<cfargument name="datasource" type="string" required="false" default="#variables.datasource#" />
		<cfargument name="type" type="string" required="false" default="snapshots" />
		
		<cfset var f= "">
		<cfset var tName= "">
		<cfset var tNameList= "">
		<cfset var fullTableName= "">
		<cfset var metaQry= "">
		
		<cfset var deleteList= "">
		<cfset var loopCounter= 0>
		
		<cfset var finishList= "">
		<cfset var fileContent= "">
		<cfset var buildStruct= "">
		<cfset var colCount= 0>
		<cfset var n= 1>
		<cfset var r= 1>
		<cfset var colCounter= 0>
		<cfset var c= "">
		<cfset var insertParams= StructNew()>
		<cfset var fieldValue= "">
		<cfset var fieldInsertSQL= "">
		<cfset var t= "">
		<cfset var threadName= "">
		<cfset var threadList= "">
		
		<cfset ArrayClear(variables.threadErrorArray)>
		
		<cfoutput>
			<cfloop index="f" list="#arguments.snapshotList#" delimiters=",">
				<cfset tName= ListGetAt(f,1,variables.nameDelimiter)>
				<cfset tNameList= ListAppend(tNameList,tName)>
				<cfset fullTableName= arguments.datasource & "_" & tName>
				
				<!---Gather the metadata (the column names, data types, and nullable status) of the selected tables--->
				<cfif Not StructKeyExists(variables.tableMetadata,fullTableName)>
					<cfset variables.tableMetadata[fullTableName]= StructNew()>
					<cfset variables.tableMetadata[fullTableName].name= tName>
					<cfset variables.tableMetadata[fullTableName].columnData= StructNew()>
					<cfdbinfo type="Columns" name="metaQry" table="#tName#" datasource="#arguments.datasource#">
					<cfloop query="metaQry">
						<cfset variables.tableMetadata[fullTableName].columnData[metaQry.column_name]= StructNew()>
						<cfset variables.tableMetadata[fullTableName].columnData[metaQry.column_name].dataType= metaQry.type_name>
						<cfset variables.tableMetadata[fullTableName].columnData[metaQry.column_name].nullable= metaQry.is_nullable>
					</cfloop>
				</cfif>
				<cfset createBackupSnapshot(arguments.datasource,tName)>
			</cfloop>
			
			<!---Use cftransaction to ensure that all selected tables have their table deleted, not just the ones that didn't encounter something like a constraint error--->
			<cftransaction>
				<cfloop condition="ListLen(deleteList) NEQ ListLen(arguments.snapshotList) AND loopCounter NEQ variables.loopLimit">
					<cfset loopCounter= loopCounter+1>
					<cfloop index="tName" list="#tNameList#" delimiters=",">
						<cfif ListFindNoCase(deleteList,tName) EQ false>
							<cftry>
								<cfquery datasource="#arguments.datasource#">
									delete from #tName#
								</cfquery> 
								<cfset deleteList= ListAppend(deleteList,tName)>
								<cfcatch type="database">
									<cfcontinue>
								</cfcatch>
							</cftry>
						</cfif>
					</cfloop>
				</cfloop>
				
				<cfif loopCounter GTE variables.loopLimit>
					<cftransaction action="rollback" />
					<cfthrow message="Unable to delete data from tables to prep for snapshot reload prior to reaching the loop limit (#loopLimit#), so all deletes were rolled back.  The most likely cause is that one or more tables could not be deleted due to constraint logic. But if you don't think that is the case, alter the appropriate cfcatch block in snapshotService.loadSnapshots() to surface the error." />
				<cfelse>
					<cfset loopCounter= 0>
				</cfif>
		</cftransaction>
			
			
			<cfloop condition="ListLen(finishList) NEQ ListLen(arguments.snapshotList) AND loopCounter NEQ variables.loopLimit">
				
				<cfset loopCounter= loopCounter+1>
				<cfloop index="f" list="#arguments.snapshotList#" delimiters=",">
					<!---Reset table error status to false when processing the next table in the loop--->
					<cfset variables.tableHasError= false>
					
					<!---Restart record count--->
					<cfset r= 1>
					<cfset tName= ListGetAt(f,1,variables.nameDelimiter)>
					<cfset fullTableName= arguments.datasource & "_" & tName>
					
					<cfif ListFindNoCase(finishList,tName) EQ false>
						<cfif arguments.type EQ "backups">
							<cffile action="read" file="#variables.backupsFolder#/#f#" variable="fileContent">
						<cfelse>
							<cffile action="read" file="#variables.snapshotsFolder#/#f#" variable="fileContent">
						</cfif>
						<cfset buildStruct= variables.JSONDeserializer.deserializeFromJSON(fileContent,true)>
						<cfset colCount= StructCount(buildStruct.data)>
						
						<!---Can build your own database-specific insert routine--->
						<cfif StructKeyExists(variables.dbaseLibrary,"insertData")>
							
							<cftry>
								<cfset variables.dbaseLibrary.insertData(arguments.datasource,tName,buildStruct,variables.tableMetadata[fullTableName])>
								<cfset finishList= ListAppend(finishList,tName)>
								<cfcatch type="database">
									<cfcontinue>
								</cfcatch>
							</cftry>
							
						<cfelse>
						
							<!---Build the field name list--->
							<cfset var fieldInsertSQL= "">
							<cfloop collection="#buildStruct.data#" item="c">
								<cfset fieldInsertSQL= ListAppend(fieldInsertSQL,c)>
							</cfloop>
							
							<cftry>
								<cfloop condition="r LTE buildStruct.rowcount">  
									<cfloop index="t" from="1" to="#variables.insertThreadLimit#">  
										<cfif r LTE buildStruct.rowcount>
											<!---Thread names must be unique within the entire request--->
											<cfset threadName= "#tName#_#n#">
											<cfset threadList= ListAppend(threadList,threadName)>
											<cfthread name="#threadName#" 
												threadIndex="#r#" 
												threadDS="#arguments.datasource#" 
												threadTName="#tName#"
												threadFieldInsertSQL= "#fieldInsertSQL#"
												threadBuildStruct="#buildStruct#"
												threadColCount= "#colCount#"
												threadFullTableName="#fullTableName#">
												
												<cftry>
												
													<cfquery datasource="#threadDS#">
														insert into #threadTName# (
															#threadFieldInsertSQL#
														) VALUES (
															<cfset colCounter= 1>
															<cfloop index="c" list="#threadFieldInsertSQL#" delimiters=",">
																<cfset fieldValue= threadBuildStruct.data[c][threadIndex]>
																<!---The determination of the values for the cfqueryparameter statement is database-specific--->
																<cfset insertParams= variables.dbaseLibrary.returnInsertParams(variables.tableMetadata[threadFullTableName].columnData[c].dataType,variables.tableMetadata[threadFullTableName].columnData[c].nullable,fieldValue)>
																<cfif structKeyExists(insertParams,"scale")>
																	<cfqueryparam value="#insertParams.value#" cfsqltype="#insertParams.sqlType#" null="#insertParams.isNull#" scale="#insertParams.scale#" />
																<cfelse>
																	<cfqueryparam value="#insertParams.value#" cfsqltype="#insertParams.sqlType#" null="#insertParams.isNull#" />
																</cfif>
																<cfif colCounter NEQ threadColCount>,</cfif>
																<cfset colCounter= colCounter+1>
															</cfloop>
														)
													</cfquery>
													<cfcatch type="any">
														<cfset errorInfo= StructNew()>
														<cfset errorInfo.table_JSONRecordNumber= "#threadTName#_#threadIndex#">
														<cfset errorInfo.message= cfcatch.message>
														<cfset errorInfo.detail= cfcatch.detail>
														<cfset errorInfo._cfcatchData= cfcatch>
														<cfset ArrayAppend(variables.threadErrorArray,errorInfo)>
														<cfset variables.tableHasError= true>
													</cfcatch>
												</cftry>
											</cfthread>
											<cfset r= r+1>
											<cfset n= n+1>
										</cfif> 
										
									</cfloop>
									<cfthread action="join" name="#threadList#" />
									<cfset threadList= "">
									
									<cfif variables.tableHasError>
										<!---Cannot risk a partial reload where some insert threads succeeded:  clear table again--->
										<cfquery datasource="#arguments.datasource#">
											delete from #tName#
										</cfquery> 
										<cfset variables.tableHasError= false>
										<cfthrow type="insertThreadError">
									</cfif>
									
								</cfloop>
								<cfset finishList= ListAppend(finishList,tName)>
								
								<cfcatch type="insertThreadError">
									<cfcontinue>
								</cfcatch>
								
							</cftry>
							
						</cfif>
						
					</cfif>
				</cfloop>  <!---table list--->
			</cfloop>
			
			<cfif loopCounter GTE variables.loopLimit>
				<cfthrow message="Unable to reload snapshot data prior to reaching the loop limit (#loopLimit#).  The most likely cause is that one or more snapshots could not be loaded due to constraint logic (related records not being present in the existing data).  But if you don't think that is the case, alter the appropriate cfcatch block in snapshotService.loadSnapshots() to surface the error." />
			</cfif>
			
		</cfoutput>
		<!---Return any errors recorded by the threads--->
		<cfreturn variables.threadErrorArray />
	</cffunction>
	
	<cffunction name="takeTableSnapshots" access="public" output="false" returntype="void"> 
		<cfargument name="tableList" type="any" required="true" />
		<cfargument name="formData" type="struct" required="true" />
		<cfargument name="datasource" type="string" required="false" default="#variables.datasource#" />
		<cfset var t= 1>
		<cfset var qry= "">
		<cfset var jsonString= "">
		<cfset var snapshotName= "">
		<cfset var tstamp= Now()>
		
		<cfloop index="t" from="1" to="#ListLen(arguments.tableList)#">
			<cfquery name="qry" datasource="#arguments.datasource#">
				select * from #ListGetAt(arguments.tableList,t)#
			</cfquery>
			<cfset jsonString= variables.JSONSerializer.serializeToJSON(qry,true,true)>
			<cfif arguments.formData[ListGetAt(arguments.tableList,t)] NEQ "">
				<cfset snapshotName= ListGetAt(arguments.tableList,t) & variables.nameDelimiter & arguments.formData[ListGetAt(arguments.tableList,t)] & variables.nameDelimiter & DateFormat(tstamp,'yyyy-mm-dd') & variables.nameDelimiter & TimeFormat(tstamp,'TT-hh-mm-ss') & ".txt">
			<cfelse>
				<cfset snapshotName= ListGetAt(arguments.tableList,t) & variables.nameDelimiter & DateFormat(tstamp,'yyyy-mm-dd') & variables.nameDelimiter & TimeFormat(tstamp,'TT-hh-mm-ss') & ".txt">
			</cfif>
			
			<cffile action="write" file="#variables.snapshotsFolder#/#snapshotName#" output="#jsonString#">
		</cfloop>
	</cffunction>
	
</cfcomponent>