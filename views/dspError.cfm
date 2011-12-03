<cfoutput>

	<h3 class="errorText">Error Occurred</h3>
	
	<p>An error has occurred.  Details:</p>
	
	<p>Error event: #arguments.eventName#</p>
	
	<p>Error dump:</p>
	
	<cfdump var="#arguments.exception#">
	
</cfoutput>
