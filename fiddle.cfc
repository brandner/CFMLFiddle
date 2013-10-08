<cfcomponent output="false">
	
	<cfset variables.folderPath = ExpandPath('.') />
	<cfset variables.fiddleFolder = "fiddles" />
	<cfset variables.fiddleFilePrefix = "f" />
	
	<!--- TODO: support the engine parameter, the first in the hash - ACF vs Railo etc --->
	
	<cffunction name="init">
		
	</cffunction>
	
	<cffunction name="validFiddle" returnType="boolean" access="remote" description="Determine if the fiddle code is valid and allowed to run">
		<cfargument name="fCode" required="true" type="string" />
		<!--- TODO: complete this after proof of concept
			Some things to look out for:
			- Valid CFML
			- Eliminate dangerous tags and functions we cannot run (CFHTTP, CFEXECUTE, CFQUERY, etc)
			-- Perhaps we can replace some of them upon execution??
			- Eliminate variable references that might interfere with CFMLFiddle
		--->
		
		<cfset local.disallowedTags = "cfexecute,cffile,cfdirectory,cfinclude,cfhttp,cfquery,cfregistry,cfschedule,cfcomponent,cftransaction,cfdump,cfapplet,cfcache,cfchart,cfcollection,cfdocument,cfcontent,cfform,cfgrid,cfhtmlhead,cfimport" />
		<cfset local.disallowedFunctions = "trace,cache,file" />
		<cfloop list="#ListAppend(local.disallowedTags,local.disallowedFunctions)#" index="local.i">
			<cfif FindNoCase(local.i,arguments.fCode) GT 0>
				<cfreturn false />
			</cfif>
		</cfloop>
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="getFiddleLauncher" returnType="string" description="FUTURE Get the launching CFM script that needs to be called">
		<cfset local.returnLocation = "#variables.fiddleFolder#/run.cfm" />
		<cfreturn local.returnLocation />
	</cffunction>
	
	<cffunction name="getFiddleCode" returnType="string" access="remote" description="Given ID, get the fiddle code">
		<cfargument name="fID" required="true" type="string" />
		<cfset local.returnStruct = StructNew() />

		<cfset local.returnStruct.fID = arguments.fID />
		<cfset local.returnStruct.fCode = "" />
		
		<cfif arguments.fID NEQ 0>
			<cftry>
				<cffile action="read" file="#variables.folderPath#/#variables.fiddleFolder#/#variables.fiddleFilePrefix#_#Trim(arguments.fID)#.cfm" variable="local.returnStruct.fCode" />
				<cfset local.returnStruct.fCode = Replace(local.returnStruct.fCode,"^","##","ALL") />
				<cfcatch>
					<cfset local.returnStruct.fCode = "Invalid fiddle" />
				</cfcatch>
			</cftry>
		</cfif>

		<cfreturn local.returnStruct.fCode />
	</cffunction>
	
	<cffunction name="generateFiddleID" returnType="string" access="remote" description="Generate a new, random fiddle ID">
		<cfset local.returnCode = Right(CreateUUID(),12) />
		<cfreturn local.returnCode />
	</cffunction>
	
	<cffunction name="setFiddle" returnType="boolean" description="Given ID, code and path, save a fiddle">
		<cfargument name="fID" required="true" type="string" />
		<cfargument name="fCode" required="true" type="string" />
		<cfargument name="folderPath" required="true" type="string" />
		
		<cffile action="write" file="#arguments.folderPath#/#variables.fiddleFolder#/#variables.fiddleFilePrefix#_#Trim(LCase(arguments.fID))#.cfm" output="#arguments.fCode#" />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="runFiddle" returnType="struct" access="remote" description="Given ID, run a fiddle">
		<cfargument name="fID" required="true" type="string" />
		<cfset local.run = StructNew() />

		<cfif arguments.fID NEQ 0>
			<cfinclude template="#getFiddleLauncher(variables.folderPath)#" />
		</cfif>
		
		<cfreturn local.run />
	</cffunction>
	
	<cffunction name="saveFiddle" returnType="struct" access="remote" description="Given CFML code, save as a new fiddle">
		<cfargument name="fCode" required="true" type="string" />
		<cfset local.returnStruct = StructNew() />
		
		<cfif validFiddle(arguments.fCode)>
			<cfset local.returnStruct.fID = generateFiddleID() />
			<cfset setFiddle(local.returnStruct.fID, arguments.fCode, variables.folderPath) />
		</cfif>
		
		<cfreturn local.returnStruct />
	</cffunction>
</cfcomponent>