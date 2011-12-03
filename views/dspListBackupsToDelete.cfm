<link rel="stylesheet" type="text/css" href="css/dataTableStyles.css" />

<h2>Delete Backup Files</h2>

<p>Select the snapshot backup files you want to delete. </p>

<p>NOTE: because of the nature of the table below, any checkmarks not visible on the current table "page" will not be processed.</p>

<p><a id="selectAll" href="#">Select All</a> | <a id="deselectAll" href="#">De-select All</a></p>

<form name="tableList" id="tableList" method="post" action="index.cfm?event=deleteBackups">
	
	<table name="tList" id="tList" class="dataTablesTable" width="100%" border="1" cellpadding="2" cellspacing="2">
		<thead>
			<tr>
				<th>Delete Backup</th>
				<th>Taken</th>
				<th>Table Name</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>			
			<cfoutput query="sortedQry">
				<tr>
					<td>
						<input type="checkbox" class="load" name="deletes" value="#sortedQry.name#" />
					</td>
					<td>
						#DateFormat(sortedQry.dateLastModified,"mm/dd/yyyy")# #TimeFormat(sortedQry.dateLastModified,"HH:mm:ss")#
					</td>
					<td>
						#ListGetAt(sortedQry.name,1,application.args.nameDelimiter)#
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
		<input type="submit" name="submitBtn" id="submitBtn" value="Delete Selected Backups" />
	</p>
	
</form>

<script type="text/javascript" src="javascript/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="javascript/dspListFiles.js"></script>