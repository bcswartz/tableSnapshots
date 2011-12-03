<cfinclude template="header.cfm">

<p>Current table data:</p>

<cfquery name="qry" datasource="cfartgallery">
	select snapId, artwork, artist, price from snaptest order by snapId ASC
</cfquery>

<cfdump var="#qry#">

<p><a href="index.cfm">Go back</a></p>

<cfinclude template="footer.cfm">