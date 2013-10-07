//TODO: loading indicator

$( document ).ready(function() {
	var engineID = 1;
	var fID = "0";
	if(window.location.hash) {
		// Fragment exists
		var fragmentArray = jQuery.param.fragment().split("/");
		if (fragmentArray.length>1) {
			engineID = fragmentArray[0];
			fID = fragmentArray[1];
		}
	}
	// initialize CodeMirror editor
	myCodeMirror = CodeMirror.fromTextArea(	fCode, {lineNumbers:true} );
	if (fID != "0") {
		$('#fID').val(fID);
		// if we have a fiddle, load it up and run it
		var codeXhr = $.get('./fiddle.cfc?method=getFiddleCode&fID=' + fID + '&returnformat=json');
		codeXhr.done(function(data) {
			// set the CodeMirror editor accordingly
			myCodeMirror.setValue(jQuery.parseJSON(data));
			runCode(fID);
		});
	}
});


function highlightLine(codeMirror, lineNumber) {
	// TODO: make this work
    //Line number is zero based index
    var actualLineNumber = lineNumber - 1;
        
    //Set line css class
    codeMirror.addLineClass(actualLineNumber, 'background', 'line-error');
}
function runCode(fID) {
	// use Ajax to run a Fiddle and put the output into the right DIV 
	var runXhr = $.get('./fiddle.cfc?method=runFiddle&fID=' + fID + '&returnformat=json');
	runXhr.done(function(data) {
		var runResult = jQuery.parseJSON(data);
		$('#fOutput').html(runResult.FOUTPUT.trim());
		$('#runtime').html('Executed in ' + runResult.FTIME + ' ms');
		if (!jQuery.isEmptyObject(runResult.FERROR)) {
			$('#runerror').html(prettyPrint(runResult.FERROR));
		}
	});
}
function saveAndRunCode() {
	var newFID = "abc";
	var fiddleObj = {};
	fiddleObj.fCode = myCodeMirror.getValue();
	
	$('#runtime').html('');
	$('#runerror').html('');
	
	// post via Ajax to save a Fiddle 
	var saveXhr = $.post('./fiddle.cfc?method=saveFiddle&returnformat=json', $.param(fiddleObj) );
	
	saveXhr.done(function(data) {
		var runResult = jQuery.parseJSON(data);
		newFID = runResult.FID.trim();
		// grab the new fiddle ID and push to the hash state
		jQuery.bbq.pushState('1/' + newFID,2);
		runCode(newFID);;
	});

}
$(window).bind( 'hashchange', function(e) {
	var fragmentArray = $.param.fragment().split("/");
	// blank out the code areas
	myCodeMirror.setValue('');
	$('#fOutput').html('');
	$('#runtime').html('');
	$('#runerror').html('');
	
	if (fragmentArray.length>1) {
		engineID = fragmentArray[0];
		fID = fragmentArray[1];
		if (fID != "0") {
			$('#fID').val(fID);
			// if we have a fiddle, load it up and run it
			var codeXhr = $.get('./fiddle.cfc?method=getFiddleCode&fID=' + fID + '&returnformat=json');
			codeXhr.done(function(data) {
				// set the CodeMirror editor accordingly
				myCodeMirror.setValue(jQuery.parseJSON(data));
				runCode(fID);
			});
		}
	}
	
});