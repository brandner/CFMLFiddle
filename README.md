CFMLFiddle
==========

Web application allowing snippets of CFML code to be run for testing

Similar to sites like
- http://jsfiddle.net for Javascript
- http://sqlfiddle.com for SQL scripting (MS SQL, MySQL, PostgreSQL, etc)
- http://phpfiddle.org for PHP scripts

Installation
------------

To install, download the code onto a CFML Application server such as:
- Adobe ColdFusion - http://www.adobe.com/ca/products/coldfusion-family.html
- Railo - http://www.getrailo.org
- Open BlueDragon - http://openbd.org

Usage
-----

When you visit the CFMLFiddle URL, you will see a code editor window on the left and an output pane on the right.
Enter CFML code in the code editor, and click RUN.

The code will be saved, a unique fiddle ID will be generated, and the code will be run.
The approximate running time of the script and errors will be displayed at the bottom of the page.

Credit
------

This project is currently using:
- JQuery Javascript framework - http://jquery.com
- JQuery BBQ history manager - http://benalman.com/projects/jquery-bbq-plugin
- PrettyPrint JS dumper - https://github.com/padolsey/prettyPrint.js
- CodeMirror code editor - https://github.com/marijnh/codemirror

Roadmap
-------

Currently, this is a proof of concept.
Some elements that need to be reviewed:

- Secure the 'fiddles' directory for security
- Allow alternate (more secure) ways to run dynamic code, such as the CLI in Railo
- Exclude certain CFML tags and functions, if necessary
- Implement support for multiple CFML engines, as possible
- Implement loading indicator to indicate when code is being saved/executed
- Add CodeMirror mode for CFML
- 
