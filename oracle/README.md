als backend
===========

Accident Localization System, year 2005, gas networks.

This folder contains a PL/SQL code and other Oracle DB related parts of ALS.

[Note](http://www.orafaq.com/wiki/Spatial): Oracle Spatial was previously known as SDO (Spatial Data Option) and before that as MultiDimension.

* 01.copy.shp.cmd -- copy SHP files to work dir.
* 02.copy.attr2mdb.cmd -- copy non-spatial data from MS SQL Server to MDB
    * create.mdb.vbs -- create new empty MDB file.
    * sql2mdb.bas, sql2mdb.ssf -- MS SQL Server DTS package for data copying.
* 03.load.shp2ora.cmd -- load spatial data from SHP files to Oracle SDO
    * shp2sdo.v3.cmd -- convert SHP using shp2sdo.exe, Shapefile(r) To Oracle Spatial Converter. As a result files tablename.ctl and tablename.sql will be created along with logfile shp2sdo.log.
    * sql.loader.v3.cmd -- load spatial data from SQL/CTL files to Oracle DB.
* 04.load.attr2ora.cmd -- load non-spatial data from MDB to Oracle DB
    * drop.objects.sql -- drop old version of data.
    * mdb2ora.ssf -- MS SQL Server DTS package for data copying.
* 05.clean.prepare.oradata.cmd -- cleanse and transform spatial data in Oracle DB
    * prepare.data.01.sql -- filter actual data.
    * prepare.data.02.sql -- update metadata, indexes; check geometry.
* 06.create.toponet.cmd -- create network topology
    * create.topo.net.01.sql -- create topology tables.
    * create.topo.net.02.sql -- find all network nodes.
    * create.topo.net.03.sql -- find all network links.
    * create.topo.net.04.sql -- find all flow sources.
* mogtopo.plsql.package.v2.sql -- PL/SQL package 'mogTopo', network topology functions.

### PL/SQL web interface, package functions used in PHP code

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
