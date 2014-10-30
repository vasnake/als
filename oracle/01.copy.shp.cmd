REM ~ step 1: copy SHP files to work dir

@echo off
set website=E:\files\website\mosoblgaz

if not .%0. == .E:\files\data2\valik\_td\oracle.spatial\etl\01.copy.shp.cmd. (
    @echo bad work dir
    pause
    exit 0
)

md shp 2>nul

for %%i in (grp_shrp_mo_cdb grs_mo_cdb kotelnaya_mo_cdb truba_mo_cdb zadvizhka_mo_cdb) do (
    @echo fn: [%%i]
    copy /y %website%\maps\shemy_vysok_sredn_davlen_mo\%%i.shp .\shp\
    copy /y %website%\maps\shemy_vysok_sredn_davlen_mo\%%i.shx .\shp\
    copy /y %website%\maps\shemy_vysok_sredn_davlen_mo\%%i.dbf .\shp\
)

pause
exit 1
