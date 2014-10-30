@rem load SHP to Oracle Spatial

rem set ORACONN=scott/tiger@gisdb.vsrb
set ORACONN=scott/tiger@gisdb
set NLS_LANG=AMERICAN_AMERICA.CL8MSWIN1251

cd shp

sqlplus.exe %ORACONN% @boil.sql
sqlplus.exe %ORACONN% @bolt.sql
sqlplus.exe %ORACONN% @grp.sql
sqlplus.exe %ORACONN% @grs.sql
sqlplus.exe %ORACONN% @pipe.sql

pause
::exit

set NLS_LANG=RUSSIAN_CIS.CL8MSWIN1251
set NLS_LANG=AMERICAN_AMERICA.CL8MSWIN1251
SET NLS_NUMERIC_CHARACTERS=.,

sqlldr.exe %ORACONN% boil.ctl
sqlldr.exe %ORACONN% bolt.ctl
sqlldr.exe %ORACONN% grp.ctl
sqlldr.exe %ORACONN% grs.ctl
sqlldr.exe %ORACONN% pipe.ctl

pause
exit
