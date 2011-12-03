<html>
	<head>
		<title>JSONAsQuery Tool</title>
	</head>
	<body>
		
		<cfsetting requesttimeout="60" />
		
		<h2>Demo of JSONAsQuery Tool</h2>
  
		<p>The JSONAsQuery tool will accept as JSON file and return the data as a query object.</p>
		
		<p>The output you see below is the result of the function processing the first snapshot in your snapshot folder alphabetically 
		assuming:</p>
		<ul>
			<li>This folder is still in the right place relative to your snapshots directory</li>
			<li>Your snapshots folder is still called "snapshots"</li>
			<li>The snapshot file wasn't too large to process</li>
		</ul>
		
		<p>The tools is accompanied by two CFCs that expose the serialize and deserialize JSON functions of either the JSONUtil library or the native CF JSON functions included since ColdFusion 8.  For small datasets, either one ought to work equally well, but the native CF JSON functions seem to work better with large datasets.</p>
		
		<p>Some possible uses for this tool:</p>
		
		<ul>
			<li>Injecting the resulting query into a "mock object" in order to simulate data without interacting with current table data.</li>
			<li>Allows you to work with certain datasets in local development when you're offline or otherwise unable to connect to the database.</li>
		</ul>
		
		<hr />
		
		<cfset args= StructNew()>
		<cfset args.tableName= "exampleTable">
		<cfset args.dataFolder= expandPath("../..") & "/snapshots">
		<cfdirectory action="list" directory="#args.dataFolder#" name="qryFiles" sort="name" />
		<cfset args.dataFile= qryFiles.name>
		
		<cfset toolObj= CreateObject("component","JSONASQuery").init("JSONNativeCF")>
		<cfset qryResult= toolObj.returnAsQuery(argumentCollection=args)>	
		<cfdump var="#qryResult#">
		
	
	</body>
</html>


