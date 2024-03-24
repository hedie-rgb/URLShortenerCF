<cfcomponent output="false">
	
	<cfset variables.dsn="URLShortenerAPI">
	
	<cffunction name="generateShortURL" returntype="string">
		
		<cfargument name="length" type="Numeric" required="true" default="4">
		<cfset var local=StructNew()>
		
		<!--- all allowable characters for the short URL --->
		<cfset local.chars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9">
		
		<!--- total number of possible characters --->
		<cfset local.radix=listlen(local.chars)>

		<!--- initialize the return variable --->
		<cfset local.shortlink="https://short.en/">
		
		<!--- adding a random character from our master list on each iteration  --->
		<cfloop from="1" to="#arguments.length#" index="i">
			
			<!--- generate a random number --->
			<cfset local.randnum=RandRange(1,local.radix)>
			
			<!--- add the character to the short link --->
			<cfset local.shortlink=local.shortlink & listGetAt(local.chars,local.randnum)>
		
		</cfloop>

		<!--- making sure each short link is unique --->
		<cfquery datasource="#variables.dsn#" name=idqry>
			SELECT 
				max(id) 
			as 
				lastId
			from 
				urls
		</cfquery>
		<cfset lastid = idqry.lastId>
		<cfif len(lastid)>
			<!--- for testing purposes
			<script>
				<cfoutput>
				console.log('not null #lastid#');
				</cfoutput>
			</script> --->
			<cfset lastid = incrementValue(lastid)>
		<cfelse>
			<!--- for testing purposes
			<script>
				<cfoutput>
				console.log('null #lastid#');
				</cfoutput>
			</script> --->
			<cfset lastid = 1>
		</cfif>
		<cfset local.shortlink=local.shortlink & lastid>
		
		<!--- return the generated random short link --->
		<cfreturn local.shortlink>
		
	</cffunction>
	
	<cffunction name="insertURL" returntype="struct">

		<cfargument name="link" type="String" required="true">
		<cfset var result=StructNew()>
		<cfset var returnVal=structNew()>

		<!--- create the short link --->
		<cfset result.shortlink = generateShortURL()>
		<!--- for testing purposes
		<script>
			<cfoutput>
			console.log('#result.shortlink#');
			</cfoutput>
		</script> --->
		
		
		<!--- error-catching block --->
		<!--- check if the link already exists in the database --->
		<cfquery datasource="#variables.dsn#" name="result.inserted">
			SELECT
				shortlink
			FROM
				urls
			WHERE
				link = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.link#">
		</cfquery>	
		<cfif result.inserted.RecordCount GTE 1>
			<cfset returnVal.message = "existed">
			<cfset returnVal.shortlink = result.inserted.shortlink>
		<cfelse>
			<cftry>
				<!--- try to insert the new link into the database --->
				<cfquery datasource="#variables.dsn#" name="result.qry" result="result.stats">
					INSERT INTO
						urls(
							link,
							shortlink
							)
					VALUES(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.link#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#result.shortlink#">
					)
				</cfquery>
				<!--- try to return the new shortlink value --->
				<cfquery datasource="#variables.dsn#" name="result.inserted">
					SELECT
						shortlink
					FROM
						urls
					WHERE
						id = <cfqueryparam cfsqltype="cf_sql_integer" value="#result.stats.IDENTITYCOL#">
				</cfquery>
				<cfset returnVal.message = "successful">
				<cfset returnVal.shortlink = result.inserted.shortlink>
			<cfcatch type="any">
				<!---<cfset result.inserted.shortlink="">
				<script>
					<cfoutput>
					console.log('#cfcatch.message#');
					</cfoutput>
				</script>--->
				<cfset returnVal.shortlink = "">
				<cfset returnVal.message = "unsuccessful">
			</cfcatch>
			</cftry>
		</cfif>
		
		<!--- return the result --->
		<cfreturn returnVal> 
	</cffunction>
	
	<cffunction name="getLink" returntype="string">

		<cfargument name="shortlink" type="string" required="true">
		<cfset var result="">

		<cfquery datasource="#variables.dsn#" name="result">
			SELECT
				Link
			FROM
				urls
			WHERE
				shortlink = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.shortlink#">
		</cfquery>

		<cfreturn result.link>
	</cffunction>
	
</cfcomponent>