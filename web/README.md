als frontend
============

Accident Localization System, year 2005, gas networks.

This folder contains a web part of ALS.
All text files have encoding="WINDOWS-1251", beware.

* default.xml -- application index file. You'll need something like 'DirectoryIndex default.xml default.php' in your's Apache httpd config.
* mapwindow.xsl -- XSLT template for default.xml. Together they renders application page.
* acc.localiz.js -- application JavaScript functions, UI processing. Communicate with backend via AJAX.
* acc.localiz.php -- backend web interface. Process user requests made via JS and utilize Oracle PL/SQL package for calculations on gas network.

JS interface

* acclocObj.onHtmlBodyLoad() -- on page load.
* acclocObj.onPickPointButton() -- point the accident place.
* acclocObj.onLocalizButton() -- calculate disconnected consumers and valves to shut off.
* acclocObj.onResetButton() -- reset app state.
* acclocObj.onZoomCheckbox() -- zoom map to affected region.
* acclocObj.onOpenReportButton() -- open report page.

Other files

* acc.localiz.css
* acc.localiz.mwf
* acc.localiz.rep.js
* acc.localiz.rep.php
* acc.localiz.rep.xsl
* Accident.SMB
* globals.php
* help.html
* helpmark_a.png
* helpmark.png
* topotest.mwf
* topotestN.mwf
* utils.inc.php
* vdb.inc.php
