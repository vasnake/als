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
* acc.localiz.rep.js -- report page scripts.

JS interface

* acclocObj.onHtmlBodyLoad() -- on page load.
* acclocObj.onPickPointButton() -- point the accident place.
* acclocObj.onLocalizButton() -- calculate disconnected consumers and valves to shut off.
* acclocObj.onResetButton() -- reset app state.
* acclocObj.onZoomCheckbox() -- zoom map to affected region.
* acclocObj.onOpenReportButton() -- open report page.

JS report interface

* onAccLocalizPageLoad() -- on page load, check if printer friendly formatting needed.
* accLocalizRepShowMap() -- open map window.

PL/SQL interface, package functions used in PHP code

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

* acc.localiz.css -- CSS styles
* acc.localiz.mwf -- MapGuide map file
* acc.localiz.rep.php -- deprecated
* Accident.SMB -- symbol for accident marking
* globals.php -- lib module
* help.html -- info page
* helpmark_a.png -- button picture
* helpmark.png -- button picture
* topotest.mwf -- MapGuide map file
* topotestN.mwf -- MapGuide map file
* utils.inc.php -- lib module
* vdb.inc.php -- lib module
