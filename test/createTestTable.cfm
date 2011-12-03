<cfinclude template="header.cfm">

<p>Creating test table...</p><cfflush />

<cfquery datasource="cfartgallery">
	create table snaptest (
		snapId Integer,
		artwork Varchar(500),
		artist Varchar(100),
		price Decimal(9,2)
	)
</cfquery>

<cfquery datasource="cfartgallery">
	insert into snaptest (
		snapId, artwork, artist, price
	) VALUES (
		<cfqueryparam value="1" cfsqltype="cf_sql_numeric" />,
		<cfqueryparam value="The Rise of Light" cfsqltype="cf_sql_varchar" />,
		<cfqueryparam value="Fransioux Smith" cfsqltype="cf_sql_varchar" />,
		<cfqueryparam value="1200.95" cfsqltype="cf_sql_numeric" scale="2" />
	)
</cfquery>

<cfquery datasource="cfartgallery">
	insert into snaptest (
		snapId, artwork, artist, price
	) VALUES (
		<cfqueryparam value="2" cfsqltype="cf_sql_numeric" />,
		<cfqueryparam value="Hero's Downfall" cfsqltype="cf_sql_varchar" />,
		<cfqueryparam value="Jody Ellen" cfsqltype="cf_sql_varchar" />,
		<cfqueryparam value="2300.50" cfsqltype="cf_sql_numeric" scale="2" />
	)
</cfquery>

<cfquery datasource="cfartgallery">
	insert into snaptest (
		snapId, artwork, artist, price
	) VALUES (
		<cfqueryparam value="3" cfsqltype="cf_sql_numeric" />,
		<cfqueryparam value="Seven Moments" cfsqltype="cf_sql_varchar" />,
		<cfqueryparam value="Gary Frank" cfsqltype="cf_sql_varchar" />,
		<cfqueryparam value="9850.00" cfsqltype="cf_sql_numeric" scale="2" />
	)
</cfquery>

<cfquery name="qry" datasource="cfartgallery">
	select snapId, artwork, artist, price from snaptest order by snapId ASC
</cfquery>

<p>Table creation and population done.  Table data:</p>

<cfdump var="#qry#">


<p><a href="index.cfm">Go back</a></p>

<cfinclude template="footer.cfm">