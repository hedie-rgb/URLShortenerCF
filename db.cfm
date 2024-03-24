Creating database...

<cfquery datasource="URLShortenerAPI" result="return">
	CREATE TABLE urls
	(
		id Integer GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1) not null primary key,
		link VARCHAR(500) NOT NULL,
		shortlink VARCHAR(500) NOT NULL,
		CONSTRAINT link_uc UNIQUE(link)  
	)
</cfquery>

<cfdump var="#return#">
