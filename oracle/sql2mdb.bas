'****************************************************************
'Microsoft SQL Server 2000
'Visual Basic file generated for DTS Package
'File Name: E:\files\data2\valik\_td\oracle.spatial\etl\sql2mdb.bas
'Package Name: sql2mdb
'Package Description: gas and org to mdb
'Generated Date: 07.12.2005
'Generated Time: 19:28:07
'****************************************************************

Option Explicit
Public goPackageOld As New DTS.Package
Public goPackage As DTS.Package2
Private Sub Main()
	set goPackage = goPackageOld

	goPackage.Name = "sql2mdb"
	goPackage.Description = "gas and org to mdb"
	goPackage.WriteCompletionStatusToNTEventLog = False
	goPackage.FailOnError = False
	goPackage.PackagePriorityClass = 2
	goPackage.MaxConcurrentSteps = 4
	goPackage.LineageOptions = 0
	goPackage.UseTransaction = True
	goPackage.TransactionIsolationLevel = 4096
	goPackage.AutoCommitTransaction = True
	goPackage.RepositoryMetadataOptions = 0
	goPackage.UseOLEDBServiceComponents = True
	goPackage.LogToSQLServer = False
	goPackage.LogServerFlags = 0
	goPackage.FailPackageOnLogFailure = False
	goPackage.ExplicitGlobalVariables = False
	goPackage.PackageType = 0
	

Dim oConnProperty As DTS.OleDBProperty

'---------------------------------------------------------------------------
' create package connection information
'---------------------------------------------------------------------------

Dim oConnection as DTS.Connection2

'------------- a new connection defined below.
'For security purposes, the password is never scripted

Set oConnection = goPackage.Connections.New("SQLOLEDB")

	oConnection.ConnectionProperties("Integrated Security") = "SSPI"
	oConnection.ConnectionProperties("Persist Security Info") = True
	oConnection.ConnectionProperties("Initial Catalog") = "MosOblGaz"
	oConnection.ConnectionProperties("Data Source") = "(local)"
	oConnection.ConnectionProperties("Application Name") = "DTS  Import/Export Wizard"
	
	oConnection.Name = "Connection 1"
	oConnection.ID = 1
	oConnection.Reusable = True
	oConnection.ConnectImmediate = False
	oConnection.DataSource = "(local)"
	oConnection.ConnectionTimeout = 60
	oConnection.Catalog = "MosOblGaz"
	oConnection.UseTrustedConnection = True
	oConnection.UseDSL = False
	
	'If you have a password for this connection, please uncomment and add your password below.
	'oConnection.Password = "<put the password here>"

goPackage.Connections.Add oConnection
Set oConnection = Nothing

'------------- a new connection defined below.
'For security purposes, the password is never scripted

Set oConnection = goPackage.Connections.New("Microsoft.Jet.OLEDB.4.0")

	oConnection.ConnectionProperties("Data Source") = "E:\files\data2\valik\_td\oracle.spatial\etl\a2000.mdb"
	oConnection.ConnectionProperties("Mode") = 3
	
	oConnection.Name = "Connection 2"
	oConnection.ID = 2
	oConnection.Reusable = True
	oConnection.ConnectImmediate = False
	oConnection.DataSource = "E:\files\data2\valik\_td\oracle.spatial\etl\a2000.mdb"
	oConnection.ConnectionTimeout = 60
	oConnection.UseTrustedConnection = False
	oConnection.UseDSL = False
	
	'If you have a password for this connection, please uncomment and add your password below.
	'oConnection.Password = "<put the password here>"

goPackage.Connections.Add oConnection
Set oConnection = Nothing

'------------- a new connection defined below.
'For security purposes, the password is never scripted

Set oConnection = goPackage.Connections.New("SQLOLEDB")

	oConnection.ConnectionProperties("Integrated Security") = "SSPI"
	oConnection.ConnectionProperties("Persist Security Info") = True
	oConnection.ConnectionProperties("Initial Catalog") = "MosOblGaz"
	oConnection.ConnectionProperties("Data Source") = "(local)"
	oConnection.ConnectionProperties("Application Name") = "DTS  Import/Export Wizard"
	
	oConnection.Name = "Connection 3"
	oConnection.ID = 3
	oConnection.Reusable = True
	oConnection.ConnectImmediate = False
	oConnection.DataSource = "(local)"
	oConnection.ConnectionTimeout = 60
	oConnection.Catalog = "MosOblGaz"
	oConnection.UseTrustedConnection = True
	oConnection.UseDSL = False
	
	'If you have a password for this connection, please uncomment and add your password below.
	'oConnection.Password = "<put the password here>"

goPackage.Connections.Add oConnection
Set oConnection = Nothing

'------------- a new connection defined below.
'For security purposes, the password is never scripted

Set oConnection = goPackage.Connections.New("Microsoft.Jet.OLEDB.4.0")

	oConnection.ConnectionProperties("Data Source") = "E:\files\data2\valik\_td\oracle.spatial\etl\a2000.mdb"
	oConnection.ConnectionProperties("Mode") = 3
	
	oConnection.Name = "Connection 4"
	oConnection.ID = 4
	oConnection.Reusable = True
	oConnection.ConnectImmediate = False
	oConnection.DataSource = "E:\files\data2\valik\_td\oracle.spatial\etl\a2000.mdb"
	oConnection.ConnectionTimeout = 60
	oConnection.UseTrustedConnection = False
	oConnection.UseDSL = False
	
	'If you have a password for this connection, please uncomment and add your password below.
	'oConnection.Password = "<put the password here>"

goPackage.Connections.Add oConnection
Set oConnection = Nothing

'---------------------------------------------------------------------------
' create package steps information
'---------------------------------------------------------------------------

Dim oStep as DTS.Step2
Dim oPrecConstraint as DTS.PrecedenceConstraint

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table Boiler Step"
	oStep.Description = "Create Table Boiler Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table Boiler Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from Boiler to Boiler Step"
	oStep.Description = "Copy Data from Boiler to Boiler Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from Boiler to Boiler Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table Bolt Step"
	oStep.Description = "Create Table Bolt Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table Bolt Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from Bolt to Bolt Step"
	oStep.Description = "Copy Data from Bolt to Bolt Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from Bolt to Bolt Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GasEquipment Step"
	oStep.Description = "Create Table GasEquipment Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GasEquipment Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GasEquipment to GasEquipment Step"
	oStep.Description = "Copy Data from GasEquipment to GasEquipment Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GasEquipment to GasEquipment Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GasObjectProperty Step"
	oStep.Description = "Create Table GasObjectProperty Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GasObjectProperty Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GasObjectProperty to GasObjectProperty Step"
	oStep.Description = "Copy Data from GasObjectProperty to GasObjectProperty Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GasObjectProperty to GasObjectProperty Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GasObjectStatus Step"
	oStep.Description = "Create Table GasObjectStatus Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GasObjectStatus Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GasObjectStatus to GasObjectStatus Step"
	oStep.Description = "Copy Data from GasObjectStatus to GasObjectStatus Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GasObjectStatus to GasObjectStatus Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GRP Step"
	oStep.Description = "Create Table GRP Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GRP Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GRP to GRP Step"
	oStep.Description = "Copy Data from GRP to GRP Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GRP to GRP Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GRP_PressureType Step"
	oStep.Description = "Create Table GRP_PressureType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GRP_PressureType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GRP_PressureType to GRP_PressureType Step"
	oStep.Description = "Copy Data from GRP_PressureType to GRP_PressureType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GRP_PressureType to GRP_PressureType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GrpGasEquipGroup Step"
	oStep.Description = "Create Table GrpGasEquipGroup Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GrpGasEquipGroup Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Step"
	oStep.Description = "Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GrpHeatEquipGroup Step"
	oStep.Description = "Create Table GrpHeatEquipGroup Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GrpHeatEquipGroup Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Step"
	oStep.Description = "Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GrpPurpose Step"
	oStep.Description = "Create Table GrpPurpose Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GrpPurpose Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GrpPurpose to GrpPurpose Step"
	oStep.Description = "Copy Data from GrpPurpose to GrpPurpose Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GrpPurpose to GrpPurpose Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GrpSubType Step"
	oStep.Description = "Create Table GrpSubType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GrpSubType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GrpSubType to GrpSubType Step"
	oStep.Description = "Copy Data from GrpSubType to GrpSubType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GrpSubType to GrpSubType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GrpType Step"
	oStep.Description = "Create Table GrpType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GrpType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GrpType to GrpType Step"
	oStep.Description = "Copy Data from GrpType to GrpType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GrpType to GrpType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table GRS Step"
	oStep.Description = "Create Table GRS Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table GRS Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from GRS to GRS Step"
	oStep.Description = "Copy Data from GRS to GRS Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from GRS to GRS Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table HeatingEquipment Step"
	oStep.Description = "Create Table HeatingEquipment Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table HeatingEquipment Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from HeatingEquipment to HeatingEquipment Step"
	oStep.Description = "Copy Data from HeatingEquipment to HeatingEquipment Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from HeatingEquipment to HeatingEquipment Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table Pipe Step"
	oStep.Description = "Create Table Pipe Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table Pipe Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from Pipe to Pipe Step"
	oStep.Description = "Copy Data from Pipe to Pipe Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from Pipe to Pipe Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table PipeArterial Step"
	oStep.Description = "Create Table PipeArterial Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table PipeArterial Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from PipeArterial to PipeArterial Step"
	oStep.Description = "Copy Data from PipeArterial to PipeArterial Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from PipeArterial to PipeArterial Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table PipeLateral Step"
	oStep.Description = "Create Table PipeLateral Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table PipeLateral Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from PipeLateral to PipeLateral Step"
	oStep.Description = "Copy Data from PipeLateral to PipeLateral Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from PipeLateral to PipeLateral Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table PipeStuff Step"
	oStep.Description = "Create Table PipeStuff Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table PipeStuff Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from PipeStuff to PipeStuff Step"
	oStep.Description = "Copy Data from PipeStuff to PipeStuff Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from PipeStuff to PipeStuff Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table PressureType Step"
	oStep.Description = "Create Table PressureType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table PressureType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from PressureType to PressureType Step"
	oStep.Description = "Copy Data from PressureType to PressureType Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from PressureType to PressureType Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table ADS Step"
	oStep.Description = "Create Table ADS Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table ADS Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from ADS to ADS Step"
	oStep.Description = "Copy Data from ADS to ADS Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from ADS to ADS Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table Department Step"
	oStep.Description = "Create Table Department Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table Department Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from Department to Department Step"
	oStep.Description = "Copy Data from Department to Department Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from Department to Department Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Create Table Service Step"
	oStep.Description = "Create Table Service Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Create Table Service Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = False
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a new step defined below

Set oStep = goPackage.Steps.New

	oStep.Name = "Copy Data from Service to Service Step"
	oStep.Description = "Copy Data from Service to Service Step"
	oStep.ExecutionStatus = 1
	oStep.TaskName = "Copy Data from Service to Service Task"
	oStep.CommitSuccess = False
	oStep.RollbackFailure = False
	oStep.ScriptLanguage = "VBScript"
	oStep.AddGlobalVariables = True
	oStep.RelativePriority = 3
	oStep.CloseConnection = False
	oStep.ExecuteInMainThread = True
	oStep.IsPackageDSORowset = False
	oStep.JoinTransactionIfPresent = False
	oStep.DisableStep = False
	oStep.FailPackageOnError = False
	
goPackage.Steps.Add oStep
Set oStep = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from Boiler to Boiler Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table Boiler Step")
	oPrecConstraint.StepName = "Create Table Boiler Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from Bolt to Bolt Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table Bolt Step")
	oPrecConstraint.StepName = "Create Table Bolt Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GasEquipment to GasEquipment Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GasEquipment Step")
	oPrecConstraint.StepName = "Create Table GasEquipment Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GasObjectProperty to GasObjectProperty Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GasObjectProperty Step")
	oPrecConstraint.StepName = "Create Table GasObjectProperty Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GasObjectStatus to GasObjectStatus Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GasObjectStatus Step")
	oPrecConstraint.StepName = "Create Table GasObjectStatus Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GRP to GRP Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GRP Step")
	oPrecConstraint.StepName = "Create Table GRP Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GRP_PressureType to GRP_PressureType Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GRP_PressureType Step")
	oPrecConstraint.StepName = "Create Table GRP_PressureType Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GrpGasEquipGroup Step")
	oPrecConstraint.StepName = "Create Table GrpGasEquipGroup Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GrpHeatEquipGroup Step")
	oPrecConstraint.StepName = "Create Table GrpHeatEquipGroup Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GrpPurpose to GrpPurpose Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GrpPurpose Step")
	oPrecConstraint.StepName = "Create Table GrpPurpose Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GrpSubType to GrpSubType Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GrpSubType Step")
	oPrecConstraint.StepName = "Create Table GrpSubType Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GrpType to GrpType Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GrpType Step")
	oPrecConstraint.StepName = "Create Table GrpType Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from GRS to GRS Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table GRS Step")
	oPrecConstraint.StepName = "Create Table GRS Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from HeatingEquipment to HeatingEquipment Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table HeatingEquipment Step")
	oPrecConstraint.StepName = "Create Table HeatingEquipment Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from Pipe to Pipe Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table Pipe Step")
	oPrecConstraint.StepName = "Create Table Pipe Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from PipeArterial to PipeArterial Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table PipeArterial Step")
	oPrecConstraint.StepName = "Create Table PipeArterial Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from PipeLateral to PipeLateral Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table PipeLateral Step")
	oPrecConstraint.StepName = "Create Table PipeLateral Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from PipeStuff to PipeStuff Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table PipeStuff Step")
	oPrecConstraint.StepName = "Create Table PipeStuff Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from PressureType to PressureType Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table PressureType Step")
	oPrecConstraint.StepName = "Create Table PressureType Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from ADS to ADS Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table ADS Step")
	oPrecConstraint.StepName = "Create Table ADS Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from Department to Department Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table Department Step")
	oPrecConstraint.StepName = "Create Table Department Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'------------- a precedence constraint for steps defined below

