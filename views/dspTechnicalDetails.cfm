<h2>Technical Details</h2>

<p>Most of the functionality of this tool comes from the following components:</p>

<ul class="info">
	<li>The <a href="http://livedocs.adobe.com/coldfusion/8/htmldocs/help.html?content=Tags_d-e_01.html">&lt;cfdbinfo&gt;</a> tag, which is used to retrieve the list of tables from the datasource and to retrieve the metadata about the table columns needed to reload the snapshot data back to the target table(s).</li>
	<li>The <a href="http://jsonutil.riaforge.org">JSONUtil</a> project, which provides the .cfc that serializes the table data into JSON format.</li>
	<li>The <a href="http://datatables.net/">DataTables</a> jQuery plugin, which is used to provide the sorting and filtering capabilities for the HTML tables in the tool.</li>
</ul>

<p>This tool was built and tested on ColdFusion 9.0.1.  It should work on Adobe ColdFusion 8, and perhaps other CFML engines as well, but it has not been tested in those environments.</p>

<p>The JSONUtil project is used to serialize the data into JSON rather than the JSON functions built into Adobe ColdFusion starting with version 8 because the "strictMapping" option provided by JSONUtil circumvents all of the data conversion issues that can happen with the built-in JSON functions (such as strings being converted to numbers and "true"/"false" string values being converted to "yes/no").  However, the native ColdFusion JSON functions seem to do a better job of deserializing large datasets, so the tool uses both.  The tool should accurately store the data in the JSON files and then copy that data back to the original table (assuming no structural changes to the table in the interim) without the data being altered, but if you're using this tool with production data you will obviously want to test and take precautions.  The act of creating a snapshot file does not alter the data in the affected tables at all, so simply taking a snapshot does not put your data at risk in any way.</p>

<p>If you want to use a different library to serialize the data into JSON format, you can do that simply by writing a .cfc that provides the same named functions as JSONUtil and then replacing JSONUtil with the name of your .cfc in the application.args.JSONSerializer setting in the Application.cfc onRequestStart() function.</p>

<p>While the &lt;cfdbinfo&gt; tag retrieves the metadata about the data fields of a table whenever you try to load snapshot data to that table, that data isn't quite sufficient to generate the correct SQL code to write the needed insert statements.  The tool is designed to utilize the .cfc file whose name matches that of the datasource database server (the server name as returned by &lt;cfdbinfo type="version" ...&gt;, with any spaces removed) to provide the proper &lt;cfqueryparam&gt; values for the SQL.</p>

<p>The original version of this tool provides such .cfc files for Oracle, MySQL, and Apache Derby.  To create a similar .cfc for a different database server like MSSQL, simply make a copy of one of the existing .cfc files, rename it appropriately, and alter the function logic within your .cfc.  The biggest part of that task will be matching the field/column data types returned by &lt;cfdbinfo&gt; to the the appropriate cfsqltype for each field.  That may take some research and trial and error.</p>

<p>If you do create your own database server-specific .cfcs, feel free to contribute them back to the project (which is hosted on <a href="http://github.com/">GitHub</a>).</p>

<p>Various behaviors of the tool can be altered using the setting defined in the "application.args" struct defined in the Application.cfc onRequestStart() function:</p>

