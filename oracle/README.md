als frontend
============

Accident Localization System, year 2005, gas networks.

This folder contains a PL/SQL code and other Oracle DB related parts of ALS.

PL/SQL web interface, package functions used in PHP code

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
