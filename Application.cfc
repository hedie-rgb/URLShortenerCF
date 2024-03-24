<cfcomponent output="false">
	
	<cfset this.Name="URLShortenerAPI">
	<cfset this.ApplicationTimeout=CreateTimeSpan(0,0,5,0)>
	
	<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Fires when the application is first created">
		<!--- delete and recreate the content cfc stored in the application scope --->
		<cfset StructDelete(application,"oContent")>
		<cfset application.oContent=CreateObject("component","API.content")>
 		<cfreturn true>
	</cffunction>
 
</cfcomponent>