Set oStep = goPackage.Steps("Copy Data from Service to Service Step")
Set oPrecConstraint = oStep.PrecedenceConstraints.New("Create Table Service Step")
	oPrecConstraint.StepName = "Create Table Service Step"
	oPrecConstraint.PrecedenceBasis = 0
	oPrecConstraint.Value = 4
	
oStep.precedenceConstraints.Add oPrecConstraint
Set oPrecConstraint = Nothing

'---------------------------------------------------------------------------
' create package tasks information
'---------------------------------------------------------------------------

'------------- call Task_Sub1 for task Create Table Boiler Task (Create Table Boiler Task)
Call Task_Sub1( goPackage	)

'------------- call Task_Sub2 for task Copy Data from Boiler to Boiler Task (Copy Data from Boiler to Boiler Task)
Call Task_Sub2( goPackage	)

'------------- call Task_Sub3 for task Create Table Bolt Task (Create Table Bolt Task)
Call Task_Sub3( goPackage	)

'------------- call Task_Sub4 for task Copy Data from Bolt to Bolt Task (Copy Data from Bolt to Bolt Task)
Call Task_Sub4( goPackage	)

'------------- call Task_Sub5 for task Create Table GasEquipment Task (Create Table GasEquipment Task)
Call Task_Sub5( goPackage	)

'------------- call Task_Sub6 for task Copy Data from GasEquipment to GasEquipment Task (Copy Data from GasEquipment to GasEquipment Task)
Call Task_Sub6( goPackage	)

'------------- call Task_Sub7 for task Create Table GasObjectProperty Task (Create Table GasObjectProperty Task)
Call Task_Sub7( goPackage	)

'------------- call Task_Sub8 for task Copy Data from GasObjectProperty to GasObjectProperty Task (Copy Data from GasObjectProperty to GasObjectProperty Task)
Call Task_Sub8( goPackage	)

'------------- call Task_Sub9 for task Create Table GasObjectStatus Task (Create Table GasObjectStatus Task)
Call Task_Sub9( goPackage	)

'------------- call Task_Sub10 for task Copy Data from GasObjectStatus to GasObjectStatus Task (Copy Data from GasObjectStatus to GasObjectStatus Task)
Call Task_Sub10( goPackage	)

'------------- call Task_Sub11 for task Create Table GRP Task (Create Table GRP Task)
Call Task_Sub11( goPackage	)

'------------- call Task_Sub12 for task Copy Data from GRP to GRP Task (Copy Data from GRP to GRP Task)
Call Task_Sub12( goPackage	)

'------------- call Task_Sub13 for task Create Table GRP_PressureType Task (Create Table GRP_PressureType Task)
Call Task_Sub13( goPackage	)

'------------- call Task_Sub14 for task Copy Data from GRP_PressureType to GRP_PressureType Task (Copy Data from GRP_PressureType to GRP_PressureType Task)
Call Task_Sub14( goPackage	)

'------------- call Task_Sub15 for task Create Table GrpGasEquipGroup Task (Create Table GrpGasEquipGroup Task)
Call Task_Sub15( goPackage	)

'------------- call Task_Sub16 for task Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task (Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task)
Call Task_Sub16( goPackage	)

'------------- call Task_Sub17 for task Create Table GrpHeatEquipGroup Task (Create Table GrpHeatEquipGroup Task)
Call Task_Sub17( goPackage	)

'------------- call Task_Sub18 for task Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task (Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task)
Call Task_Sub18( goPackage	)

'------------- call Task_Sub19 for task Create Table GrpPurpose Task (Create Table GrpPurpose Task)
Call Task_Sub19( goPackage	)

'------------- call Task_Sub20 for task Copy Data from GrpPurpose to GrpPurpose Task (Copy Data from GrpPurpose to GrpPurpose Task)
Call Task_Sub20( goPackage	)

'------------- call Task_Sub21 for task Create Table GrpSubType Task (Create Table GrpSubType Task)
Call Task_Sub21( goPackage	)

'------------- call Task_Sub22 for task Copy Data from GrpSubType to GrpSubType Task (Copy Data from GrpSubType to GrpSubType Task)
Call Task_Sub22( goPackage	)

'------------- call Task_Sub23 for task Create Table GrpType Task (Create Table GrpType Task)
Call Task_Sub23( goPackage	)

'------------- call Task_Sub24 for task Copy Data from GrpType to GrpType Task (Copy Data from GrpType to GrpType Task)
Call Task_Sub24( goPackage	)

'------------- call Task_Sub25 for task Create Table GRS Task (Create Table GRS Task)
Call Task_Sub25( goPackage	)

'------------- call Task_Sub26 for task Copy Data from GRS to GRS Task (Copy Data from GRS to GRS Task)
Call Task_Sub26( goPackage	)

'------------- call Task_Sub27 for task Create Table HeatingEquipment Task (Create Table HeatingEquipment Task)
Call Task_Sub27( goPackage	)

'------------- call Task_Sub28 for task Copy Data from HeatingEquipment to HeatingEquipment Task (Copy Data from HeatingEquipment to HeatingEquipment Task)
Call Task_Sub28( goPackage	)

'------------- call Task_Sub29 for task Create Table Pipe Task (Create Table Pipe Task)
Call Task_Sub29( goPackage	)

'------------- call Task_Sub30 for task Copy Data from Pipe to Pipe Task (Copy Data from Pipe to Pipe Task)
Call Task_Sub30( goPackage	)

'------------- call Task_Sub31 for task Create Table PipeArterial Task (Create Table PipeArterial Task)
Call Task_Sub31( goPackage	)

'------------- call Task_Sub32 for task Copy Data from PipeArterial to PipeArterial Task (Copy Data from PipeArterial to PipeArterial Task)
Call Task_Sub32( goPackage	)

'------------- call Task_Sub33 for task Create Table PipeLateral Task (Create Table PipeLateral Task)
Call Task_Sub33( goPackage	)

'------------- call Task_Sub34 for task Copy Data from PipeLateral to PipeLateral Task (Copy Data from PipeLateral to PipeLateral Task)
Call Task_Sub34( goPackage	)

'------------- call Task_Sub35 for task Create Table PipeStuff Task (Create Table PipeStuff Task)
Call Task_Sub35( goPackage	)

'------------- call Task_Sub36 for task Copy Data from PipeStuff to PipeStuff Task (Copy Data from PipeStuff to PipeStuff Task)
Call Task_Sub36( goPackage	)

'------------- call Task_Sub37 for task Create Table PressureType Task (Create Table PressureType Task)
Call Task_Sub37( goPackage	)

'------------- call Task_Sub38 for task Copy Data from PressureType to PressureType Task (Copy Data from PressureType to PressureType Task)
Call Task_Sub38( goPackage	)

'------------- call Task_Sub39 for task Create Table ADS Task (Create Table ADS Task)
Call Task_Sub39( goPackage	)

'------------- call Task_Sub40 for task Copy Data from ADS to ADS Task (Copy Data from ADS to ADS Task)
Call Task_Sub40( goPackage	)

'------------- call Task_Sub41 for task Create Table Department Task (Create Table Department Task)
Call Task_Sub41( goPackage	)

'------------- call Task_Sub42 for task Copy Data from Department to Department Task (Copy Data from Department to Department Task)
Call Task_Sub42( goPackage	)

'------------- call Task_Sub43 for task Create Table Service Task (Create Table Service Task)
Call Task_Sub43( goPackage	)

'------------- call Task_Sub44 for task Copy Data from Service to Service Task (Copy Data from Service to Service Task)
Call Task_Sub44( goPackage	)

'---------------------------------------------------------------------------
' Save or execute package
'---------------------------------------------------------------------------

'goPackage.SaveToSQLServer "(local)", "sa", ""
goPackage.Execute
tracePackageError goPackage
goPackage.Uninitialize
'to save a package instead of executing it, comment out the executing package line above and uncomment the saving package line
set goPackage = Nothing

set goPackageOld = Nothing

End Sub


'-----------------------------------------------------------------------------
' error reporting using step.GetExecutionErrorInfo after execution
'-----------------------------------------------------------------------------
Public Sub tracePackageError(oPackage As DTS.Package)
Dim ErrorCode As Long
Dim ErrorSource As String
Dim ErrorDescription As String
Dim ErrorHelpFile As String
Dim ErrorHelpContext As Long
Dim ErrorIDofInterfaceWithError As String
Dim i As Integer

	For i = 1 To oPackage.Steps.Count
		If oPackage.Steps(i).ExecutionResult = DTSStepExecResult_Failure Then
			oPackage.Steps(i).GetExecutionErrorInfo ErrorCode, ErrorSource, ErrorDescription, _
					ErrorHelpFile, ErrorHelpContext, ErrorIDofInterfaceWithError
			MsgBox oPackage.Steps(i).Name & " failed" & vbCrLf & ErrorSource & vbCrLf & ErrorDescription
		End If
	Next i

End Sub

