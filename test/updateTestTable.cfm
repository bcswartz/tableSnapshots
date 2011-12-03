<cfinclude template="header.cfm">

<p>Updating test table...</p><cfflush />

<cfquery datasource="cfartgallery">
	update snaptest
		set artwork= <cfqueryparam value="The Rise of Light REDUX" cfsqltype="cf_sql_varchar" />
	where snapId=  <cfqueryparam value="1" cfsqltype="cf_sql_numeric" />
</cfquery>

<cfquery datasource="cfartgallery">
	update snaptest
		set price= <cfqueryparam value="1.50" cfsqltype="cf_sql_numeric" />
	where snapId=  <cfqueryparam value="2" cfsqltype="cf_sql_numeric" />
</cfquery>

<cfquery datasource="cfartgallery">
	update snaptest
		set artist= <cfqueryparam value="King Gary Frank III" cfsqltype="cf_sql_varchar" />
	where snapId=  <cfqueryparam value="3" cfsqltype="cf_sql_numeric" />
</cfquery>

<cfquery name="qry" datasource="cfartgallery">
	select snapId, artwork, artist, price from snaptest order by snapId ASC
</cfquery>


<p>Table changes made.  Current table data:</p>

<cfdump var="#qry#">

<p><a href="index.cfm">Go back</a></p>

<cfinclude template="footer.cfm">