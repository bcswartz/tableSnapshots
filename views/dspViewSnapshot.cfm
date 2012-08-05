<link rel="stylesheet" type="text/css" href="css/snapshots.jquery.dataTables.css" />

<cfoutput>
	<h2>View #dataTypeTitle#</h2>

	<p>Use the table below to sort and filter the data in the #dataType#.  If there are too many columns, use the column controls to display only the columns you care about.</p>
	
	<p>NOTE: any filters on columns that you then hide will remain in effect.</p>

	<h3>
		#dataTypeTitle#: #url.f#
	</h3>
	
	#snapshotTable#
		
</cfoutput>

<p><br /><br /></p>
<script type="text/javascript" src="javascript/dataTables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="javascript/blockUI/jquery.blockUI.js"></script>
<script type="text/javascript" src="javascript/dspViewSnapshots.js"></script>