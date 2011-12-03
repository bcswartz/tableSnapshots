<cfoutput>
	
	<p class="successText">Current table data was replaced for the following tables by the following snapshots:</p>
	<ul>
		<cfloop index="t" from="1" to="#ListLen(form.loads)#">
			<li>
				#ListGetAt(ListGetAt(form.loads,t),1,application.args.nameDelimiter)#  -- #ListGetAt(form.loads,t)#
			</li>
		</cfloop>
	</ul>
	
	<cfif ArrayIsEmpty(errArray)>
		<p>No errors were recorded during the snapshot load.</p>
	<cfelse>
		<p class="errorText">The following errors occurred during the snapshot load (click to expand).  Errors related to table relationships and constraints can generally be ignored as the tool is designed to absorb such errors and retry until successful:</p>
		<cfdump var="#errArray#" expand="false" label="Insert errors" >
	</cfif>
	
</cfoutput>


