<cfoutput>
	<p class="successText">Snapshots were created for the following tables:</p>
	<ul>
		<cfloop index="t" from="1" to="#ListLen(form.snaps)#">
			<li>
				#ListGetAt(form.snaps,t)# 
				<cfif form[ListGetAt(form.snaps,t)] NEQ "">
					(#form[ListGetAt(form.snaps,t)]#)
				</cfif>
			</li>
		</cfloop>
	</ul>
</cfoutput>


