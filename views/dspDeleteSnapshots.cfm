<cfoutput>
	<p class="successText">The following snapshot files were deleted:</p>
	<ul>
		<cfloop index="t" from="1" to="#ListLen(form.deletes)#">
			<li>
				#ListGetAt(form.deletes,t)#
			</li>
		</cfloop>
	</ul>
</cfoutput>