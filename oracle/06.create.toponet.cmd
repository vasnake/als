@rem create network topology
@echo off

set ORACONN=scott/tiger@gisdb
set NLS_LANG=AMERICAN_AMERICA.CL8MSWIN1251

sqlplus.exe %ORACONN% @create.topo.net.01.sql
sqlplus.exe %ORACONN% @create.topo.net.02.sql
sqlplus.exe %ORACONN% @create.topo.net.03.sql

cls
@echo now you can use toponet.

sqlplus.exe %ORACONN% @create.topo.net.04.sql

pause
exit
