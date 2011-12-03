<link rel="stylesheet" type="text/css" href="css/dataTableStyles.css" />

<cfoutput>
	<h2>View #dataTypeTitle#</h2>

	<p>Use the table below to sort and filter the data in the #dataType#.  If there are too many columns, click the "hide" link beneath the column name to hide it, and click it's name in the hidden columns list to show it again.</p>

	<h3>
		#dataTypeTitle#: #url.f#
	</h3>
	
	<p id="hiddenCols">Hidden columns: </p>
	
	#snapshotTable#
</cfoutput>

<p><br /><br /></p>
<script type="text/javascript" src="javascript/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="javascript/dspViewSnapshots.js"></script>