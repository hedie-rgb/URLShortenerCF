# URLShortener API

This is an API to shorten URLs written in CFML(Coldfusion).

## How to work with the project

### Install Coldfusion

You can use the instructions on [this](https://www.quackit.com/coldfusion/tutorial/coldfusion_installation.cfm) website to install Coldfusion.

### Install Lucee

To run the project locally, you need to download and install your appropriate Lucee installer using [this](https://download.lucee.org/) website.

### IDE

I used VSCode as an IDE. VSCode has an extension to build and run Coldfusion projects. You can install and find more about this extension [here](https://marketplace.visualstudio.com/items?itemName=com-adobe-coldfusion.adobe-cfml-lsp).

## Add a serer

- Using the VSCode extension add a Coldfusion server with the name localhost and port 8500. You need to enter RDS username and password.
- For ServerHome you need to find the directory in which Coldfusion is installed.
- For Document Root, you need to set it as your web root.
- Select your Coldfusion version and you are done.

## Import project

- Clone the repository and import the CFML project using the VSCode extension.
- Open the project settings and in the Coldfusion Server Settings section, set your local development server as localhost.

## Set up database

- I used Apache Derby as my database. You need to launch Coldfusion Administartor by right clicking on the server name and choosing the option.
- You need to login by the username and password you first chose while adding the server.
- Add a new datasource by the name URLShortenerAPI and choose Apache Derby Embedded from the driver dropdown.
- Use URLShortenerAPI for the Database Folder (same as the data source name), and create a database.

## Create the urls table

You need to run the db.cfm file to make a simple table with the columns, id, link and shortlink. Id is used to make unique short links.

## index.cfm

This file is a view to list all the existing entries in the database and a button to add new URL. Each short URL shown on this page will redirect you to the associated URL to it.

## create.cfm

This file is a view to add a new URL in our table. The URL will not be added if it already exists in the database.

## API.Content.cfc

This is the file containing all the logic to implement the shortening process of URLs. It contains 3 functions:
- generateShortURL:
  - All short URLs will start with https://short.en/ and then 4 random letters or numbers will be added to the end of the string. To ensure each short URL is unique, we will add the id of the future row to the newly generated short link. This function will return the created short URL.
- insertURL:
  - Each time that a new entry needs to be added, first we would check if it already exists in the database, if yes, then the short URL associated with it and the appropriate message will be returned.
  - If the previous scenario didn't happen we will try to insert the new entry. If this action was successful, then the newly generated short URL associated with it and the appropriate message will be returned.
  - If any unpredicted errors happened, an empty string and the appropriate message will be returned.
- getLink:
  - This function will return the URL associated with the a short link.
