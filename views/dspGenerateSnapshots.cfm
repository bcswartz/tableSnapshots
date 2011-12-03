<link rel="stylesheet" type="text/css" href="css/dataTableStyles.css" />

<h2>Create Snapshots</h2>

<p>Below is a table of all of tables that match the datasource and table name parameters (prefix, suffix, or none) you set.  Select the ones you want to create snapshots of.  All snapshot filenames are timestamped, but you can add a label to each table snapshot to further categorize them or label them as part of a set.</p>

<p>NOTE: because of the nature of the table below, any checkmarks not visible on the current table "page" will not be processed.</p>

<p>
	<a id="selectAll" href="#">Select All</a> | <a id="deselectAll" href="#">De-select All</a>
	<span id="tableLabelSpan">Set all table labels (on blur) to:</strong> <input type="text" name="allLabels" id="allLabels" value="" /></span>
</p>

<form name="tableList" id="tableList" method="post" action="index.cfm?event=createSnapshots">

	<table name="tList" id="tList" width="100%" class="dataTablesTable" border="1" cellpadding="2" cellspacing="2">
		<thead>
			<tr>
				<th><span>Table Name</span></th>
			</tr>
		</thead>
		<tbody>			
			<cfoutput query="sortedQry">
				<tr>
					<td>
						<input type="checkbox" name="snaps" value="#sortedQry.table_name#" /> 
						#sortedQry.table_name#
						<input type="text" class="snapshotName" name="#sortedQry.table_name#" value="" />
					</td>
				</tr>
			</cfoutput>
		</tbody>
			
	</table>
	
	<p>
		<br /><br />
		<input type="submit" name="submitBtn" id="submitBtn" value="Create snapshot files" />
	</p>
	
</form>

<script type="text/javascript" src="javascript/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="javascript/dspGenerateSnapshots.js"></script>
	