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
