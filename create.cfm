<cfif isDefined("form.action") and len(form.link)>
	<cfset result=application.oContent.insertURL(link)>
	<cfset shortlink=result.shortlink>
	<cfset signal=result.message>
	<cfif signal eq "successful">
		<cfset message="Your short URL is <a href='#application.oContent.getLink(shortlink)#'>#shortlink#</a>">
	<cfelseif signal eq "existed">
		<cfset message="This URL was already in the database and the short version is <a href='#application.oContent.getLink(shortlink)#'>#shortlink#</a>">
	<cfelse>
		<cfset message="URL could not be saved.">
	</cfif>
	
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>URL Shortener</title>
	</head>
	<body>
		<h1>URL Shortener</h1>
		
		<!--- if there is a variable defined called "message", display it --->
		<cfif isDefined("message")>
			<cfoutput><p>#message#</p></cfoutput>
		</cfif>
		
		<!--- display the add form --->
		<form action="create.cfm" method="post">
			<label for="link">URL to shorten</label>
			<input type="text" name="link" id="link" size="100"><br>
			<input type="submit" name="action" value="Submit">			
		</form>
		
	</body>
</html>