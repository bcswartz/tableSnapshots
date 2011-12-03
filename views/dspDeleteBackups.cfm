<cfoutput>
	<p class="successText">The following backup files were deleted:</p>
	<ul>
		<cfloop index="t" from="1" to="#ListLen(form.deletes)#">
			<cfset filename= ListGetAt(form.deletes,t)>
			<li>
				#ListGetAt(form.deletes,t)#
			</li>
		</cfloop>
	</ul>
</cfoutput>