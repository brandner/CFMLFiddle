<html>
<head><title>CFMLFiddle</title>
<script src="./js/codemirror-3.18/lib/codemirror.js"></script>
<link rel="stylesheet" href="./js/codemirror-3.18/lib/codemirror.css">
<link rel="stylesheet" href="./style.css">
<!---TODO: CFML mode for CodeMirror? <script src="./codemirror-3.18/mode/javascript/javascript.js"></script>--->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="./js/prettyprint.js"></script>
<script src="./script.js"></script>
</head>
<body>

<cfparam name="fID" default="" />
<cfparam name="fCode" default="" />
<cfparam name="fOutput" default="" />
<cfparam name="fTime" default="" />
<cfparam name="fError" default="#StructNew()#" />
<cfparam name="embed" default="code" />

<!--- if we are accepting via URL/FORM, be sure to load up the fiddle server-side --->
<cfif Len(Trim(fID)) GT 0>
	<cfscript>
		fObj = CreateObject("component","fiddle");
		fCode = fObj.getFiddleCode(Trim(fID));
		fStruct = fObj.runFiddle(Trim(fID));
		fOutput = fStruct.fOutput;
		//fTime = fStruct.fTime;
		//if (IsNumeric(fTime)) { fTime = "Executed in " & fTime & " ms"; }
		//fError = fStruct.fError;
	</cfscript>
</cfif>

<cfoutput>
<form id="frmFiddle" name="frmFiddle" action="#CGI.SCRIPT_NAME#" method="post"> 
	<input type="hidden" id="fID" name="fID" value="#fID#" />
	<cfif embed EQ "code">
	    <textarea id="fCode" name="fCode" label="code" html="yes" wrap="virtual" rows="20" cols="50">#fCode#</textarea> 
	<cfelse>
		<input type="hidden" id="fCode" name="fCode" value="" />
		<input type="hidden" id="hideCodeEditor" value="true" />
	</cfif>
	<cfif embed EQ "output">
	    <textarea id="fOutput" name="fOutput" label="output" html="yes" disabled="yes" wrap="virtual" rows="20" cols="50">#fOutput#</textarea>
	    <span id="runtime"><i>#fTime#</i></span>
		<div id="runerror"><cfif StructKeyExists(fError,"message")><cfdump var="#fError#" label="Error" /></cfif></div>
	</cfif>
	<br />
	<a href="#rootURL#/##1/#fID#" />View in CFMLFiddle</a>
</form>
</cfoutput>

</body>
</html>