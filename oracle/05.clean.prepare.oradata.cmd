@rem data cleansing and transforming
@echo off

set ORACONN=scott/tiger@gisdb
set NLS_LANG=AMERICAN_AMERICA.CL8MSWIN1251

sqlplus.exe %ORACONN% @prepare.data.01.sql

sqlplus.exe %ORACONN% @prepare.data.02.sql

pause
exit
