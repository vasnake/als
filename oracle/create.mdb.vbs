' Create new empty MDB file
' cscript.exe /nologo create.mdb.vbs

Const Jet10 = 1
Const Jet11 = 2
Const Jet20 = 3
Const Jet3x = 4
Const Jet4x = 5

Sub CreateNewMDBADO(FileName, Format)
  Dim Catalog
  Set Catalog = CreateObject("ADOX.Catalog")
  Catalog.Create "Provider=Microsoft.Jet.OLEDB.4.0;" & _
    "Jet OLEDB:Engine Type=" & Format & _
    ";Data Source=" & FileName
End Sub

Const dbVersion10 = 1
Const dbVersion11 = 8
Const dbVersion20 = 16
Const dbVersion30 = 32
Const dbVersion40 = 64

Sub CreateNewMDBDAO(FileName, Format)
  Dim Engine
  Set Engine = CreateObject("DAO.DBEngine.36")
  Engine.CreateDatabase FileName, ";LANGID=0x0409;CP=1251;COUNTRY=0", Format
End Sub

'Create Access2000 database
CreateNewMDBDAO ".\a2000.mdb", dbVersion40

'Create Access2000 database
CreateNewMDBADO ".\b2000.mdb", Jet4x