<ul class="info">
	<li><strong>datasource</strong>: the name of the datasource.</li>
	<li><strong>tableFilterType</strong> and <strong>tableFilterValue</strong>: if the datasource you're accessing contains a lot of tables, and the only tables you're interested in have either a common prefix or suffix, change the tableFilterType and tableFilterValue values to limit the database tables listed by the tool.</li>
	<li><strong>nameDelimiter</strong>:  when the snapshot and backup files are written, metadata such as the current date and time and the name/set name of the snapshot (as selected by the user) are incorporated into the file name itself.  The nameDelimiter setting sets what character is used to separate these values in the filenames for retrieval when listed in a table.  The default is "_".  Do not use dashes (which are used in recording the date and time in the filename).</li>
	<li><strong>JSONSerializer</strong> and <strong>JSONDeserializer</strong>:  the names of the .cfcs in the main tool folder that will be instantiated within the snapshotService object and used to serialize and deserialize the data.</li>
	<li><strong>snapshotsFolder</strong> and <strong>backupsFolder</strong>: the names of the folders within the main tool folder where the snapshot and backup snapshot files are stored.  The default values are "snapshots" and "backups" respectively.</li>
	<li><strong>requesttimeout</strong>: fairly obvious, but worth nothing that it sets the timeout for every page and function in the tool. The default is a generous 2400 seconds (40 minutes).</li>
	<li><strong>loopLimit</strong>: this integer is used during the process of loading snapshot data into tables to set a limit on the number of iterations used to delete and load the data.  These iterations only come into play if the tables in question have delete constraints due to primary/foreign key relationships defined in the database, in which case the tool will delete from/load data into whatever tables it can during each loop then trying again, and hopefully completing the work for all the tables within the allotted number of loops.  The default is a generous 100 loops.</li>
	<li><strong>insertThreadLimit</strong>: the database-agnostic routine for inserting records uses threads to issue multiple inserts to the same table at the same time, cutting down the time it takes to restore a large number of records.  This integer determines how many threads will be generated at any given time (the created threads will be joined prior to spawning a new set of threads).  10 is the default number of concurrent threads set in the developer version of ColdFusion 9, so tableSnapshots also uses 10 as the default.</li>
</ul>

<p>Each time you change a setting, you will need to click the "Reset" option in the tool menu to trigger the reset event, recreating the tableMetadata struct and the snapshotService object.</p>

<p>The tableMetadata struct preserves the data field metadata collected from &lt;cfdbinfo&gt; when a snapshot or backup snapshot is about to be loaded up to the matching table.  &lt;cfdbinfo&gt; does not work quickly when retrieving table column data, so storing the retrieved data in a key comprised of the datasource and table name makes the snapshot loading process for that datasource/table combination work much faster the second, third, and nth time around.  It will however be reset when the "Reset" command is issued (and you may want to reset it if you've altered the table structure of one or more tables).</p>

<p>The snapshotService object is the central model object of the tool.  If you want to know how the tool does what it does, that's the place to look.</p>

<p>Despite using threads to execute the insert statements more quickly, loading a data set of 10,000 records or more can take several minutes or longer, so use common sense when deciding how many snapshots you want to load in the same request.  Some database systems provides a means for doing bulk inserts.  If you're using such a database and want to write a more efficient insert routine, create a function named "insertData" in your database-specific CFC that accepts the following arguments:</p>

<ul class="info">
	<li>The datasource name (string)</li>
	<li>The table name (string)</li>
	<li>The deserialized JSON data (struct)</li>
	<li>The metadata about the table columns (struct)</li>
</ul>

<p>You can see how the database-agnostic insert routine uses this data to load the snapshot into the table by viewing the loadSnapshots() function in the snapshotService object.</p>

<p>The loadSnapshots() function in the snapshotService.cfc is the most complex function within the tool.  It is designed to handle any errors or problems it encouters during the reload process in a reasonable and recoverable fashion.  If any tables selected to be reloaded with snapshot data cannot be cleared of data for any reason (the most likely reason being a relational constraint), any deletions involving those tables during that part of the process will be rolled back and the process will abort once the iteration limit (determined by the ""loopLimit" setting) is reached.  During the process of inserting the data, if an error occurs during the insertion of a row, that error will be recorded and the table affected will again be cleared before proceeding to the next table or the next iteration of the overall insert process, so there can never be a partial reload of any given table.  Errors captured during the reload process will be displayed to the user at the end of the process.  Note that if you are reload snapshots involving tables that have relational constraints (defined in the database), you will see any constraint-related errors displayed at the end of the reload process even if the tool does succeed in reloading all of the tables via multiple iterations.</p>

<p>Finally, the index.cfm file acts as a basic controller for the tool, routing requests through a &lt;cfswitch&gt; statement.  So look there to see what snapshotService functions are called and what display files are called for each different request/event/URL string.</p>
