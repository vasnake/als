REM ~ step 2: copy non-spatial data from MS SQLServer to MDB

@echo off

del /f ?2000.mdb.old 2>nul
ren ?2000.mdb ?2000.mdb.old 2>nul
cscript.exe /nologo create.mdb.vbs

@echo call DTS package sql2mdb from SQLServer EM

pause
exit

dtsrun /S . /E /N sql2mdb /F .\sql2mdb.ssf /!X
dtsrun /S . /E /F .\sql2mdb.ssf
dtsrun /F .\sql2mdb.ssf
