<cfinclude template="header.cfm">
	
<h2>tableSnapshots Test Routine</h2>	
	
<p>If you want to learn how to use the tableSnapshots tool before trying it out on your own development tables, go through the following steps to see the tool in action:</p>

<ol class="info">
	<li>Open the Application.cfc file and make sure application.args.datasource is set to use the "cfartgallery" datasource that comes pre-defined in ColdFusion installs (tableSnapshots should be set to use that datasource by default).</li>
	<li>Click on the following link to create a new table called "snapTest" with a few new test records: <a href="createTestTable.cfm">Create and populate test table</a>.</li>
	<li>Open the tableSnapshots tool and in the menu select <strong>Snapshots -> Create</strong> to select the snapTest table and create a snapshot of it.</li>
	<li>Select <strong>Snapshots -> List/Load</strong> in the menu and click on the link for viewing the snapshot data of the snapshot you just created.  Take note of the values contained in the snapshot.</li>
	<li>Click on the following link to change some of the values in the snapTest table (and note how the values have changed):  <a href="updateTestTable.cfm">Update test table</a>.</li>
	<li>Select <strong>Snapshots -> List/Load</strong> in the menu, click on the checkbox for the snapshot, and click on the "Load Selected Snapshots" button.  Wait for the snapshot to finish.</li>
	<li>Click on the following link to see a dump of the database table and confirm the the original values have been restored: <a href="dumpTestTable.cfm">Dump test table</a>.</li>
	<li>Select <strong>Backups -> List/Load</strong> in the menu and click on the link for viewing the backup data of the backup file that was created as part of the snapshot load. You will see the changes introduced in step 5 preserved.</li>
	<li>Click on the following link to drop the snapTest table:  <a href="dropTestTable.cfm">Drop test table</a>.</li>
	<li>Delete the test snapshot and backup files you created, either within the tableSnapshots tool itself or by manually deleting them from the snapshots and backups folders.</li>
</ol>

<cfinclude template="footer.cfm">