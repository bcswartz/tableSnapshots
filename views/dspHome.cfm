<h2>tableSnapshots Tool</h2>

<p>This tool, which will run on Adobe ColdFusion 8 and later, lets you do the following:</p>

<ul class="info">
	<li>Take a "snapshot" of one or more of your database tables, storing all of the current table data in a JSON file (NOTE: this tool will not work on tables with binary data fields).</li>
	<li>Replace the current data in a table with the data stored in a snapshot, creating a backup snapshot of the data being replaced in the process.</li>
	<li>View the data in a snapshot or backup snapshot in a jQuery-enhanced table that allows you to sort and filter the data.</li>
	<li>Delete older snapshot and backup snapshot files</li>
</ul>

<p>A smaller, separate tool is also provided in the "tools" directory that will read the snapshot files into query objects.</p>

<p>The current version of the tool supports Oracle, MySQL, and Apache Derby databases, but you can add support for any additional databases by writing a single .cfc file.</p>

<p>To learn more about the tool and how to get started, check the "About" menu, and/or run through the set of testing steps in the included "test" directory.</p>

<p><strong>NOTE:</strong>  this is primarily meant as a development tool to use with development data.  If you do choose to use it with production data, make sure you're familiar with its limitations and test to make sure it works in your environment.</p>



