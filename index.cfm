<cfif isDefined("form.create")>
	<cflocation url="create.cfm" >
</cfif>

<html> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>URL Shortener</title>
	</head>
	<body> 
		<h1>URL List</h1> 
		<cfquery name="URList" datasource="URLShortenerAPI"> 
			SELECT link, shortlink 
			FROM urls
		</cfquery> 
		<cfoutput query="URList"> 
			#link#, <a href='#application.oContent.getLink(shortlink)#'>#shortlink#</a><br> 
		</cfoutput> 

		<form action="index.cfm" method="post">
			<input type="submit" name="create" value="Add a URL">	
		</form>
	</body> 
</html>