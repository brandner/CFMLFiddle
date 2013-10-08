<html>
<head><title>CFMLFiddle</title>
<script src="./js/codemirror-3.18/lib/codemirror.js"></script>
<link rel="stylesheet" href="./js/codemirror-3.18/lib/codemirror.css">
<link rel="stylesheet" href="./style.css">
<!---TODO: CFML mode for CodeMirror? <script src="./codemirror-3.18/mode/javascript/javascript.js"></script>--->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<!--- jQuery BBQ for hash handling and history management --->
<script src="./js/jquery.ba-bbq.js"></script>
<script src="./js/prettyprint.js"></script>
<script src="./script.js"></script>
</head>
<body>

<cfparam name="fID" default="" />
<cfparam name="fCode" default="" />
<cfparam name="fOutput" default="" />
<cfparam name="fTime" default="" />
<cfparam name="fError" default="#StructNew()#" />

<!--- if we are accepting via URL/FORM, be sure to load up the fiddle server-side --->
<cfif Len(Trim(fID)) GT 0>
	<cfscript>
		fObj = CreateObject("component","fiddle");
		fCode = fObj.getFiddleCode(Trim(fID));
		fStruct = fObj.runFiddle(Trim(fID));
		fOutput = fStruct.fOutput;
		fTime = fStruct.fTime;
		if (IsNumeric(fTime)) { fTime = "Executed in " & fTime & " ms"; }
		fError = fStruct.fError;
	</cfscript>
</cfif>

<cfoutput>
<form id="frmFiddle" name="frmFiddle" action="#CGI.SCRIPT_NAME#" method="post"> 
	<input type="hidden" id="fID" name="fID" value="#fID#" />
	<div>
		<!--- area for the code --->
		<div style="float:left;width:48%;">
		    <textarea id="fCode" name="fCode" label="code" html="yes" wrap="virtual" rows="20" cols="50">#fCode#</textarea>
		    <br />
		    <a id="embedLinkCode" href="#rootURL#?embed=code&fID=#fID#" />Embed code</a>
			| <a id="embedLinkOutput" href="#rootURL#?embed=output&fID=#fID#" />Embed output</a>
		</div>
		<!--- area for the output --->
		<div style="float:right;width:48%;">
	    	<textarea id="fOutput" name="fOutput" label="output" html="yes" disabled="yes" wrap="virtual" rows="20" cols="50">#fOutput#</textarea>
		</div>
	</div>
	<div style="clear:both;"></div>
	<!--- when button is clicked, save new fiddle and then immediately run it --->
	<input type="button" name="run" value="Run" onClick="saveAndRunCode($('##fID').val());" /> 
	<span id="runtime"><i>#fTime#</i></span>
	<div id="runerror"><cfif StructKeyExists(fError,"message")><cfdump var="#fError#" label="Error" /></cfif></div>
</form>
</cfoutput>

</body>
</html>