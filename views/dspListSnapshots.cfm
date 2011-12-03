<link rel="stylesheet" type="text/css" href="css/dataTableStyles.css" />

<h2>List Snapshots / View / Load Table Data From Snapshots</h2>

<p>Below is the list of snapshots stored in .txt file form in your snapshots folder.  From here you can view the data in a particular snapshot, or select the snapshots of data you want to load.</p>

<p>Some things to note:</p>
<ul class="info">
	<li>Loading data from snapshot(s) takes a much longer amount of time than it does to create the snapshot(s) because the tool has to collect metadata about the target table and of course perform the insert.  So be patient.</li>
	<li>Loading a snapshot WILL DELETE any existing data in that table, so a backup snapshot of the existing table data will be stored in the backups folder prior to deletion as a safety precaution.</li>
	<li>Viewing snapshot data involves loading the snapshot data into a query object.  If the snapshot is from a large table, ColdFusion may not be able to load it into memory.</li>
	<li>Because of the nature of the table below, any checkmarks not visible on the current table "page" will not be processed.</li>
</ul>
<br />
 
<p><a id="selectAll" href="#">Load All</a> | <a id="deselectAll" href="#">De-select</a></p>

<form name="tableList" id="tableList" method="post" action="index.cfm?event=loadSnapshots">
	
	<table name="tList" id="tList" class="dataTablesTable" width="100%" border="1" cellpadding="2" cellspacing="2">
		<thead>
			<tr>
				<th>Load</th>
				<th>Table Name</th>
				<th>Snapshot Name</th>
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
						<cfif ListLen(sortedQry.name,application.args.nameDelimiter) GT 3>
							#ListGetAt(sortedQry.name,2,application.args.nameDelimiter)#
						</cfif>
						&nbsp;
					</td>
					<td>
						#DateFormat(sortedQry.dateLastModified,"mm/dd/yyyy")# #TimeFormat(sortedQry.dateLastModified,"HH:mm:ss")#
					</td>
					<td>
						<a href="index.cfm?event=viewSnapshot&f=#sortedQry.name#" target="_blank">View Snapshot Data</a>
					</td>
				</tr>
			</cfoutput>
		</tbody>
			
	</table>
	
	<p>
		<br /><br />
		<input type="submit" name="submitBtn" id="submitBtn" value="Load Selected Snapshots" />
	</p>
	
</form>

<script type="text/javascript" src="javascript/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="javascript/dspListFiles.js"></script>
