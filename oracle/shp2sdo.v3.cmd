REM ~ load SHP to Oracle Spatial (Spatial Data Option)

@echo off
@echo %~f0\..

@rem old: set PARAMS=-g geom -d -x (-180,180) -y (-90,90) -s 8192 -t 0.001 -v -f
set PARAMS=-g geom -d -x (33,41) -y (53,58) -t 0.0000001 -v -f
set path=%~f0\..\bin;C:\app\gnuwin32\bin;%path%

cd shp
del shp2sdo.log

shp2sdo.exe grp_shrp_mo_cdb grp %PARAMS% | tee -a shp2sdo.log
shp2sdo.exe grs_mo_cdb grs %PARAMS% | tee -a shp2sdo.log
shp2sdo.exe kotelnaya_mo_cdb boil %PARAMS% | tee -a shp2sdo.log
shp2sdo.exe truba_mo_cdb pipe %PARAMS% | tee -a shp2sdo.log
shp2sdo.exe zadvizhka_mo_cdb bolt %PARAMS% | tee -a shp2sdo.log

pause
exit
