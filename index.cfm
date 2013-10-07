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

<cfoutput>
<form id="frmFiddle" name="frmFiddle" action="#CGI.SCRIPT_NAME#" method="post"> 
	<input type="hidden" id="fID" name="fID" value="" />
	<div>
		<!--- area for the code --->
		<div style="float:left;width:48%;">
	    <textarea id="fCode" name="fCode" label="code" html="yes" wrap="virtual" rows="20" cols="50"></textarea> 
		</div>
		<!--- area for the output --->
		<div style="float:right;width:48%;">
	    <textarea id="fOutput" name="fOutput" label="output" html="yes" disabled="yes" wrap="virtual" rows="20" cols="50"></textarea>
		</div>
	</div>
	<div style="clear:both;"></div>
	<!--- when button is clicked, save new fiddle and then immediately run it --->
	<input type="button" name="run" value="Run" onClick="saveAndRunCode($('##fID').val());" /> 
	<span id="runtime"><i></i></span>
	<div id="runerror" style="color:red"></div>
</form>
</cfoutput>

</body>
</html>