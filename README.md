als
===

Accident Localization System, year 2005, gas networks.

This is a prototype of ALS for gas networks.
User interface was built using Autodesk MapGuide 6.5 ActiveX map viewer.
Well, it was time of MS Internet Explorer 6 and I wrote this web GIS application on
PHP (server code, DB interactions using MS ADO, ergo needs MS Windows),
XML/XSL (web page templates) and JS (user interface).

But real gem is the backend:

1. Data was loaded from shape (shp) files to Oracle DB with spatial cartridge.
2. Spatial data was cleansed and transformed.
3. Then topology was created based on that data.
4. Functions for topology analysis was developed.

All this tasks was performed using PL/SQL package that was written in two month. Maybe three.

Components

* web -- web frontend
* oracle -- PL/SQL code and other Oracle DB related stuff

Links

* http://mapguide.wordpress.com/2014/03/18/autodesk-mapguide-6-5-retired-but-still-downloadable/
* http://www.mapguide.com/help/ver6.5/api/en/
* http://vasnake.blogspot.ru/2005/11/plsql.html
