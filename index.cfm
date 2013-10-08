<!--- initialize variables - note that typically we will receive via JS as part of the hash.fragment --->
<cfparam name="fID" default="" />
<cfparam name="fCode" default="" />
<cfparam name="embed" default="false" />

<cfparam name="fOutput" default="" />
<cfparam name="fTime" default="" />
<cfparam name="fError" default="#StructNew()#" />

<cfset rootURL = ReplaceNoCase(CGI.SCRIPT_NAME,"/index.cfm","") />

<cfif embed EQ "false">
	<cfinclude template="editor.cfm" />
<cfelse>
	<cfinclude template="embed.cfm" />
</cfif>