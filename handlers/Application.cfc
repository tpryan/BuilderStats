<cfcomponent>
	<cfset This.name ="BuilderStats" />
	<cfset This.enableRobustException = false />
	
	<cffunction name="onCFCRequest">
		<cfsetting requesttimeout="300" />
	</cffunction>
	
</cfcomponent>
