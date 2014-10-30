REM ~ step 3: load SHP to Oracle SDO

@echo off

start "shp2sdo" /wait shp2sdo.v3.cmd
start "sqlloader" /wait sql.loader.v3.cmd

@echo read shp\*.log for details...
pause
exit