'------------- define Task_Sub1 for task Create Table Boiler Task (Create Table Boiler Task)
Public Sub Task_Sub1(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask1 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table Boiler Task"
Set oCustomTask1 = oTask.CustomTask

	oCustomTask1.Name = "Create Table Boiler Task"
	oCustomTask1.Description = "Create Table Boiler Task"
	oCustomTask1.SQLStatement = "CREATE TABLE `Boiler` (" & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`BoilerID` Long NOT NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`DepartmentID` Long NOT NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`BoilerNumber` VarChar (20) NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`BoilerInfoSource` VarChar (255) NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`BoilerComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`BoilerPower` Double NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`GasObjStatusID` Long NOT NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`GasObjPropertyID` Long NOT NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`BoilerWorkField` VarChar (255) NULL, " & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & "`ServiceID` Long NULL" & vbCrLf
	oCustomTask1.SQLStatement = oCustomTask1.SQLStatement & ")"
	oCustomTask1.ConnectionID = 2
	oCustomTask1.CommandTimeout = 0
	oCustomTask1.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask1 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub2 for task Copy Data from Boiler to Boiler Task (Copy Data from Boiler to Boiler Task)
Public Sub Task_Sub2(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask2 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from Boiler to Boiler Task"
Set oCustomTask2 = oTask.CustomTask

	oCustomTask2.Name = "Copy Data from Boiler to Boiler Task"
	oCustomTask2.Description = "Copy Data from Boiler to Boiler Task"
	oCustomTask2.SourceConnectionID = 1
	oCustomTask2.SourceSQLStatement = "select [BoilerID],[DepartmentID],[BoilerNumber],[BoilerInfoSource],[BoilerComment],[BoilerPower],[GasObjStatusID],[GasObjPropertyID],[BoilerWorkField],[ServiceID] from [MosOblGaz].[Gas].[Boiler]"
	oCustomTask2.DestinationConnectionID = 2
	oCustomTask2.DestinationObjectName = "Boiler"
	oCustomTask2.ProgressRowCount = 1000
	oCustomTask2.MaximumErrorCount = 0
	oCustomTask2.FetchBufferSize = 1
	oCustomTask2.UseFastLoad = True
	oCustomTask2.InsertCommitSize = 0
	oCustomTask2.ExceptionFileColumnDelimiter = "|"
	oCustomTask2.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask2.AllowIdentityInserts = False
	oCustomTask2.FirstRow = 0
	oCustomTask2.LastRow = 0
	oCustomTask2.FastLoadOptions = 2
	oCustomTask2.ExceptionFileOptions = 1
	oCustomTask2.DataPumpOptions = 0
	
Call oCustomTask2_Trans_Sub1( oCustomTask2	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask2 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask2_Trans_Sub1(ByVal oCustomTask2 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask2.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("BoilerID" , 1)
			oColumn.Name = "BoilerID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 2)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoilerNumber" , 3)
			oColumn.Name = "BoilerNumber"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoilerInfoSource" , 4)
			oColumn.Name = "BoilerInfoSource"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoilerComment" , 5)
			oColumn.Name = "BoilerComment"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoilerPower" , 6)
			oColumn.Name = "BoilerPower"
			oColumn.Ordinal = 6
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasObjStatusID" , 7)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 7
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasObjPropertyID" , 8)
			oColumn.Name = "GasObjPropertyID"
			oColumn.Ordinal = 8
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoilerWorkField" , 9)
			oColumn.Name = "BoilerWorkField"
			oColumn.Ordinal = 9
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceID" , 10)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoilerID" , 1)
			oColumn.Name = "BoilerID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 2)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoilerNumber" , 3)
			oColumn.Name = "BoilerNumber"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoilerInfoSource" , 4)
			oColumn.Name = "BoilerInfoSource"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoilerComment" , 5)
			oColumn.Name = "BoilerComment"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoilerPower" , 6)
			oColumn.Name = "BoilerPower"
			oColumn.Ordinal = 6
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjStatusID" , 7)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 7
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjPropertyID" , 8)
			oColumn.Name = "GasObjPropertyID"
			oColumn.Ordinal = 8
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoilerWorkField" , 9)
			oColumn.Name = "BoilerWorkField"
			oColumn.Ordinal = 9
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceID" , 10)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask2.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub3 for task Create Table Bolt Task (Create Table Bolt Task)
Public Sub Task_Sub3(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask3 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table Bolt Task"
Set oCustomTask3 = oTask.CustomTask

	oCustomTask3.Name = "Create Table Bolt Task"
	oCustomTask3.Description = "Create Table Bolt Task"
	oCustomTask3.SQLStatement = "CREATE TABLE `Bolt` (" & vbCrLf
	oCustomTask3.SQLStatement = oCustomTask3.SQLStatement & "`BoltID` Long NOT NULL, " & vbCrLf
	oCustomTask3.SQLStatement = oCustomTask3.SQLStatement & "`DepartmentID` Long NOT NULL, " & vbCrLf
	oCustomTask3.SQLStatement = oCustomTask3.SQLStatement & "`BoltInfoSource` VarChar (255) NULL, " & vbCrLf
	oCustomTask3.SQLStatement = oCustomTask3.SQLStatement & "`BoltComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask3.SQLStatement = oCustomTask3.SQLStatement & "`BoltWorkField` VarChar (255) NULL, " & vbCrLf
	oCustomTask3.SQLStatement = oCustomTask3.SQLStatement & "`ServiceID` Long NULL" & vbCrLf
	oCustomTask3.SQLStatement = oCustomTask3.SQLStatement & ")"
	oCustomTask3.ConnectionID = 4
	oCustomTask3.CommandTimeout = 0
	oCustomTask3.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask3 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub4 for task Copy Data from Bolt to Bolt Task (Copy Data from Bolt to Bolt Task)
Public Sub Task_Sub4(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask4 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from Bolt to Bolt Task"
Set oCustomTask4 = oTask.CustomTask

	oCustomTask4.Name = "Copy Data from Bolt to Bolt Task"
	oCustomTask4.Description = "Copy Data from Bolt to Bolt Task"
	oCustomTask4.SourceConnectionID = 3
	oCustomTask4.SourceSQLStatement = "select [BoltID],[DepartmentID],[BoltInfoSource],[BoltComment],[BoltWorkField],[ServiceID] from [MosOblGaz].[Gas].[Bolt]"
	oCustomTask4.DestinationConnectionID = 4
	oCustomTask4.DestinationObjectName = "Bolt"
	oCustomTask4.ProgressRowCount = 1000
	oCustomTask4.MaximumErrorCount = 0
	oCustomTask4.FetchBufferSize = 1
	oCustomTask4.UseFastLoad = True
	oCustomTask4.InsertCommitSize = 0
	oCustomTask4.ExceptionFileColumnDelimiter = "|"
	oCustomTask4.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask4.AllowIdentityInserts = False
	oCustomTask4.FirstRow = 0
	oCustomTask4.LastRow = 0
	oCustomTask4.FastLoadOptions = 2
	oCustomTask4.ExceptionFileOptions = 1
	oCustomTask4.DataPumpOptions = 0
	
Call oCustomTask4_Trans_Sub1( oCustomTask4	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask4 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask4_Trans_Sub1(ByVal oCustomTask4 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask4.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("BoltID" , 1)
			oColumn.Name = "BoltID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 2)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoltInfoSource" , 3)
			oColumn.Name = "BoltInfoSource"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoltComment" , 4)
			oColumn.Name = "BoltComment"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BoltWorkField" , 5)
			oColumn.Name = "BoltWorkField"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceID" , 6)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 6
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoltID" , 1)
			oColumn.Name = "BoltID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 2)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoltInfoSource" , 3)
			oColumn.Name = "BoltInfoSource"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoltComment" , 4)
			oColumn.Name = "BoltComment"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BoltWorkField" , 5)
			oColumn.Name = "BoltWorkField"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceID" , 6)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 6
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask4.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub5 for task Create Table GasEquipment Task (Create Table GasEquipment Task)
Public Sub Task_Sub5(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask5 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GasEquipment Task"
Set oCustomTask5 = oTask.CustomTask

	oCustomTask5.Name = "Create Table GasEquipment Task"
	oCustomTask5.Description = "Create Table GasEquipment Task"
	oCustomTask5.SQLStatement = "CREATE TABLE `GasEquipment` (" & vbCrLf
	oCustomTask5.SQLStatement = oCustomTask5.SQLStatement & "`GasEquipID` Long NOT NULL, " & vbCrLf
	oCustomTask5.SQLStatement = oCustomTask5.SQLStatement & "`GasEquipName` VarChar (32) NULL" & vbCrLf
	oCustomTask5.SQLStatement = oCustomTask5.SQLStatement & ")"
	oCustomTask5.ConnectionID = 2
	oCustomTask5.CommandTimeout = 0
	oCustomTask5.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask5 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub6 for task Copy Data from GasEquipment to GasEquipment Task (Copy Data from GasEquipment to GasEquipment Task)
Public Sub Task_Sub6(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask6 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GasEquipment to GasEquipment Task"
Set oCustomTask6 = oTask.CustomTask

	oCustomTask6.Name = "Copy Data from GasEquipment to GasEquipment Task"
	oCustomTask6.Description = "Copy Data from GasEquipment to GasEquipment Task"
	oCustomTask6.SourceConnectionID = 1
	oCustomTask6.SourceSQLStatement = "select [GasEquipID],[GasEquipName] from [MosOblGaz].[Gas].[GasEquipment]"
	oCustomTask6.DestinationConnectionID = 2
	oCustomTask6.DestinationObjectName = "GasEquipment"
	oCustomTask6.ProgressRowCount = 1000
	oCustomTask6.MaximumErrorCount = 0
	oCustomTask6.FetchBufferSize = 1
	oCustomTask6.UseFastLoad = True
	oCustomTask6.InsertCommitSize = 0
	oCustomTask6.ExceptionFileColumnDelimiter = "|"
	oCustomTask6.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask6.AllowIdentityInserts = False
	oCustomTask6.FirstRow = 0
	oCustomTask6.LastRow = 0
	oCustomTask6.FastLoadOptions = 2
	oCustomTask6.ExceptionFileOptions = 1
	oCustomTask6.DataPumpOptions = 0
	
Call oCustomTask6_Trans_Sub1( oCustomTask6	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask6 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask6_Trans_Sub1(ByVal oCustomTask6 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask6.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GasEquipID" , 1)
			oColumn.Name = "GasEquipID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasEquipName" , 2)
			oColumn.Name = "GasEquipName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 32
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasEquipID" , 1)
			oColumn.Name = "GasEquipID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasEquipName" , 2)
			oColumn.Name = "GasEquipName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 32
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask6.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub7 for task Create Table GasObjectProperty Task (Create Table GasObjectProperty Task)
Public Sub Task_Sub7(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask7 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GasObjectProperty Task"
Set oCustomTask7 = oTask.CustomTask

	oCustomTask7.Name = "Create Table GasObjectProperty Task"
	oCustomTask7.Description = "Create Table GasObjectProperty Task"
	oCustomTask7.SQLStatement = "CREATE TABLE `GasObjectProperty` (" & vbCrLf
	oCustomTask7.SQLStatement = oCustomTask7.SQLStatement & "`GasObjPropertyID` Long NOT NULL, " & vbCrLf
	oCustomTask7.SQLStatement = oCustomTask7.SQLStatement & "`GasObjPropertyName` VarChar (20) NULL" & vbCrLf
	oCustomTask7.SQLStatement = oCustomTask7.SQLStatement & ")"
	oCustomTask7.ConnectionID = 4
	oCustomTask7.CommandTimeout = 0
	oCustomTask7.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask7 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub8 for task Copy Data from GasObjectProperty to GasObjectProperty Task (Copy Data from GasObjectProperty to GasObjectProperty Task)
Public Sub Task_Sub8(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask8 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GasObjectProperty to GasObjectProperty Task"
Set oCustomTask8 = oTask.CustomTask

	oCustomTask8.Name = "Copy Data from GasObjectProperty to GasObjectProperty Task"
	oCustomTask8.Description = "Copy Data from GasObjectProperty to GasObjectProperty Task"
	oCustomTask8.SourceConnectionID = 3
	oCustomTask8.SourceSQLStatement = "select [GasObjPropertyID],[GasObjPropertyName] from [MosOblGaz].[Gas].[GasObjectProperty]"
	oCustomTask8.DestinationConnectionID = 4
	oCustomTask8.DestinationObjectName = "GasObjectProperty"
	oCustomTask8.ProgressRowCount = 1000
	oCustomTask8.MaximumErrorCount = 0
	oCustomTask8.FetchBufferSize = 1
	oCustomTask8.UseFastLoad = True
	oCustomTask8.InsertCommitSize = 0
	oCustomTask8.ExceptionFileColumnDelimiter = "|"
	oCustomTask8.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask8.AllowIdentityInserts = False
	oCustomTask8.FirstRow = 0
	oCustomTask8.LastRow = 0
	oCustomTask8.FastLoadOptions = 2
	oCustomTask8.ExceptionFileOptions = 1
	oCustomTask8.DataPumpOptions = 0
	
Call oCustomTask8_Trans_Sub1( oCustomTask8	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask8 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask8_Trans_Sub1(ByVal oCustomTask8 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask8.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GasObjPropertyID" , 1)
			oColumn.Name = "GasObjPropertyID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasObjPropertyName" , 2)
			oColumn.Name = "GasObjPropertyName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjPropertyID" , 1)
			oColumn.Name = "GasObjPropertyID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjPropertyName" , 2)
			oColumn.Name = "GasObjPropertyName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask8.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub9 for task Create Table GasObjectStatus Task (Create Table GasObjectStatus Task)
Public Sub Task_Sub9(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask9 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GasObjectStatus Task"
Set oCustomTask9 = oTask.CustomTask

	oCustomTask9.Name = "Create Table GasObjectStatus Task"
	oCustomTask9.Description = "Create Table GasObjectStatus Task"
	oCustomTask9.SQLStatement = "CREATE TABLE `GasObjectStatus` (" & vbCrLf
	oCustomTask9.SQLStatement = oCustomTask9.SQLStatement & "`GasObjStatusID` Long NOT NULL, " & vbCrLf
	oCustomTask9.SQLStatement = oCustomTask9.SQLStatement & "`GasObjStatusName` VarChar (20) NULL" & vbCrLf
	oCustomTask9.SQLStatement = oCustomTask9.SQLStatement & ")"
	oCustomTask9.ConnectionID = 2
	oCustomTask9.CommandTimeout = 0
	oCustomTask9.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask9 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub10 for task Copy Data from GasObjectStatus to GasObjectStatus Task (Copy Data from GasObjectStatus to GasObjectStatus Task)
Public Sub Task_Sub10(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask10 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GasObjectStatus to GasObjectStatus Task"
Set oCustomTask10 = oTask.CustomTask

	oCustomTask10.Name = "Copy Data from GasObjectStatus to GasObjectStatus Task"
	oCustomTask10.Description = "Copy Data from GasObjectStatus to GasObjectStatus Task"
	oCustomTask10.SourceConnectionID = 1
	oCustomTask10.SourceSQLStatement = "select [GasObjStatusID],[GasObjStatusName] from [MosOblGaz].[Gas].[GasObjectStatus]"
	oCustomTask10.DestinationConnectionID = 2
	oCustomTask10.DestinationObjectName = "GasObjectStatus"
	oCustomTask10.ProgressRowCount = 1000
	oCustomTask10.MaximumErrorCount = 0
	oCustomTask10.FetchBufferSize = 1
	oCustomTask10.UseFastLoad = True
	oCustomTask10.InsertCommitSize = 0
	oCustomTask10.ExceptionFileColumnDelimiter = "|"
	oCustomTask10.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask10.AllowIdentityInserts = False
	oCustomTask10.FirstRow = 0
	oCustomTask10.LastRow = 0
	oCustomTask10.FastLoadOptions = 2
	oCustomTask10.ExceptionFileOptions = 1
	oCustomTask10.DataPumpOptions = 0
	
Call oCustomTask10_Trans_Sub1( oCustomTask10	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask10 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask10_Trans_Sub1(ByVal oCustomTask10 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask10.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GasObjStatusID" , 1)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasObjStatusName" , 2)
			oColumn.Name = "GasObjStatusName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjStatusID" , 1)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjStatusName" , 2)
			oColumn.Name = "GasObjStatusName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask10.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub11 for task Create Table GRP Task (Create Table GRP Task)
Public Sub Task_Sub11(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask11 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GRP Task"
Set oCustomTask11 = oTask.CustomTask

	oCustomTask11.Name = "Create Table GRP Task"
	oCustomTask11.Description = "Create Table GRP Task"
	oCustomTask11.SQLStatement = "CREATE TABLE `GRP` (" & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`DepartmentID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`ServiceID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpSubTypeID` Long NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpTypeID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpNumber` VarChar (15) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpInfoSource` VarChar (255) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpPrivateID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpName` VarChar (100) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpAddress` VarChar (255) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpInventoryComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpBalanceComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpPointX` Double NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpPointY` Double NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpPointZ` Double NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpPurposeID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GasObjStatusID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`ReductLineCount` Long NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpIdSrc` Long NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`PressureTypeID` Long NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`BalanceGasObjPropertyID` Long NOT NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`ServiceGasObjPropertyID` Long NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpServiceComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & "`GrpWorkField` VarChar (255) NULL" & vbCrLf
	oCustomTask11.SQLStatement = oCustomTask11.SQLStatement & ")"
	oCustomTask11.ConnectionID = 4
	oCustomTask11.CommandTimeout = 0
	oCustomTask11.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask11 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub12 for task Copy Data from GRP to GRP Task (Copy Data from GRP to GRP Task)
Public Sub Task_Sub12(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask12 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GRP to GRP Task"
Set oCustomTask12 = oTask.CustomTask

	oCustomTask12.Name = "Copy Data from GRP to GRP Task"
	oCustomTask12.Description = "Copy Data from GRP to GRP Task"
	oCustomTask12.SourceConnectionID = 3
	oCustomTask12.SourceSQLStatement = "select [GrpID],[GrpComment],[DepartmentID],[ServiceID],[GrpSubTypeID],[GrpTypeID],[GrpNumber],[GrpInfoSource],[GrpPrivateID],[GrpName],[GrpAddress],[GrpInventoryComment],[GrpBalanceComment],[GrpPointX],[GrpPointY],[GrpPointZ],[GrpPurposeID],[GasObjStatusI"
	oCustomTask12.SourceSQLStatement = oCustomTask12.SourceSQLStatement & "D],[ReductLineCount],[GrpIdSrc],[PressureTypeID],[BalanceGasObjPropertyID],[ServiceGasObjPropertyID],[GrpServiceComment],[GrpWorkField] from [MosOblGaz].[Gas].[GRP]"
	oCustomTask12.DestinationConnectionID = 4
	oCustomTask12.DestinationObjectName = "GRP"
	oCustomTask12.ProgressRowCount = 1000
	oCustomTask12.MaximumErrorCount = 0
	oCustomTask12.FetchBufferSize = 1
	oCustomTask12.UseFastLoad = True
	oCustomTask12.InsertCommitSize = 0
	oCustomTask12.ExceptionFileColumnDelimiter = "|"
	oCustomTask12.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask12.AllowIdentityInserts = False
	oCustomTask12.FirstRow = 0
	oCustomTask12.LastRow = 0
	oCustomTask12.FastLoadOptions = 2
	oCustomTask12.ExceptionFileOptions = 1
	oCustomTask12.DataPumpOptions = 0
	
Call oCustomTask12_Trans_Sub1( oCustomTask12	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask12 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask12_Trans_Sub1(ByVal oCustomTask12 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask12.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrpID" , 1)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpComment" , 2)
			oColumn.Name = "GrpComment"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 3)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceID" , 4)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 4
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpSubTypeID" , 5)
			oColumn.Name = "GrpSubTypeID"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpTypeID" , 6)
			oColumn.Name = "GrpTypeID"
			oColumn.Ordinal = 6
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpNumber" , 7)
			oColumn.Name = "GrpNumber"
			oColumn.Ordinal = 7
			oColumn.Flags = 104
			oColumn.Size = 15
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpInfoSource" , 8)
			oColumn.Name = "GrpInfoSource"
			oColumn.Ordinal = 8
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpPrivateID" , 9)
			oColumn.Name = "GrpPrivateID"
			oColumn.Ordinal = 9
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpName" , 10)
			oColumn.Name = "GrpName"
			oColumn.Ordinal = 10
			oColumn.Flags = 104
			oColumn.Size = 100
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpAddress" , 11)
			oColumn.Name = "GrpAddress"
			oColumn.Ordinal = 11
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpInventoryComment" , 12)
			oColumn.Name = "GrpInventoryComment"
			oColumn.Ordinal = 12
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpBalanceComment" , 13)
			oColumn.Name = "GrpBalanceComment"
			oColumn.Ordinal = 13
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpPointX" , 14)
			oColumn.Name = "GrpPointX"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpPointY" , 15)
			oColumn.Name = "GrpPointY"
			oColumn.Ordinal = 15
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpPointZ" , 16)
			oColumn.Name = "GrpPointZ"
			oColumn.Ordinal = 16
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpPurposeID" , 17)
			oColumn.Name = "GrpPurposeID"
			oColumn.Ordinal = 17
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasObjStatusID" , 18)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 18
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ReductLineCount" , 19)
			oColumn.Name = "ReductLineCount"
			oColumn.Ordinal = 19
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpIdSrc" , 20)
			oColumn.Name = "GrpIdSrc"
			oColumn.Ordinal = 20
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PressureTypeID" , 21)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 21
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("BalanceGasObjPropertyID" , 22)
			oColumn.Name = "BalanceGasObjPropertyID"
			oColumn.Ordinal = 22
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceGasObjPropertyID" , 23)
			oColumn.Name = "ServiceGasObjPropertyID"
			oColumn.Ordinal = 23
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpServiceComment" , 24)
			oColumn.Name = "GrpServiceComment"
			oColumn.Ordinal = 24
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpWorkField" , 25)
			oColumn.Name = "GrpWorkField"
			oColumn.Ordinal = 25
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpID" , 1)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpComment" , 2)
			oColumn.Name = "GrpComment"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 3)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceID" , 4)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 4
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpSubTypeID" , 5)
			oColumn.Name = "GrpSubTypeID"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpTypeID" , 6)
			oColumn.Name = "GrpTypeID"
			oColumn.Ordinal = 6
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpNumber" , 7)
			oColumn.Name = "GrpNumber"
			oColumn.Ordinal = 7
			oColumn.Flags = 104
			oColumn.Size = 15
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpInfoSource" , 8)
			oColumn.Name = "GrpInfoSource"
			oColumn.Ordinal = 8
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPrivateID" , 9)
			oColumn.Name = "GrpPrivateID"
			oColumn.Ordinal = 9
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpName" , 10)
			oColumn.Name = "GrpName"
			oColumn.Ordinal = 10
			oColumn.Flags = 104
			oColumn.Size = 100
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpAddress" , 11)
			oColumn.Name = "GrpAddress"
			oColumn.Ordinal = 11
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpInventoryComment" , 12)
			oColumn.Name = "GrpInventoryComment"
			oColumn.Ordinal = 12
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpBalanceComment" , 13)
			oColumn.Name = "GrpBalanceComment"
			oColumn.Ordinal = 13
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPointX" , 14)
			oColumn.Name = "GrpPointX"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPointY" , 15)
			oColumn.Name = "GrpPointY"
			oColumn.Ordinal = 15
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPointZ" , 16)
			oColumn.Name = "GrpPointZ"
			oColumn.Ordinal = 16
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPurposeID" , 17)
			oColumn.Name = "GrpPurposeID"
			oColumn.Ordinal = 17
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjStatusID" , 18)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 18
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ReductLineCount" , 19)
			oColumn.Name = "ReductLineCount"
			oColumn.Ordinal = 19
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpIdSrc" , 20)
			oColumn.Name = "GrpIdSrc"
			oColumn.Ordinal = 20
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PressureTypeID" , 21)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 21
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("BalanceGasObjPropertyID" , 22)
			oColumn.Name = "BalanceGasObjPropertyID"
			oColumn.Ordinal = 22
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceGasObjPropertyID" , 23)
			oColumn.Name = "ServiceGasObjPropertyID"
			oColumn.Ordinal = 23
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpServiceComment" , 24)
			oColumn.Name = "GrpServiceComment"
			oColumn.Ordinal = 24
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpWorkField" , 25)
			oColumn.Name = "GrpWorkField"
			oColumn.Ordinal = 25
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask12.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub13 for task Create Table GRP_PressureType Task (Create Table GRP_PressureType Task)
Public Sub Task_Sub13(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask13 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GRP_PressureType Task"
Set oCustomTask13 = oTask.CustomTask

	oCustomTask13.Name = "Create Table GRP_PressureType Task"
	oCustomTask13.Description = "Create Table GRP_PressureType Task"
	oCustomTask13.SQLStatement = "CREATE TABLE `GRP_PressureType` (" & vbCrLf
	oCustomTask13.SQLStatement = oCustomTask13.SQLStatement & "`GrpPressureID` Long NOT NULL, " & vbCrLf
	oCustomTask13.SQLStatement = oCustomTask13.SQLStatement & "`GrpID` Long NOT NULL, " & vbCrLf
	oCustomTask13.SQLStatement = oCustomTask13.SQLStatement & "`PressureTypeID` Long NOT NULL" & vbCrLf
	oCustomTask13.SQLStatement = oCustomTask13.SQLStatement & ")"
	oCustomTask13.ConnectionID = 2
	oCustomTask13.CommandTimeout = 0
	oCustomTask13.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask13 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub14 for task Copy Data from GRP_PressureType to GRP_PressureType Task (Copy Data from GRP_PressureType to GRP_PressureType Task)
Public Sub Task_Sub14(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask14 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GRP_PressureType to GRP_PressureType Task"
Set oCustomTask14 = oTask.CustomTask

	oCustomTask14.Name = "Copy Data from GRP_PressureType to GRP_PressureType Task"
	oCustomTask14.Description = "Copy Data from GRP_PressureType to GRP_PressureType Task"
	oCustomTask14.SourceConnectionID = 1
	oCustomTask14.SourceSQLStatement = "select [GrpPressureID],[GrpID],[PressureTypeID] from [MosOblGaz].[Gas].[GRP_PressureType]"
	oCustomTask14.DestinationConnectionID = 2
	oCustomTask14.DestinationObjectName = "GRP_PressureType"
	oCustomTask14.ProgressRowCount = 1000
	oCustomTask14.MaximumErrorCount = 0
	oCustomTask14.FetchBufferSize = 1
	oCustomTask14.UseFastLoad = True
	oCustomTask14.InsertCommitSize = 0
	oCustomTask14.ExceptionFileColumnDelimiter = "|"
	oCustomTask14.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask14.AllowIdentityInserts = False
	oCustomTask14.FirstRow = 0
	oCustomTask14.LastRow = 0
	oCustomTask14.FastLoadOptions = 2
	oCustomTask14.ExceptionFileOptions = 1
	oCustomTask14.DataPumpOptions = 0
	
Call oCustomTask14_Trans_Sub1( oCustomTask14	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask14 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask14_Trans_Sub1(ByVal oCustomTask14 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask14.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrpPressureID" , 1)
			oColumn.Name = "GrpPressureID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpID" , 2)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PressureTypeID" , 3)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPressureID" , 1)
			oColumn.Name = "GrpPressureID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpID" , 2)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PressureTypeID" , 3)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask14.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub15 for task Create Table GrpGasEquipGroup Task (Create Table GrpGasEquipGroup Task)
Public Sub Task_Sub15(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask15 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GrpGasEquipGroup Task"
Set oCustomTask15 = oTask.CustomTask

	oCustomTask15.Name = "Create Table GrpGasEquipGroup Task"
	oCustomTask15.Description = "Create Table GrpGasEquipGroup Task"
	oCustomTask15.SQLStatement = "CREATE TABLE `GrpGasEquipGroup` (" & vbCrLf
	oCustomTask15.SQLStatement = oCustomTask15.SQLStatement & "`GrpGasEquipGroupID` Long NOT NULL, " & vbCrLf
	oCustomTask15.SQLStatement = oCustomTask15.SQLStatement & "`GrpID` Long NOT NULL, " & vbCrLf
	oCustomTask15.SQLStatement = oCustomTask15.SQLStatement & "`GasEquipID` Long NOT NULL, " & vbCrLf
	oCustomTask15.SQLStatement = oCustomTask15.SQLStatement & "`GasEquipCount` Long NULL, " & vbCrLf
	oCustomTask15.SQLStatement = oCustomTask15.SQLStatement & "`GasEquipYear` Long NULL" & vbCrLf
	oCustomTask15.SQLStatement = oCustomTask15.SQLStatement & ")"
	oCustomTask15.ConnectionID = 4
	oCustomTask15.CommandTimeout = 0
	oCustomTask15.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask15 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub16 for task Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task (Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task)
Public Sub Task_Sub16(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask16 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task"
Set oCustomTask16 = oTask.CustomTask

	oCustomTask16.Name = "Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task"
	oCustomTask16.Description = "Copy Data from GrpGasEquipGroup to GrpGasEquipGroup Task"
	oCustomTask16.SourceConnectionID = 3
	oCustomTask16.SourceSQLStatement = "select [GrpGasEquipGroupID],[GrpID],[GasEquipID],[GasEquipCount],[GasEquipYear] from [MosOblGaz].[Gas].[GrpGasEquipGroup]"
	oCustomTask16.DestinationConnectionID = 4
	oCustomTask16.DestinationObjectName = "GrpGasEquipGroup"
	oCustomTask16.ProgressRowCount = 1000
	oCustomTask16.MaximumErrorCount = 0
	oCustomTask16.FetchBufferSize = 1
	oCustomTask16.UseFastLoad = True
	oCustomTask16.InsertCommitSize = 0
	oCustomTask16.ExceptionFileColumnDelimiter = "|"
	oCustomTask16.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask16.AllowIdentityInserts = False
	oCustomTask16.FirstRow = 0
	oCustomTask16.LastRow = 0
	oCustomTask16.FastLoadOptions = 2
	oCustomTask16.ExceptionFileOptions = 1
	oCustomTask16.DataPumpOptions = 0
	
Call oCustomTask16_Trans_Sub1( oCustomTask16	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask16 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask16_Trans_Sub1(ByVal oCustomTask16 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask16.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrpGasEquipGroupID" , 1)
			oColumn.Name = "GrpGasEquipGroupID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpID" , 2)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasEquipID" , 3)
			oColumn.Name = "GasEquipID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasEquipCount" , 4)
			oColumn.Name = "GasEquipCount"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasEquipYear" , 5)
			oColumn.Name = "GasEquipYear"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpGasEquipGroupID" , 1)
			oColumn.Name = "GrpGasEquipGroupID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpID" , 2)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasEquipID" , 3)
			oColumn.Name = "GasEquipID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasEquipCount" , 4)
			oColumn.Name = "GasEquipCount"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasEquipYear" , 5)
			oColumn.Name = "GasEquipYear"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask16.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub17 for task Create Table GrpHeatEquipGroup Task (Create Table GrpHeatEquipGroup Task)
Public Sub Task_Sub17(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask17 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GrpHeatEquipGroup Task"
Set oCustomTask17 = oTask.CustomTask

	oCustomTask17.Name = "Create Table GrpHeatEquipGroup Task"
	oCustomTask17.Description = "Create Table GrpHeatEquipGroup Task"
	oCustomTask17.SQLStatement = "CREATE TABLE `GrpHeatEquipGroup` (" & vbCrLf
	oCustomTask17.SQLStatement = oCustomTask17.SQLStatement & "`GrpID` Long NOT NULL, " & vbCrLf
	oCustomTask17.SQLStatement = oCustomTask17.SQLStatement & "`GrpHeatEquipGroupID` Long NOT NULL, " & vbCrLf
	oCustomTask17.SQLStatement = oCustomTask17.SQLStatement & "`HeatEquipCount` Long NULL, " & vbCrLf
	oCustomTask17.SQLStatement = oCustomTask17.SQLStatement & "`HeatEquipYear` Long NULL, " & vbCrLf
	oCustomTask17.SQLStatement = oCustomTask17.SQLStatement & "`HeatEquipID` Long NULL" & vbCrLf
	oCustomTask17.SQLStatement = oCustomTask17.SQLStatement & ")"
	oCustomTask17.ConnectionID = 2
	oCustomTask17.CommandTimeout = 0
	oCustomTask17.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask17 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub18 for task Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task (Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task)
Public Sub Task_Sub18(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask18 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task"
Set oCustomTask18 = oTask.CustomTask

	oCustomTask18.Name = "Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task"
	oCustomTask18.Description = "Copy Data from GrpHeatEquipGroup to GrpHeatEquipGroup Task"
	oCustomTask18.SourceConnectionID = 1
	oCustomTask18.SourceSQLStatement = "select [GrpID],[GrpHeatEquipGroupID],[HeatEquipCount],[HeatEquipYear],[HeatEquipID] from [MosOblGaz].[Gas].[GrpHeatEquipGroup]"
	oCustomTask18.DestinationConnectionID = 2
	oCustomTask18.DestinationObjectName = "GrpHeatEquipGroup"
	oCustomTask18.ProgressRowCount = 1000
	oCustomTask18.MaximumErrorCount = 0
	oCustomTask18.FetchBufferSize = 1
	oCustomTask18.UseFastLoad = True
	oCustomTask18.InsertCommitSize = 0
	oCustomTask18.ExceptionFileColumnDelimiter = "|"
	oCustomTask18.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask18.AllowIdentityInserts = False
	oCustomTask18.FirstRow = 0
	oCustomTask18.LastRow = 0
	oCustomTask18.FastLoadOptions = 2
	oCustomTask18.ExceptionFileOptions = 1
	oCustomTask18.DataPumpOptions = 0
	
Call oCustomTask18_Trans_Sub1( oCustomTask18	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask18 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask18_Trans_Sub1(ByVal oCustomTask18 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask18.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrpID" , 1)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpHeatEquipGroupID" , 2)
			oColumn.Name = "GrpHeatEquipGroupID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("HeatEquipCount" , 3)
			oColumn.Name = "HeatEquipCount"
			oColumn.Ordinal = 3
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("HeatEquipYear" , 4)
			oColumn.Name = "HeatEquipYear"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("HeatEquipID" , 5)
			oColumn.Name = "HeatEquipID"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpID" , 1)
			oColumn.Name = "GrpID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpHeatEquipGroupID" , 2)
			oColumn.Name = "GrpHeatEquipGroupID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("HeatEquipCount" , 3)
			oColumn.Name = "HeatEquipCount"
			oColumn.Ordinal = 3
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("HeatEquipYear" , 4)
			oColumn.Name = "HeatEquipYear"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("HeatEquipID" , 5)
			oColumn.Name = "HeatEquipID"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask18.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub19 for task Create Table GrpPurpose Task (Create Table GrpPurpose Task)
Public Sub Task_Sub19(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask19 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GrpPurpose Task"
Set oCustomTask19 = oTask.CustomTask

	oCustomTask19.Name = "Create Table GrpPurpose Task"
	oCustomTask19.Description = "Create Table GrpPurpose Task"
	oCustomTask19.SQLStatement = "CREATE TABLE `GrpPurpose` (" & vbCrLf
	oCustomTask19.SQLStatement = oCustomTask19.SQLStatement & "`GrpPurposeID` Long NOT NULL, " & vbCrLf
	oCustomTask19.SQLStatement = oCustomTask19.SQLStatement & "`GrpPurposeName` VarChar (30) NULL" & vbCrLf
	oCustomTask19.SQLStatement = oCustomTask19.SQLStatement & ")"
	oCustomTask19.ConnectionID = 4
	oCustomTask19.CommandTimeout = 0
	oCustomTask19.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask19 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub20 for task Copy Data from GrpPurpose to GrpPurpose Task (Copy Data from GrpPurpose to GrpPurpose Task)
Public Sub Task_Sub20(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask20 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GrpPurpose to GrpPurpose Task"
Set oCustomTask20 = oTask.CustomTask

	oCustomTask20.Name = "Copy Data from GrpPurpose to GrpPurpose Task"
	oCustomTask20.Description = "Copy Data from GrpPurpose to GrpPurpose Task"
	oCustomTask20.SourceConnectionID = 3
	oCustomTask20.SourceSQLStatement = "select [GrpPurposeID],[GrpPurposeName] from [MosOblGaz].[Gas].[GrpPurpose]"
	oCustomTask20.DestinationConnectionID = 4
	oCustomTask20.DestinationObjectName = "GrpPurpose"
	oCustomTask20.ProgressRowCount = 1000
	oCustomTask20.MaximumErrorCount = 0
	oCustomTask20.FetchBufferSize = 1
	oCustomTask20.UseFastLoad = True
	oCustomTask20.InsertCommitSize = 0
	oCustomTask20.ExceptionFileColumnDelimiter = "|"
	oCustomTask20.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask20.AllowIdentityInserts = False
	oCustomTask20.FirstRow = 0
	oCustomTask20.LastRow = 0
	oCustomTask20.FastLoadOptions = 2
	oCustomTask20.ExceptionFileOptions = 1
	oCustomTask20.DataPumpOptions = 0
	
Call oCustomTask20_Trans_Sub1( oCustomTask20	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask20 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask20_Trans_Sub1(ByVal oCustomTask20 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask20.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrpPurposeID" , 1)
			oColumn.Name = "GrpPurposeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpPurposeName" , 2)
			oColumn.Name = "GrpPurposeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 30
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPurposeID" , 1)
			oColumn.Name = "GrpPurposeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpPurposeName" , 2)
			oColumn.Name = "GrpPurposeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 30
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask20.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub21 for task Create Table GrpSubType Task (Create Table GrpSubType Task)
Public Sub Task_Sub21(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask21 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GrpSubType Task"
Set oCustomTask21 = oTask.CustomTask

	oCustomTask21.Name = "Create Table GrpSubType Task"
	oCustomTask21.Description = "Create Table GrpSubType Task"
	oCustomTask21.SQLStatement = "CREATE TABLE `GrpSubType` (" & vbCrLf
	oCustomTask21.SQLStatement = oCustomTask21.SQLStatement & "`GrpSubTypeID` Long NOT NULL, " & vbCrLf
	oCustomTask21.SQLStatement = oCustomTask21.SQLStatement & "`GrpSubTypeName` VarChar (20) NULL" & vbCrLf
	oCustomTask21.SQLStatement = oCustomTask21.SQLStatement & ")"
	oCustomTask21.ConnectionID = 2
	oCustomTask21.CommandTimeout = 0
	oCustomTask21.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask21 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub22 for task Copy Data from GrpSubType to GrpSubType Task (Copy Data from GrpSubType to GrpSubType Task)
Public Sub Task_Sub22(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask22 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GrpSubType to GrpSubType Task"
Set oCustomTask22 = oTask.CustomTask

	oCustomTask22.Name = "Copy Data from GrpSubType to GrpSubType Task"
	oCustomTask22.Description = "Copy Data from GrpSubType to GrpSubType Task"
	oCustomTask22.SourceConnectionID = 1
	oCustomTask22.SourceSQLStatement = "select [GrpSubTypeID],[GrpSubTypeName] from [MosOblGaz].[Gas].[GrpSubType]"
	oCustomTask22.DestinationConnectionID = 2
	oCustomTask22.DestinationObjectName = "GrpSubType"
	oCustomTask22.ProgressRowCount = 1000
	oCustomTask22.MaximumErrorCount = 0
	oCustomTask22.FetchBufferSize = 1
	oCustomTask22.UseFastLoad = True
	oCustomTask22.InsertCommitSize = 0
	oCustomTask22.ExceptionFileColumnDelimiter = "|"
	oCustomTask22.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask22.AllowIdentityInserts = False
	oCustomTask22.FirstRow = 0
	oCustomTask22.LastRow = 0
	oCustomTask22.FastLoadOptions = 2
	oCustomTask22.ExceptionFileOptions = 1
	oCustomTask22.DataPumpOptions = 0
	
Call oCustomTask22_Trans_Sub1( oCustomTask22	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask22 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask22_Trans_Sub1(ByVal oCustomTask22 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask22.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrpSubTypeID" , 1)
			oColumn.Name = "GrpSubTypeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpSubTypeName" , 2)
			oColumn.Name = "GrpSubTypeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpSubTypeID" , 1)
			oColumn.Name = "GrpSubTypeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpSubTypeName" , 2)
			oColumn.Name = "GrpSubTypeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask22.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub23 for task Create Table GrpType Task (Create Table GrpType Task)
Public Sub Task_Sub23(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask23 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GrpType Task"
Set oCustomTask23 = oTask.CustomTask

	oCustomTask23.Name = "Create Table GrpType Task"
	oCustomTask23.Description = "Create Table GrpType Task"
	oCustomTask23.SQLStatement = "CREATE TABLE `GrpType` (" & vbCrLf
	oCustomTask23.SQLStatement = oCustomTask23.SQLStatement & "`GrpTypeID` Long NOT NULL, " & vbCrLf
	oCustomTask23.SQLStatement = oCustomTask23.SQLStatement & "`GrpTypeName` VarChar (20) NULL" & vbCrLf
	oCustomTask23.SQLStatement = oCustomTask23.SQLStatement & ")"
	oCustomTask23.ConnectionID = 4
	oCustomTask23.CommandTimeout = 0
	oCustomTask23.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask23 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub24 for task Copy Data from GrpType to GrpType Task (Copy Data from GrpType to GrpType Task)
Public Sub Task_Sub24(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask24 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GrpType to GrpType Task"
Set oCustomTask24 = oTask.CustomTask

	oCustomTask24.Name = "Copy Data from GrpType to GrpType Task"
	oCustomTask24.Description = "Copy Data from GrpType to GrpType Task"
	oCustomTask24.SourceConnectionID = 3
	oCustomTask24.SourceSQLStatement = "select [GrpTypeID],[GrpTypeName] from [MosOblGaz].[Gas].[GrpType]"
	oCustomTask24.DestinationConnectionID = 4
	oCustomTask24.DestinationObjectName = "GrpType"
	oCustomTask24.ProgressRowCount = 1000
	oCustomTask24.MaximumErrorCount = 0
	oCustomTask24.FetchBufferSize = 1
	oCustomTask24.UseFastLoad = True
	oCustomTask24.InsertCommitSize = 0
	oCustomTask24.ExceptionFileColumnDelimiter = "|"
	oCustomTask24.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask24.AllowIdentityInserts = False
	oCustomTask24.FirstRow = 0
	oCustomTask24.LastRow = 0
	oCustomTask24.FastLoadOptions = 2
	oCustomTask24.ExceptionFileOptions = 1
	oCustomTask24.DataPumpOptions = 0
	
Call oCustomTask24_Trans_Sub1( oCustomTask24	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask24 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask24_Trans_Sub1(ByVal oCustomTask24 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask24.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrpTypeID" , 1)
			oColumn.Name = "GrpTypeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrpTypeName" , 2)
			oColumn.Name = "GrpTypeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpTypeID" , 1)
			oColumn.Name = "GrpTypeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrpTypeName" , 2)
			oColumn.Name = "GrpTypeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask24.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub25 for task Create Table GRS Task (Create Table GRS Task)
Public Sub Task_Sub25(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask25 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table GRS Task"
Set oCustomTask25 = oTask.CustomTask

	oCustomTask25.Name = "Create Table GRS Task"
	oCustomTask25.Description = "Create Table GRS Task"
	oCustomTask25.SQLStatement = "CREATE TABLE `GRS` (" & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsID` Long NOT NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsName` VarChar (255) NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsNumber` VarChar (15) NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsAddress` VarChar (255) NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`DepartmentID` Long NOT NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsInfoSource` VarChar (255) NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsWorkField` VarChar (255) NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`ServiceID` Long NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsPointLat` Double NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsPointLon` Double NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsPointAlt` Double NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`GrsNameAlter` VarChar (255) NULL, " & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & "`PipeLatID` Long NULL" & vbCrLf
	oCustomTask25.SQLStatement = oCustomTask25.SQLStatement & ")"
	oCustomTask25.ConnectionID = 2
	oCustomTask25.CommandTimeout = 0
	oCustomTask25.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask25 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub26 for task Copy Data from GRS to GRS Task (Copy Data from GRS to GRS Task)
Public Sub Task_Sub26(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask26 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from GRS to GRS Task"
Set oCustomTask26 = oTask.CustomTask

	oCustomTask26.Name = "Copy Data from GRS to GRS Task"
	oCustomTask26.Description = "Copy Data from GRS to GRS Task"
	oCustomTask26.SourceConnectionID = 1
	oCustomTask26.SourceSQLStatement = "select [GrsID],[GrsName],[GrsNumber],[GrsAddress],[GrsComment],[DepartmentID],[GrsInfoSource],[GrsWorkField],[ServiceID],[GrsPointLat],[GrsPointLon],[GrsPointAlt],[GrsNameAlter],[PipeLatID] from [MosOblGaz].[Gas].[GRS]"
	oCustomTask26.DestinationConnectionID = 2
	oCustomTask26.DestinationObjectName = "GRS"
	oCustomTask26.ProgressRowCount = 1000
	oCustomTask26.MaximumErrorCount = 0
	oCustomTask26.FetchBufferSize = 1
	oCustomTask26.UseFastLoad = True
	oCustomTask26.InsertCommitSize = 0
	oCustomTask26.ExceptionFileColumnDelimiter = "|"
	oCustomTask26.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask26.AllowIdentityInserts = False
	oCustomTask26.FirstRow = 0
	oCustomTask26.LastRow = 0
	oCustomTask26.FastLoadOptions = 2
	oCustomTask26.ExceptionFileOptions = 1
	oCustomTask26.DataPumpOptions = 0
	
Call oCustomTask26_Trans_Sub1( oCustomTask26	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask26 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask26_Trans_Sub1(ByVal oCustomTask26 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask26.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("GrsID" , 1)
			oColumn.Name = "GrsID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsName" , 2)
			oColumn.Name = "GrsName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsNumber" , 3)
			oColumn.Name = "GrsNumber"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 15
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsAddress" , 4)
			oColumn.Name = "GrsAddress"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsComment" , 5)
			oColumn.Name = "GrsComment"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 6)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 6
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsInfoSource" , 7)
			oColumn.Name = "GrsInfoSource"
			oColumn.Ordinal = 7
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsWorkField" , 8)
			oColumn.Name = "GrsWorkField"
			oColumn.Ordinal = 8
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceID" , 9)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 9
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsPointLat" , 10)
			oColumn.Name = "GrsPointLat"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsPointLon" , 11)
			oColumn.Name = "GrsPointLon"
			oColumn.Ordinal = 11
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsPointAlt" , 12)
			oColumn.Name = "GrsPointAlt"
			oColumn.Ordinal = 12
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GrsNameAlter" , 13)
			oColumn.Name = "GrsNameAlter"
			oColumn.Ordinal = 13
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatID" , 14)
			oColumn.Name = "PipeLatID"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsID" , 1)
			oColumn.Name = "GrsID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsName" , 2)
			oColumn.Name = "GrsName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsNumber" , 3)
			oColumn.Name = "GrsNumber"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 15
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsAddress" , 4)
			oColumn.Name = "GrsAddress"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsComment" , 5)
			oColumn.Name = "GrsComment"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 6)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 6
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsInfoSource" , 7)
			oColumn.Name = "GrsInfoSource"
			oColumn.Ordinal = 7
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsWorkField" , 8)
			oColumn.Name = "GrsWorkField"
			oColumn.Ordinal = 8
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceID" , 9)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 9
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsPointLat" , 10)
			oColumn.Name = "GrsPointLat"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsPointLon" , 11)
			oColumn.Name = "GrsPointLon"
			oColumn.Ordinal = 11
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsPointAlt" , 12)
			oColumn.Name = "GrsPointAlt"
			oColumn.Ordinal = 12
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GrsNameAlter" , 13)
			oColumn.Name = "GrsNameAlter"
			oColumn.Ordinal = 13
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatID" , 14)
			oColumn.Name = "PipeLatID"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask26.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub27 for task Create Table HeatingEquipment Task (Create Table HeatingEquipment Task)
Public Sub Task_Sub27(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask27 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table HeatingEquipment Task"
Set oCustomTask27 = oTask.CustomTask

	oCustomTask27.Name = "Create Table HeatingEquipment Task"
	oCustomTask27.Description = "Create Table HeatingEquipment Task"
	oCustomTask27.SQLStatement = "CREATE TABLE `HeatingEquipment` (" & vbCrLf
	oCustomTask27.SQLStatement = oCustomTask27.SQLStatement & "`HeatEquipID` Long NOT NULL, " & vbCrLf
	oCustomTask27.SQLStatement = oCustomTask27.SQLStatement & "`HeatEquipName` VarChar (20) NULL" & vbCrLf
	oCustomTask27.SQLStatement = oCustomTask27.SQLStatement & ")"
	oCustomTask27.ConnectionID = 4
	oCustomTask27.CommandTimeout = 0
	oCustomTask27.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask27 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub28 for task Copy Data from HeatingEquipment to HeatingEquipment Task (Copy Data from HeatingEquipment to HeatingEquipment Task)
Public Sub Task_Sub28(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask28 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from HeatingEquipment to HeatingEquipment Task"
Set oCustomTask28 = oTask.CustomTask

	oCustomTask28.Name = "Copy Data from HeatingEquipment to HeatingEquipment Task"
	oCustomTask28.Description = "Copy Data from HeatingEquipment to HeatingEquipment Task"
	oCustomTask28.SourceConnectionID = 3
	oCustomTask28.SourceSQLStatement = "select [HeatEquipID],[HeatEquipName] from [MosOblGaz].[Gas].[HeatingEquipment]"
	oCustomTask28.DestinationConnectionID = 4
	oCustomTask28.DestinationObjectName = "HeatingEquipment"
	oCustomTask28.ProgressRowCount = 1000
	oCustomTask28.MaximumErrorCount = 0
	oCustomTask28.FetchBufferSize = 1
	oCustomTask28.UseFastLoad = True
	oCustomTask28.InsertCommitSize = 0
	oCustomTask28.ExceptionFileColumnDelimiter = "|"
	oCustomTask28.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask28.AllowIdentityInserts = False
	oCustomTask28.FirstRow = 0
	oCustomTask28.LastRow = 0
	oCustomTask28.FastLoadOptions = 2
	oCustomTask28.ExceptionFileOptions = 1
	oCustomTask28.DataPumpOptions = 0
	
Call oCustomTask28_Trans_Sub1( oCustomTask28	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask28 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask28_Trans_Sub1(ByVal oCustomTask28 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask28.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("HeatEquipID" , 1)
			oColumn.Name = "HeatEquipID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("HeatEquipName" , 2)
			oColumn.Name = "HeatEquipName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 129
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("HeatEquipID" , 1)
			oColumn.Name = "HeatEquipID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("HeatEquipName" , 2)
			oColumn.Name = "HeatEquipName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask28.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub29 for task Create Table Pipe Task (Create Table Pipe Task)
Public Sub Task_Sub29(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask29 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table Pipe Task"
Set oCustomTask29 = oTask.CustomTask

	oCustomTask29.Name = "Create Table Pipe Task"
	oCustomTask29.Description = "Create Table Pipe Task"
	oCustomTask29.SQLStatement = "CREATE TABLE `Pipe` (" & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PipeID` Long NOT NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`DepartmentID` Long NOT NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PressureTypeID` Long NOT NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PipeDiam` Long NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`GasObjPropertyID` Long NOT NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PipeInfoSource` VarChar (255) NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PipeComment` VarChar (255) NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PipePrivateID` Long NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`GasificProgNum` Long NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`ExplPutYear` Long NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`GasObjStatusID` Long NOT NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PipeStuffID` Long NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`PipeWorkField` VarChar (255) NULL, " & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & "`ServiceID` Long NULL" & vbCrLf
	oCustomTask29.SQLStatement = oCustomTask29.SQLStatement & ")"
	oCustomTask29.ConnectionID = 2
	oCustomTask29.CommandTimeout = 0
	oCustomTask29.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask29 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub30 for task Copy Data from Pipe to Pipe Task (Copy Data from Pipe to Pipe Task)
Public Sub Task_Sub30(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask30 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from Pipe to Pipe Task"
Set oCustomTask30 = oTask.CustomTask

	oCustomTask30.Name = "Copy Data from Pipe to Pipe Task"
	oCustomTask30.Description = "Copy Data from Pipe to Pipe Task"
	oCustomTask30.SourceConnectionID = 1
	oCustomTask30.SourceSQLStatement = "select [PipeID],[DepartmentID],[PressureTypeID],[PipeDiam],[GasObjPropertyID],[PipeInfoSource],[PipeComment],[PipePrivateID],[GasificProgNum],[ExplPutYear],[GasObjStatusID],[PipeStuffID],[PipeWorkField],[ServiceID] from [MosOblGaz].[Gas].[Pipe]"
	oCustomTask30.DestinationConnectionID = 2
	oCustomTask30.DestinationObjectName = "Pipe"
	oCustomTask30.ProgressRowCount = 1000
	oCustomTask30.MaximumErrorCount = 0
	oCustomTask30.FetchBufferSize = 1
	oCustomTask30.UseFastLoad = True
	oCustomTask30.InsertCommitSize = 0
	oCustomTask30.ExceptionFileColumnDelimiter = "|"
	oCustomTask30.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask30.AllowIdentityInserts = False
	oCustomTask30.FirstRow = 0
	oCustomTask30.LastRow = 0
	oCustomTask30.FastLoadOptions = 2
	oCustomTask30.ExceptionFileOptions = 1
	oCustomTask30.DataPumpOptions = 0
	
Call oCustomTask30_Trans_Sub1( oCustomTask30	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask30 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask30_Trans_Sub1(ByVal oCustomTask30 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask30.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("PipeID" , 1)
			oColumn.Name = "PipeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 2)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PressureTypeID" , 3)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeDiam" , 4)
			oColumn.Name = "PipeDiam"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasObjPropertyID" , 5)
			oColumn.Name = "GasObjPropertyID"
			oColumn.Ordinal = 5
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeInfoSource" , 6)
			oColumn.Name = "PipeInfoSource"
			oColumn.Ordinal = 6
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeComment" , 7)
			oColumn.Name = "PipeComment"
			oColumn.Ordinal = 7
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipePrivateID" , 8)
			oColumn.Name = "PipePrivateID"
			oColumn.Ordinal = 8
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasificProgNum" , 9)
			oColumn.Name = "GasificProgNum"
			oColumn.Ordinal = 9
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ExplPutYear" , 10)
			oColumn.Name = "ExplPutYear"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("GasObjStatusID" , 11)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 11
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeStuffID" , 12)
			oColumn.Name = "PipeStuffID"
			oColumn.Ordinal = 12
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeWorkField" , 13)
			oColumn.Name = "PipeWorkField"
			oColumn.Ordinal = 13
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceID" , 14)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeID" , 1)
			oColumn.Name = "PipeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 16
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 2)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 2
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PressureTypeID" , 3)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeDiam" , 4)
			oColumn.Name = "PipeDiam"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjPropertyID" , 5)
			oColumn.Name = "GasObjPropertyID"
			oColumn.Ordinal = 5
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeInfoSource" , 6)
			oColumn.Name = "PipeInfoSource"
			oColumn.Ordinal = 6
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeComment" , 7)
			oColumn.Name = "PipeComment"
			oColumn.Ordinal = 7
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipePrivateID" , 8)
			oColumn.Name = "PipePrivateID"
			oColumn.Ordinal = 8
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasificProgNum" , 9)
			oColumn.Name = "GasificProgNum"
			oColumn.Ordinal = 9
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ExplPutYear" , 10)
			oColumn.Name = "ExplPutYear"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("GasObjStatusID" , 11)
			oColumn.Name = "GasObjStatusID"
			oColumn.Ordinal = 11
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeStuffID" , 12)
			oColumn.Name = "PipeStuffID"
			oColumn.Ordinal = 12
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeWorkField" , 13)
			oColumn.Name = "PipeWorkField"
			oColumn.Ordinal = 13
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceID" , 14)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask30.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub31 for task Create Table PipeArterial Task (Create Table PipeArterial Task)
Public Sub Task_Sub31(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask31 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table PipeArterial Task"
Set oCustomTask31 = oTask.CustomTask

	oCustomTask31.Name = "Create Table PipeArterial Task"
	oCustomTask31.Description = "Create Table PipeArterial Task"
	oCustomTask31.SQLStatement = "CREATE TABLE `PipeArterial` (" & vbCrLf
	oCustomTask31.SQLStatement = oCustomTask31.SQLStatement & "`PipeArtID` Long NOT NULL, " & vbCrLf
	oCustomTask31.SQLStatement = oCustomTask31.SQLStatement & "`PipeArtNum` Long NULL, " & vbCrLf
	oCustomTask31.SQLStatement = oCustomTask31.SQLStatement & "`PipeArtName` VarChar (50) NULL, " & vbCrLf
	oCustomTask31.SQLStatement = oCustomTask31.SQLStatement & "`PipeArtDiam` Long NULL, " & vbCrLf
	oCustomTask31.SQLStatement = oCustomTask31.SQLStatement & "`PipeArtPressure` Long NULL, " & vbCrLf
	oCustomTask31.SQLStatement = oCustomTask31.SQLStatement & "`PipeArtComment` VarChar (255) NULL" & vbCrLf
	oCustomTask31.SQLStatement = oCustomTask31.SQLStatement & ")"
	oCustomTask31.ConnectionID = 4
	oCustomTask31.CommandTimeout = 0
	oCustomTask31.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask31 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub32 for task Copy Data from PipeArterial to PipeArterial Task (Copy Data from PipeArterial to PipeArterial Task)
Public Sub Task_Sub32(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask32 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from PipeArterial to PipeArterial Task"
Set oCustomTask32 = oTask.CustomTask

	oCustomTask32.Name = "Copy Data from PipeArterial to PipeArterial Task"
	oCustomTask32.Description = "Copy Data from PipeArterial to PipeArterial Task"
	oCustomTask32.SourceConnectionID = 3
	oCustomTask32.SourceSQLStatement = "select [PipeArtID],[PipeArtNum],[PipeArtName],[PipeArtDiam],[PipeArtPressure],[PipeArtComment] from [MosOblGaz].[Gas].[PipeArterial]"
	oCustomTask32.DestinationConnectionID = 4
	oCustomTask32.DestinationObjectName = "PipeArterial"
	oCustomTask32.ProgressRowCount = 1000
	oCustomTask32.MaximumErrorCount = 0
	oCustomTask32.FetchBufferSize = 1
	oCustomTask32.UseFastLoad = True
	oCustomTask32.InsertCommitSize = 0
	oCustomTask32.ExceptionFileColumnDelimiter = "|"
	oCustomTask32.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask32.AllowIdentityInserts = False
	oCustomTask32.FirstRow = 0
	oCustomTask32.LastRow = 0
	oCustomTask32.FastLoadOptions = 2
	oCustomTask32.ExceptionFileOptions = 1
	oCustomTask32.DataPumpOptions = 0
	
Call oCustomTask32_Trans_Sub1( oCustomTask32	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask32 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask32_Trans_Sub1(ByVal oCustomTask32 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask32.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("PipeArtID" , 1)
			oColumn.Name = "PipeArtID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeArtNum" , 2)
			oColumn.Name = "PipeArtNum"
			oColumn.Ordinal = 2
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeArtName" , 3)
			oColumn.Name = "PipeArtName"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeArtDiam" , 4)
			oColumn.Name = "PipeArtDiam"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeArtPressure" , 5)
			oColumn.Name = "PipeArtPressure"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeArtComment" , 6)
			oColumn.Name = "PipeArtComment"
			oColumn.Ordinal = 6
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeArtID" , 1)
			oColumn.Name = "PipeArtID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeArtNum" , 2)
			oColumn.Name = "PipeArtNum"
			oColumn.Ordinal = 2
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeArtName" , 3)
			oColumn.Name = "PipeArtName"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeArtDiam" , 4)
			oColumn.Name = "PipeArtDiam"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeArtPressure" , 5)
			oColumn.Name = "PipeArtPressure"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeArtComment" , 6)
			oColumn.Name = "PipeArtComment"
			oColumn.Ordinal = 6
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask32.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub33 for task Create Table PipeLateral Task (Create Table PipeLateral Task)
Public Sub Task_Sub33(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask33 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table PipeLateral Task"
Set oCustomTask33 = oTask.CustomTask

	oCustomTask33.Name = "Create Table PipeLateral Task"
	oCustomTask33.Description = "Create Table PipeLateral Task"
	oCustomTask33.SQLStatement = "CREATE TABLE `PipeLateral` (" & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatID` Long NOT NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatCode` VarChar (50) NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeArtID` Long NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatBalance` VarChar (50) NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatExpl` VarChar (50) NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatConnectPoint` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatLen` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatDiam` Long NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatPressProjInit` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatPressProjFinal` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatPressFactInit` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatPressFactFinal` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatProductProj` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatProductFact` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatChargeCoefYr` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatChargeCoefWin` Double NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatExplBeginYear` Long NULL, " & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & "`PipeLatComment` VarChar (255) NULL" & vbCrLf
	oCustomTask33.SQLStatement = oCustomTask33.SQLStatement & ")"
	oCustomTask33.ConnectionID = 2
	oCustomTask33.CommandTimeout = 0
	oCustomTask33.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask33 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub34 for task Copy Data from PipeLateral to PipeLateral Task (Copy Data from PipeLateral to PipeLateral Task)
Public Sub Task_Sub34(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask34 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from PipeLateral to PipeLateral Task"
Set oCustomTask34 = oTask.CustomTask

	oCustomTask34.Name = "Copy Data from PipeLateral to PipeLateral Task"
	oCustomTask34.Description = "Copy Data from PipeLateral to PipeLateral Task"
	oCustomTask34.SourceConnectionID = 1
	oCustomTask34.SourceSQLStatement = "select [PipeLatID],[PipeLatCode],[PipeArtID],[PipeLatBalance],[PipeLatExpl],[PipeLatConnectPoint],[PipeLatLen],[PipeLatDiam],[PipeLatPressProjInit],[PipeLatPressProjFinal],[PipeLatPressFactInit],[PipeLatPressFactFinal],[PipeLatProductProj],[PipeLatProduct"
	oCustomTask34.SourceSQLStatement = oCustomTask34.SourceSQLStatement & "Fact],[PipeLatChargeCoefYr],[PipeLatChargeCoefWin],[PipeLatExplBeginYear],[PipeLatComment] from [MosOblGaz].[Gas].[PipeLateral]"
	oCustomTask34.DestinationConnectionID = 2
	oCustomTask34.DestinationObjectName = "PipeLateral"
	oCustomTask34.ProgressRowCount = 1000
	oCustomTask34.MaximumErrorCount = 0
	oCustomTask34.FetchBufferSize = 1
	oCustomTask34.UseFastLoad = True
	oCustomTask34.InsertCommitSize = 0
	oCustomTask34.ExceptionFileColumnDelimiter = "|"
	oCustomTask34.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask34.AllowIdentityInserts = False
	oCustomTask34.FirstRow = 0
	oCustomTask34.LastRow = 0
	oCustomTask34.FastLoadOptions = 2
	oCustomTask34.ExceptionFileOptions = 1
	oCustomTask34.DataPumpOptions = 0
	
Call oCustomTask34_Trans_Sub1( oCustomTask34	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask34 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask34_Trans_Sub1(ByVal oCustomTask34 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask34.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("PipeLatID" , 1)
			oColumn.Name = "PipeLatID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatCode" , 2)
			oColumn.Name = "PipeLatCode"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeArtID" , 3)
			oColumn.Name = "PipeArtID"
			oColumn.Ordinal = 3
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatBalance" , 4)
			oColumn.Name = "PipeLatBalance"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatExpl" , 5)
			oColumn.Name = "PipeLatExpl"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatConnectPoint" , 6)
			oColumn.Name = "PipeLatConnectPoint"
			oColumn.Ordinal = 6
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatLen" , 7)
			oColumn.Name = "PipeLatLen"
			oColumn.Ordinal = 7
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatDiam" , 8)
			oColumn.Name = "PipeLatDiam"
			oColumn.Ordinal = 8
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatPressProjInit" , 9)
			oColumn.Name = "PipeLatPressProjInit"
			oColumn.Ordinal = 9
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatPressProjFinal" , 10)
			oColumn.Name = "PipeLatPressProjFinal"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatPressFactInit" , 11)
			oColumn.Name = "PipeLatPressFactInit"
			oColumn.Ordinal = 11
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatPressFactFinal" , 12)
			oColumn.Name = "PipeLatPressFactFinal"
			oColumn.Ordinal = 12
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatProductProj" , 13)
			oColumn.Name = "PipeLatProductProj"
			oColumn.Ordinal = 13
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatProductFact" , 14)
			oColumn.Name = "PipeLatProductFact"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatChargeCoefYr" , 15)
			oColumn.Name = "PipeLatChargeCoefYr"
			oColumn.Ordinal = 15
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatChargeCoefWin" , 16)
			oColumn.Name = "PipeLatChargeCoefWin"
			oColumn.Ordinal = 16
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatExplBeginYear" , 17)
			oColumn.Name = "PipeLatExplBeginYear"
			oColumn.Ordinal = 17
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeLatComment" , 18)
			oColumn.Name = "PipeLatComment"
			oColumn.Ordinal = 18
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatID" , 1)
			oColumn.Name = "PipeLatID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatCode" , 2)
			oColumn.Name = "PipeLatCode"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeArtID" , 3)
			oColumn.Name = "PipeArtID"
			oColumn.Ordinal = 3
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatBalance" , 4)
			oColumn.Name = "PipeLatBalance"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatExpl" , 5)
			oColumn.Name = "PipeLatExpl"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatConnectPoint" , 6)
			oColumn.Name = "PipeLatConnectPoint"
			oColumn.Ordinal = 6
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatLen" , 7)
			oColumn.Name = "PipeLatLen"
			oColumn.Ordinal = 7
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatDiam" , 8)
			oColumn.Name = "PipeLatDiam"
			oColumn.Ordinal = 8
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatPressProjInit" , 9)
			oColumn.Name = "PipeLatPressProjInit"
			oColumn.Ordinal = 9
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatPressProjFinal" , 10)
			oColumn.Name = "PipeLatPressProjFinal"
			oColumn.Ordinal = 10
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatPressFactInit" , 11)
			oColumn.Name = "PipeLatPressFactInit"
			oColumn.Ordinal = 11
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatPressFactFinal" , 12)
			oColumn.Name = "PipeLatPressFactFinal"
			oColumn.Ordinal = 12
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatProductProj" , 13)
			oColumn.Name = "PipeLatProductProj"
			oColumn.Ordinal = 13
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatProductFact" , 14)
			oColumn.Name = "PipeLatProductFact"
			oColumn.Ordinal = 14
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatChargeCoefYr" , 15)
			oColumn.Name = "PipeLatChargeCoefYr"
			oColumn.Ordinal = 15
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatChargeCoefWin" , 16)
			oColumn.Name = "PipeLatChargeCoefWin"
			oColumn.Ordinal = 16
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 5
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatExplBeginYear" , 17)
			oColumn.Name = "PipeLatExplBeginYear"
			oColumn.Ordinal = 17
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeLatComment" , 18)
			oColumn.Name = "PipeLatComment"
			oColumn.Ordinal = 18
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask34.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub35 for task Create Table PipeStuff Task (Create Table PipeStuff Task)
Public Sub Task_Sub35(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask35 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table PipeStuff Task"
Set oCustomTask35 = oTask.CustomTask

	oCustomTask35.Name = "Create Table PipeStuff Task"
	oCustomTask35.Description = "Create Table PipeStuff Task"
	oCustomTask35.SQLStatement = "CREATE TABLE `PipeStuff` (" & vbCrLf
	oCustomTask35.SQLStatement = oCustomTask35.SQLStatement & "`PipeStuffID` Long NOT NULL, " & vbCrLf
	oCustomTask35.SQLStatement = oCustomTask35.SQLStatement & "`PipeStuffName` VarChar (20) NULL" & vbCrLf
	oCustomTask35.SQLStatement = oCustomTask35.SQLStatement & ")"
	oCustomTask35.ConnectionID = 4
	oCustomTask35.CommandTimeout = 0
	oCustomTask35.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask35 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub36 for task Copy Data from PipeStuff to PipeStuff Task (Copy Data from PipeStuff to PipeStuff Task)
Public Sub Task_Sub36(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask36 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from PipeStuff to PipeStuff Task"
Set oCustomTask36 = oTask.CustomTask

	oCustomTask36.Name = "Copy Data from PipeStuff to PipeStuff Task"
	oCustomTask36.Description = "Copy Data from PipeStuff to PipeStuff Task"
	oCustomTask36.SourceConnectionID = 3
	oCustomTask36.SourceSQLStatement = "select [PipeStuffID],[PipeStuffName] from [MosOblGaz].[Gas].[PipeStuff]"
	oCustomTask36.DestinationConnectionID = 4
	oCustomTask36.DestinationObjectName = "PipeStuff"
	oCustomTask36.ProgressRowCount = 1000
	oCustomTask36.MaximumErrorCount = 0
	oCustomTask36.FetchBufferSize = 1
	oCustomTask36.UseFastLoad = True
	oCustomTask36.InsertCommitSize = 0
	oCustomTask36.ExceptionFileColumnDelimiter = "|"
	oCustomTask36.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask36.AllowIdentityInserts = False
	oCustomTask36.FirstRow = 0
	oCustomTask36.LastRow = 0
	oCustomTask36.FastLoadOptions = 2
	oCustomTask36.ExceptionFileOptions = 1
	oCustomTask36.DataPumpOptions = 0
	
Call oCustomTask36_Trans_Sub1( oCustomTask36	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask36 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask36_Trans_Sub1(ByVal oCustomTask36 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask36.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("PipeStuffID" , 1)
			oColumn.Name = "PipeStuffID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PipeStuffName" , 2)
			oColumn.Name = "PipeStuffName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeStuffID" , 1)
			oColumn.Name = "PipeStuffID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PipeStuffName" , 2)
			oColumn.Name = "PipeStuffName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask36.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub37 for task Create Table PressureType Task (Create Table PressureType Task)
Public Sub Task_Sub37(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask37 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table PressureType Task"
Set oCustomTask37 = oTask.CustomTask

	oCustomTask37.Name = "Create Table PressureType Task"
	oCustomTask37.Description = "Create Table PressureType Task"
	oCustomTask37.SQLStatement = "CREATE TABLE `PressureType` (" & vbCrLf
	oCustomTask37.SQLStatement = oCustomTask37.SQLStatement & "`PressureTypeID` Long NOT NULL, " & vbCrLf
	oCustomTask37.SQLStatement = oCustomTask37.SQLStatement & "`PressureTypeName` VarChar (20) NULL" & vbCrLf
	oCustomTask37.SQLStatement = oCustomTask37.SQLStatement & ")"
	oCustomTask37.ConnectionID = 2
	oCustomTask37.CommandTimeout = 0
	oCustomTask37.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask37 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub38 for task Copy Data from PressureType to PressureType Task (Copy Data from PressureType to PressureType Task)
Public Sub Task_Sub38(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask38 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from PressureType to PressureType Task"
Set oCustomTask38 = oTask.CustomTask

	oCustomTask38.Name = "Copy Data from PressureType to PressureType Task"
	oCustomTask38.Description = "Copy Data from PressureType to PressureType Task"
	oCustomTask38.SourceConnectionID = 1
	oCustomTask38.SourceSQLStatement = "select [PressureTypeID],[PressureTypeName] from [MosOblGaz].[Gas].[PressureType]"
	oCustomTask38.DestinationConnectionID = 2
	oCustomTask38.DestinationObjectName = "PressureType"
	oCustomTask38.ProgressRowCount = 1000
	oCustomTask38.MaximumErrorCount = 0
	oCustomTask38.FetchBufferSize = 1
	oCustomTask38.UseFastLoad = True
	oCustomTask38.InsertCommitSize = 0
	oCustomTask38.ExceptionFileColumnDelimiter = "|"
	oCustomTask38.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask38.AllowIdentityInserts = False
	oCustomTask38.FirstRow = 0
	oCustomTask38.LastRow = 0
	oCustomTask38.FastLoadOptions = 2
	oCustomTask38.ExceptionFileOptions = 1
	oCustomTask38.DataPumpOptions = 0
	
Call oCustomTask38_Trans_Sub1( oCustomTask38	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask38 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask38_Trans_Sub1(ByVal oCustomTask38 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask38.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("PressureTypeID" , 1)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("PressureTypeName" , 2)
			oColumn.Name = "PressureTypeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PressureTypeID" , 1)
			oColumn.Name = "PressureTypeID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("PressureTypeName" , 2)
			oColumn.Name = "PressureTypeName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask38.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub39 for task Create Table ADS Task (Create Table ADS Task)
Public Sub Task_Sub39(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask39 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table ADS Task"
Set oCustomTask39 = oTask.CustomTask

	oCustomTask39.Name = "Create Table ADS Task"
	oCustomTask39.Description = "Create Table ADS Task"
	oCustomTask39.SQLStatement = "CREATE TABLE `ADS` (" & vbCrLf
	oCustomTask39.SQLStatement = oCustomTask39.SQLStatement & "`AdsID` Long NOT NULL, " & vbCrLf
	oCustomTask39.SQLStatement = oCustomTask39.SQLStatement & "`AdsName` VarChar (100) NOT NULL, " & vbCrLf
	oCustomTask39.SQLStatement = oCustomTask39.SQLStatement & "`DepartmentID` Long NOT NULL, " & vbCrLf
	oCustomTask39.SQLStatement = oCustomTask39.SQLStatement & "`AdsAddress` VarChar (100) NULL, " & vbCrLf
	oCustomTask39.SQLStatement = oCustomTask39.SQLStatement & "`AdsComment` VarChar (255) NULL" & vbCrLf
	oCustomTask39.SQLStatement = oCustomTask39.SQLStatement & ")"
	oCustomTask39.ConnectionID = 4
	oCustomTask39.CommandTimeout = 0
	oCustomTask39.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask39 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub40 for task Copy Data from ADS to ADS Task (Copy Data from ADS to ADS Task)
Public Sub Task_Sub40(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask40 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from ADS to ADS Task"
Set oCustomTask40 = oTask.CustomTask

	oCustomTask40.Name = "Copy Data from ADS to ADS Task"
	oCustomTask40.Description = "Copy Data from ADS to ADS Task"
	oCustomTask40.SourceConnectionID = 3
	oCustomTask40.SourceSQLStatement = "select [AdsID],[AdsName],[DepartmentID],[AdsAddress],[AdsComment] from [MosOblGaz].[Org].[ADS]"
	oCustomTask40.DestinationConnectionID = 4
	oCustomTask40.DestinationObjectName = "ADS"
	oCustomTask40.ProgressRowCount = 1000
	oCustomTask40.MaximumErrorCount = 0
	oCustomTask40.FetchBufferSize = 1
	oCustomTask40.UseFastLoad = True
	oCustomTask40.InsertCommitSize = 0
	oCustomTask40.ExceptionFileColumnDelimiter = "|"
	oCustomTask40.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask40.AllowIdentityInserts = False
	oCustomTask40.FirstRow = 0
	oCustomTask40.LastRow = 0
	oCustomTask40.FastLoadOptions = 2
	oCustomTask40.ExceptionFileOptions = 1
	oCustomTask40.DataPumpOptions = 0
	
Call oCustomTask40_Trans_Sub1( oCustomTask40	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask40 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask40_Trans_Sub1(ByVal oCustomTask40 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask40.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("AdsID" , 1)
			oColumn.Name = "AdsID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("AdsName" , 2)
			oColumn.Name = "AdsName"
			oColumn.Ordinal = 2
			oColumn.Flags = 8
			oColumn.Size = 100
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 3)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("AdsAddress" , 4)
			oColumn.Name = "AdsAddress"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 100
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("AdsComment" , 5)
			oColumn.Name = "AdsComment"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("AdsID" , 1)
			oColumn.Name = "AdsID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("AdsName" , 2)
			oColumn.Name = "AdsName"
			oColumn.Ordinal = 2
			oColumn.Flags = 8
			oColumn.Size = 100
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 3)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 3
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("AdsAddress" , 4)
			oColumn.Name = "AdsAddress"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 100
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("AdsComment" , 5)
			oColumn.Name = "AdsComment"
			oColumn.Ordinal = 5
			oColumn.Flags = 104
			oColumn.Size = 255
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask40.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub41 for task Create Table Department Task (Create Table Department Task)
Public Sub Task_Sub41(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask41 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table Department Task"
Set oCustomTask41 = oTask.CustomTask

	oCustomTask41.Name = "Create Table Department Task"
	oCustomTask41.Description = "Create Table Department Task"
	oCustomTask41.SQLStatement = "CREATE TABLE `Department` (" & vbCrLf
	oCustomTask41.SQLStatement = oCustomTask41.SQLStatement & "`DepartmentID` Long NOT NULL, " & vbCrLf
	oCustomTask41.SQLStatement = oCustomTask41.SQLStatement & "`DepartmentName` VarChar (150) NULL, " & vbCrLf
	oCustomTask41.SQLStatement = oCustomTask41.SQLStatement & "`DepartmentAddress` VarChar (150) NULL, " & vbCrLf
	oCustomTask41.SQLStatement = oCustomTask41.SQLStatement & "`DepartmentCode` Long NULL" & vbCrLf
	oCustomTask41.SQLStatement = oCustomTask41.SQLStatement & ")"
	oCustomTask41.ConnectionID = 2
	oCustomTask41.CommandTimeout = 0
	oCustomTask41.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask41 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub42 for task Copy Data from Department to Department Task (Copy Data from Department to Department Task)
Public Sub Task_Sub42(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask42 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from Department to Department Task"
Set oCustomTask42 = oTask.CustomTask

	oCustomTask42.Name = "Copy Data from Department to Department Task"
	oCustomTask42.Description = "Copy Data from Department to Department Task"
	oCustomTask42.SourceConnectionID = 1
	oCustomTask42.SourceSQLStatement = "select [DepartmentID],[DepartmentName],[DepartmentAddress],[DepartmentCode] from [MosOblGaz].[Org].[Department]"
	oCustomTask42.DestinationConnectionID = 2
	oCustomTask42.DestinationObjectName = "Department"
	oCustomTask42.ProgressRowCount = 1000
	oCustomTask42.MaximumErrorCount = 0
	oCustomTask42.FetchBufferSize = 1
	oCustomTask42.UseFastLoad = True
	oCustomTask42.InsertCommitSize = 0
	oCustomTask42.ExceptionFileColumnDelimiter = "|"
	oCustomTask42.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask42.AllowIdentityInserts = False
	oCustomTask42.FirstRow = 0
	oCustomTask42.LastRow = 0
	oCustomTask42.FastLoadOptions = 2
	oCustomTask42.ExceptionFileOptions = 1
	oCustomTask42.DataPumpOptions = 0
	
Call oCustomTask42_Trans_Sub1( oCustomTask42	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask42 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask42_Trans_Sub1(ByVal oCustomTask42 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask42.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 1)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentName" , 2)
			oColumn.Name = "DepartmentName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 150
			oColumn.DataType = 129
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentAddress" , 3)
			oColumn.Name = "DepartmentAddress"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 150
			oColumn.DataType = 129
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentCode" , 4)
			oColumn.Name = "DepartmentCode"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 1)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentName" , 2)
			oColumn.Name = "DepartmentName"
			oColumn.Ordinal = 2
			oColumn.Flags = 104
			oColumn.Size = 150
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentAddress" , 3)
			oColumn.Name = "DepartmentAddress"
			oColumn.Ordinal = 3
			oColumn.Flags = 104
			oColumn.Size = 150
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentCode" , 4)
			oColumn.Name = "DepartmentCode"
			oColumn.Ordinal = 4
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask42.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

'------------- define Task_Sub43 for task Create Table Service Task (Create Table Service Task)
Public Sub Task_Sub43(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask43 As DTS.ExecuteSQLTask2
Set oTask = goPackage.Tasks.New("DTSExecuteSQLTask")
oTask.Name = "Create Table Service Task"
Set oCustomTask43 = oTask.CustomTask

	oCustomTask43.Name = "Create Table Service Task"
	oCustomTask43.Description = "Create Table Service Task"
	oCustomTask43.SQLStatement = "CREATE TABLE `Service` (" & vbCrLf
	oCustomTask43.SQLStatement = oCustomTask43.SQLStatement & "`ServiceID` Long NOT NULL, " & vbCrLf
	oCustomTask43.SQLStatement = oCustomTask43.SQLStatement & "`ServiceName` VarChar (50) NULL, " & vbCrLf
	oCustomTask43.SQLStatement = oCustomTask43.SQLStatement & "`DepartmentID` Long NULL, " & vbCrLf
	oCustomTask43.SQLStatement = oCustomTask43.SQLStatement & "`ServiceAddress` VarChar (150) NULL, " & vbCrLf
	oCustomTask43.SQLStatement = oCustomTask43.SQLStatement & "`ServiceCode` Long NULL, " & vbCrLf
	oCustomTask43.SQLStatement = oCustomTask43.SQLStatement & "`ServiceNameShort` VarChar (20) NULL" & vbCrLf
	oCustomTask43.SQLStatement = oCustomTask43.SQLStatement & ")"
	oCustomTask43.ConnectionID = 4
	oCustomTask43.CommandTimeout = 0
	oCustomTask43.OutputAsRecordset = False
	
goPackage.Tasks.Add oTask
Set oCustomTask43 = Nothing
Set oTask = Nothing

End Sub

'------------- define Task_Sub44 for task Copy Data from Service to Service Task (Copy Data from Service to Service Task)
Public Sub Task_Sub44(ByVal goPackage As Object)

Dim oTask As DTS.Task
Dim oLookup As DTS.Lookup

Dim oCustomTask44 As DTS.DataPumpTask2
Set oTask = goPackage.Tasks.New("DTSDataPumpTask")
oTask.Name = "Copy Data from Service to Service Task"
Set oCustomTask44 = oTask.CustomTask

	oCustomTask44.Name = "Copy Data from Service to Service Task"
	oCustomTask44.Description = "Copy Data from Service to Service Task"
	oCustomTask44.SourceConnectionID = 3
	oCustomTask44.SourceSQLStatement = "select [ServiceID],[ServiceName],[DepartmentID],[ServiceAddress],[ServiceCode],[ServiceNameShort] from [MosOblGaz].[Org].[Service]"
	oCustomTask44.DestinationConnectionID = 4
	oCustomTask44.DestinationObjectName = "Service"
	oCustomTask44.ProgressRowCount = 1000
	oCustomTask44.MaximumErrorCount = 0
	oCustomTask44.FetchBufferSize = 1
	oCustomTask44.UseFastLoad = True
	oCustomTask44.InsertCommitSize = 0
	oCustomTask44.ExceptionFileColumnDelimiter = "|"
	oCustomTask44.ExceptionFileRowDelimiter = vbCrLf
	oCustomTask44.AllowIdentityInserts = False
	oCustomTask44.FirstRow = 0
	oCustomTask44.LastRow = 0
	oCustomTask44.FastLoadOptions = 2
	oCustomTask44.ExceptionFileOptions = 1
	oCustomTask44.DataPumpOptions = 0
	
Call oCustomTask44_Trans_Sub1( oCustomTask44	)
		
		
goPackage.Tasks.Add oTask
Set oCustomTask44 = Nothing
Set oTask = Nothing

End Sub

Public Sub oCustomTask44_Trans_Sub1(ByVal oCustomTask44 As Object)

	Dim oTransformation As DTS.Transformation2
	Dim oTransProps as DTS.Properties
	Dim oColumn As DTS.Column
	Set oTransformation = oCustomTask44.Transformations.New("DTS.DataPumpTransformCopy")
		oTransformation.Name = "DirectCopyXform"
		oTransformation.TransformFlags = 63
		oTransformation.ForceSourceBlobsBuffered = 0
		oTransformation.ForceBlobsInMemory = False
		oTransformation.InMemoryBlobSize = 1048576
		oTransformation.TransformPhases = 4
		
		Set oColumn = oTransformation.SourceColumns.New("ServiceID" , 1)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceName" , 2)
			oColumn.Name = "ServiceName"
			oColumn.Ordinal = 2
			oColumn.Flags = 120
			oColumn.Size = 50
			oColumn.DataType = 129
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("DepartmentID" , 3)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 3
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceAddress" , 4)
			oColumn.Name = "ServiceAddress"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 150
			oColumn.DataType = 129
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceCode" , 5)
			oColumn.Name = "ServiceCode"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.SourceColumns.New("ServiceNameShort" , 6)
			oColumn.Name = "ServiceNameShort"
			oColumn.Ordinal = 6
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 129
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.SourceColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceID" , 1)
			oColumn.Name = "ServiceID"
			oColumn.Ordinal = 1
			oColumn.Flags = 24
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = False
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceName" , 2)
			oColumn.Name = "ServiceName"
			oColumn.Ordinal = 2
			oColumn.Flags = 120
			oColumn.Size = 50
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("DepartmentID" , 3)
			oColumn.Name = "DepartmentID"
			oColumn.Ordinal = 3
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceAddress" , 4)
			oColumn.Name = "ServiceAddress"
			oColumn.Ordinal = 4
			oColumn.Flags = 104
			oColumn.Size = 150
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceCode" , 5)
			oColumn.Name = "ServiceCode"
			oColumn.Ordinal = 5
			oColumn.Flags = 120
			oColumn.Size = 0
			oColumn.DataType = 3
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

		Set oColumn = oTransformation.DestinationColumns.New("ServiceNameShort" , 6)
			oColumn.Name = "ServiceNameShort"
			oColumn.Ordinal = 6
			oColumn.Flags = 104
			oColumn.Size = 20
			oColumn.DataType = 130
			oColumn.Precision = 0
			oColumn.NumericScale = 0
			oColumn.Nullable = True
			
		oTransformation.DestinationColumns.Add oColumn
		Set oColumn = Nothing

	Set oTransProps = oTransformation.TransformServerProperties

		
	Set oTransProps = Nothing

	oCustomTask44.Transformations.Add oTransformation
	Set oTransformation = Nothing

End Sub

