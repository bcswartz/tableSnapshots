<h2>Getting Started</h2>

<p>This tool is designed such that it can be installed anywhere under the web root, even several folders deep within the web root.  Just make sure that ColdFusion has permission to write to the directory and subdirectories of the folder you install it in.</p>

<p>Once the files have been unzipped and copied to the folder you selected, open up the Application.cfc file.  In the OnRequestStart function, you'll see a number of settings stored in the "args" struct in the application scope.  Enter the name of your datasource as the value for application.args.datasource.</p>

<p>If the datasource you're accessing contains a lot of tables, and the only tables you're interested in have either a common prefix or suffix, change the tableFilterType and tableFilterValue values (if all the tables you want begin with "test", set tableFilterType to "prefix" and tableFilterValue to "test").
</p>

<p>Then check to see if your database server is supported by the tool by looking for a .cfc file in the main tool directory that matches the database server type.  The original version of the tool comes with support for Oracle, MySQL, and Apache Derby, so there should be an Oracle.cfc, a MySQL.cfc, and an ApacheDerby.cfc in the folder.</p>

<p>If your database server is supported, click "Reset" on the menu bar so your new datasource setting can take effect, and you can start using the tool.  If not, you'll need to read the "Technical Details" page to learn how to write a .cfc to support your type of database server.</p>

<p>If you want to get a feel for the tool before using it with your own data, point your browser at the index.cfm file in the "test" folder in the tableSnapshot files and go through the steps that demonstrate the use of the tool on a test table in one of the sample Apache Derby databases packaged in Adobe ColdFusion.</p>