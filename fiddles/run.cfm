<cfparam name="fID" default="0" />
<cfparam name="run" default="#StructNew()#" />
<cfparam name="run.fID" default="#LCase(fID)#" />
<cfparam name="run.fOutput" default="" />
<cfparam name="run.fError" default="#StructNew()#" />
<cfparam name="run.fTime" default="0" />

<cfset fTimeStart = GetTickCount() />
<cftry>
	<cfsavecontent variable="run.fOutput">
		<cfinclude template="f_#LCase(fID)#.cfm">
	</cfsavecontent>
	<cfcatch>
		<cfset run.fError.message = cfcatch.message />
		<cfset run.fError.detail = cfcatch.detail />
		<cfif StructKeyExists(cfcatch,"line")>
			<cfset run.fError.line = cfcatch.line />
		</cfif>
	</cfcatch>
</cftry>
<cfset fTimeEnd = GetTickCount() />
<cfset run.fTime = fTimeEnd - fTimeStart />
