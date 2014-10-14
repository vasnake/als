als frontend
============

Accident Localization System, year 2005, gas networks.

This folder contains a web part of ALS.
All text files have encoding="WINDOWS-1251", beware.

* default.xml -- application index file. You'll need something like 'DirectoryIndex default.xml default.php' in your's Apache httpd config.
* mapwindow.xsl -- XSLT template for default.xml. Together they renders application page.
* acc.localiz.js -- application JavaScript functions, UI processing. Communicate with backend via AJAX.
* acc.localiz.php -- backend web interface. Process user requests made via JS and utilize Oracle PL/SQL package for calculations on gas network. Also generate report XML.
* acc.localiz.rep.xsl -- report page XSLT template.

JS interface

* acclocObj.onHtmlBodyLoad() -- on page load.
* acclocObj.onPickPointButton() -- point the accident place.
* acclocObj.onLocalizButton() -- calculate disconnected consumers and valves to shut off.
* acclocObj.onResetButton() -- reset app state.
* acclocObj.onZoomCheckbox() -- zoom map to affected region.
* acclocObj.onOpenReportButton() -- open report page.

PL/SQL interface

* mogTopo.getLinkByPoint -- find link nearest to point. Example

`select id, type, objid from topolink where id = mogTopo.getLinkByPoint(40.25449, 55.052117);`

* mogTopo.getLockers4FailedLinks -- find nodes (valves) to shut off failed links; find links that was choked. Example

`select * from table(mogTopo.getLockers4FailedLinks())`

* mogTopo.getDisconnByFailedLinks -- find disconnected consumers.
Second version of this function: mogTopo.getDisconnectedByDampedLinks2 can accept parameter longer than 4000 bytes. Example

```
select * from table(mogTopo.getDisconnByFailedLinks())
select * from table(mogTopo.getDisconnectedByDampedLinks2())
```

Other files

* acc.localiz.css
* acc.localiz.mwf
* acc.localiz.rep.js
* acc.localiz.rep.php
* Accident.SMB
* globals.php
* help.html
* helpmark_a.png
* helpmark.png
* topotest.mwf
* topotestN.mwf
* utils.inc.php
* vdb.inc.php
