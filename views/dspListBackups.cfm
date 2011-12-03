<link rel="stylesheet" type="text/css" href="css/dataTableStyles.css" />

<h2>Snapshot Table Backups</h2>

<p>Listed below are the backup snapshot files created when you replace a table's content with data from a snapshot.  You can view this data or reload the tables with the selected backups (which will then create new backups as a safety precaution).</p>

<p>NOTE: because of the nature of the table below, any checkmarks not visible on the current table "page" will not be processed.</p>

<p><a id="selectAll" href="#">Load All</a> | <a id="deselectAll" href="#">De-select</a></p>

<form name="tableList" id="tableList" method="post" action="index.cfm?event=loadBackups">
	
	<table name="tList" id="tList" class="dataTablesTable" width="100%" border="1" cellpadding="2" cellspacing="2">
		<thead>
			<tr>
				<th>Load</th>
				<th>Table Name</th>
				<th>Taken</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>			
			<cfoutput query="sortedQry">
				<tr>
					<td>
						<input type="checkbox" class="load" name="loads" value="#sortedQry.name#" />
					</td>
					<td>
						#ListGetAt(sortedQry.name,1,application.args.nameDelimiter)#
					</td>
					<td>
						#DateFormat(sortedQry.dateLastModified,"mm/dd/yyyy")# #TimeFormat(sortedQry.dateLastModified,"HH:mm:ss")#
					</td>
					<td>
						<a href="index.cfm?event=viewBackup&f=#sortedQry.name#" target="_blank">View Backup Data</a>
					</td>
				</tr>
			</cfoutput>
		</tbody>
			
	</table>
	
	<p>
		<br /><br />
		<input type="submit" name="submitBtn" id="submitBtn" value="Load Selected Backups" />
	</p>
	
</form>

<script type="text/javascript" src="javascript/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="javascript/dspListFiles.js"></script>
	