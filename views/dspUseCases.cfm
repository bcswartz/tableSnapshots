<h2>Use Cases</h2>

<p>So what can you use this tool for?</p>

<p>The idea for this tool came out of the annoyance of having to reset data in multiple table rows in multiple tables during the functional testing of different scenarios.  By creating snapshots of the affected tables, it was easy to reset the tables back to the way they were prior to running the functional test.</p>

<p>So the tool is primarily designed to be used in a development environment.  You can use it:</p>

<ul class="info">
	<li>To reset data during testing as described above.</li>
	<li>To keep track of changes to data over time (since each snapshot file is timestamped).</li>
	<li>As a data-viewing client if you cannot access the database with a full-fledged SQL client.</li>
	<li>As a database backup mechanism if there is no backup database server for your development environment.</li>
	<li>To copy table data from one database server to another (like from an Oracle table to a MySQL table):  take a snapshot of the table from the first server, create a similar table on the second server, and reload the snapshot to the second server.</li>
	<li>To create snapshots as data for use while offline or in mock objects.  The mini-tool in the "tools/jsonasquery" subfolder can be used to pull snapshot data into a query object.</li>
</ul>

