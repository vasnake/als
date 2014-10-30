@rem copy attributes to Ora DB
@echo off

set ORACONN=scott/tiger@gisdb
set NLS_LANG=AMERICAN_AMERICA.CL8MSWIN1251

sqlplus.exe %ORACONN% @drop.objects.sql

cls
@echo call DTS package mdb2ora from SQLServer EM
copy /y a2000.mdb b2000.mdb

pause
exit

dtsrun /S . /E /N mdb2ora /F .\mdb2ora.ssf /!X
