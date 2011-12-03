<cfinclude template="header.cfm">

<p>Dropping snaptest table...</p><cfflush />

<cfquery name="qry" datasource="cfartgallery">
	drop table snaptest
</cfquery>

<p>Table dropped.</p>

<p><a href="index.cfm">Go back</a></p>

<cfinclude template="footer.cfm">