<?php

class VDB3 {
    var $adoConnStr; var $adoConn; var $adoRecs; var $adoCmd;

function VDB3() {
    $this->adoConnStr = 'MosOblGaz';
    $this->adoConn = null;
    $this->adoRecs = null;
    $this->adoCmd = null;
}

function Open($connString) {
    if(!isEmpty($connString)) $this->adoConnStr = $connString;
    $this->adoConn = new COM("ADODB.Connection") or die("Невозможно инициализировать ADO");
    $this->adoRecs = new COM("ADODB.Recordset") or die("Невозможно инициализировать ADO");
    $this->adoCmd = new COM("ADODB.Command") or die("Невозможно инициализировать ADO");
    $php_errormsg =	"";
    //	$this->adoConn->Open($this->adoConnStr);
    if ($this->adoConn->State != 1) $this->adoConn->Open($this->adoConnStr);
    if(strlen($php_errormsg) > 0 || $this->adoConn->State != 1) {
        DBG('db is close. ' . $php_errormsg, 'vdb.inc:VDB3:Open');
        return false;
    }
    $this->adoCmd->ActiveConnection = $this->adoConn;
    $this->adoRecs->CursorLocation = 3; // client
    //	$this->adoRecs->CursorLocation = 2; // server
    return true;
}

function startTrans() {
    $this->adoConn->BeginTrans();
}

function endTrans($bCommit) {
    if ($bCommit != false) $this->adoConn->CommitTrans();
    else $this->adoConn->RollbackTrans();
}


function setCmdParameter($strName, $dType, $dDirection, $dLength, $aValue) {
//		$adChar = 129;
//		$adBSTR = 8 ;
//		$adVarBinary = 204; // 	Binary value
//		$adLongVarBinary = 205; // 	Long binary value
// adWChar  	130  	A null-terminated Unicode character string.
// adUserDefined  	132  	A user-defined variable.
// adVarChar  	200  	A string value (Parameter object only).
// adLongVarChar  	201  	A long string value.
// adVarWChar 	202 	A null-terminated Unicode character string.
// adLongVarWChar 	203 	A long null-terminated Unicode string value.
    //$this->dbOra->setCmdParameter( 'lnks', 200, $adParamInput, strlen($dampedlinks), $dampedlinks );
    //$this->dbOra->setCmdParameter( 'lnks', 129, $adParamInput, strlen($dampedlinks), $dampedlinks );
    //$this->dbOra->setCmdParameter( 'lnks', 8, $adParamInput, strlen($dampedlinks), $dampedlinks );
    //$this->dbOra->setCmdParameter( 'lnks', 130, $adParamInput, strlen($dampedlinks), $dampedlinks );
    //$this->dbOra->setCmdParameter( 'lnks', 202, $adParamInput, strlen($dampedlinks), $dampedlinks );
    //$this->dbOra->setCmdParameter( 'lnks', 203, $adParamInput, strlen($dampedlinks), $dampedlinks );

    DBG($aValue, 'vdb.inc.php : setCmdParameter, ' . $strName);
    $php_errormsg = "";
    //	$param = $this->adoCmd->CreateParameter($strName, $dType, $dDirection, $dLength, $aValue);
    $param = $this->adoCmd->CreateParameter($strName, $dType, $dDirection, $dLength);
    $this->adoCmd->CommandType = 1; // adCmdText
    $this->adoCmd->ActiveConnection = $this->adoConn;
    $param->value = $aValue;
    //	$param->Attributes = 128; // adParamLong 	128 	Accepts binary long values
    //	$param->AppendChunk($aValue);
    $this->adoCmd->Parameters->Append($param);

    if(strlen($php_errormsg) > 0) {
        DBG('parameter not set. ' . $php_errormsg, 'vdb.inc:VDB3:setCmdParameter');
    }
}


function Execute($sql) {
    if ($this->adoConn->State != 1) {
        DBG('ado connection is close', 'vdb.inc.php : Execute');
        return false;
    }
    DBG($sql, 'vdb.inc.php : Execute');
    if ($this->adoRecs->State != 0) $this->adoRecs->Close();

    $this->adoCmd->ActiveConnection = $this->adoConn;
    //	$this->adoRecs->CursorLocation = 3; // client
    //	$this->adoRecs->CursorLocation = 2; // server
    $this->adoConn->CursorLocation = 3;
    $this->adoCmd->CommandText = $sql;

    $php_errormsg = "";
    //	if ($cmd == false) $this->adoRecs->Open($this->adoCmd);
    $this->adoRecs = $this->adoCmd->Execute();
    if(strlen($php_errormsg) > 0 || $this->adoRecs == null || $this->adoRecs->State == 0) {
        //ERR("Невозможно выполнить запрос. SQL: " . $sql . "\nТекст ошибки: " . $php_errormsg);
        DBG('recordset is close. ' . $php_errormsg, 'vdb.inc:VDB3:Execute');
        return false;
    }
    return true;
}


function getRecord() {
    $tRet = null;
    if($this->adoRecs == null || $this->adoRecs->State != 1 || $this->adoRecs->EOF || $this->adoRecs->BOF)
        return $tRet;

    $tRet = array();
    $php_errormsg = "";

    $fc = $this->adoRecs->Fields->Count();
    for ($i = 0; $i < $fc; $i++) {
        $fld = $this->adoRecs->Fields->Item($i);
        $fn = (string)$fld->Name;
        $fv = (string)$fld->Value;
        // DBG($fld->Type, 'field ' .$fld->Name. ' type');
/*
field type:
ora:
    number 139
    varchar2 200
*/
        if ($fld->Type == 13) $tRet[trim($fn)] = 'COM обьект';
        else if ($fld->Type == 135) $tRet[trim($fn)] = formatDatetime("Y-m-d H:i:s", $fv);
        else $tRet[trim($fn)] = trim($fv);
    } // end for each field

    if(strlen($php_errormsg) > 0 || $this->adoRecs == null || $this->adoRecs->State == 0) {
        DBG('recordset is close. ' . $php_errormsg, 'vdb.inc:VDB3:getRecord');
        return null;
    }

    $this->adoRecs->MoveNext();
    return $tRet;
}


function getRecordEx() {
    return getRecord();
}


function recordsetMoveFirst() {
    if($this->adoRecs == null || $this->adoRecs->State == 0 || $this->adoRecs->BOF)
        return false;

    $this->adoRecs->MoveFirst();
    return true;
}

} // class VDB3


class VDB2 {
    var $adoConnStr; var $adoConn; var $adoRecs; var $adoCmd;

function VDB2() {
    $this->adoConnStr = 'MosOblGaz';
    $this->adoConn = null;
    $this->adoRecs = null;
    $this->adoCmd = null;
}

function Open($connString) {
    if(!isEmpty($connString)) $this->adoConnStr = $connString;
    $this->adoConn = new COM("ADODB.Connection") or die("Невозможно инициализировать ADO");
    $this->adoRecs = new COM("ADODB.Recordset") or die("Невозможно инициализировать ADO");
    $this->adoCmd = new COM("ADODB.Command") or die("Невозможно инициализировать ADO");
    $php_errormsg =	"";
    $this->adoConn->Open($this->adoConnStr);
    if(strlen($php_errormsg) > 0) {
        return false;
    }
    $this->adoCmd->ActiveConnection = $this->adoConn;
    $this->adoRecs->CursorLocation = 3;
    return true;
}

function startTrans() {
    $this->adoConn->BeginTrans();
}

function endTrans($bCommit) {
    if ($bCommit != false) $this->adoConn->CommitTrans();
    else $this->adoConn->RollbackTrans();
}


function Execute($sql) {
    DBG($sql, 'vdb.inc.php : Execute');
    if ($this->adoRecs->State != 0) $this->adoRecs->Close();

    $this->adoCmd->ActiveConnection = $this->adoConn;
    $this->adoRecs->CursorLocation = 3;
    $this->adoCmd->CommandText = $sql;

    $php_errormsg = "";
    $this->adoRecs->Open($this->adoCmd);
    if(strlen($php_errormsg) > 0) {
        //ERR("Невозможно выполнить запрос. SQL: " . $sql . "\nТекст ошибки: " . $php_errormsg);
        return false;
    }
    return true;
}


function getRecord() {
    $tRet = null;
    if($this->adoRecs == null || $this->adoRecs->EOF) return $tRet;
    $tRet = array();

    $fc = $this->adoRecs->Fields->Count();
    for ($i = 0; $i < $fc; $i++) {
        $fld = $this->adoRecs->Fields->Item($i);
        //DBG($fld->Type, 'field ' .$fld->Name. ' type');
        if ($fld->Type == 13) $tRet[trim($fld->Name)] = 'COM обьект';
        else if ($fld->Type == 135) $tRet[trim($fld->Name)] = formatDatetime("Y-m-d H:i:s", $fld->Value);
        else $tRet[trim($fld->Name)] = trim($fld->Value);
    }
    $this->adoRecs->MoveNext();

    return $tRet;
}


function getRecordEx() {
    return getRecord();
}

function recordsetMoveFirst() {
    if($this->adoRecs == null) return false;
    $this->adoRecs->MoveFirst();
    return true;
}
} // class VDB2


class VDB
{
    var $sDSN; var $adoConn; var $adoRecs;

function VDB() {
    $this->sDSN = "MosOblGaz"; //'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=d:\mapsite\mosoblgaz\db\newdb.mdb;User ID=Admin;Password=;';
    $this->adoConn = null; // level = object.BeginTrans(); object.BeginTrans; object.CommitTrans; object.RollbackTrans;
    $this->adoRecs = null;
}

function Open($datasource) {
    if(!SEQ("", $datasource)) $this->sDSN = $datasource;
    $this->adoConn = new COM("ADODB.Connection") or die("Невозможно инициализировать ADO");
    $php_errormsg =	"";
    $this->adoConn->open($this->sDSN);
    if(strlen($php_errormsg) > 0) {
        //ERR("Невозможно подключиться к БД. DSN: " . $this->sDSN);
        return false;
    }
    return true;
}

function startTrans() {
    $this->adoConn->BeginTrans();
}

function endTrans($bCommit) {
    if ($bCommit != false) $this->adoConn->CommitTrans();
    else $this->adoConn->RollbackTrans();
}

function Execute($sql) {
    DBG($sql, 'vdb.inc.php : Execute');
    $php_errormsg =	"";
    $this->adoRecs = $this->adoConn->execute($sql);
    if(strlen($php_errormsg) > 0) {
        //ERR("Невозможно выполнить запрос. SQL: " . $sql . "\nТекст ошибки: " . $php_errormsg);
        return false;
    }
    return true;
}


function getRecord() {
    $tRet = array();
    if($this->adoRecs == null || $this->adoRecs->EOF) return $tRet;

    $fc = $this->adoRecs->Fields->Count();
    for ($i = 0; $i < $fc; $i++) {
        $fld = $this->adoRecs->Fields($i);
        $tRet[trim($fld->Name)] = trim($fld->Value);
    }

    //foreach ($tRet as $key=>$value) { $tRet[$key] = trim($value); }
    return $tRet;
} // function getRecord()


function getRecordEx() {
    $tRet = null;
    if($this->adoRecs == null || $this->adoRecs->EOF) return $tRet;
    $tRet = array();

    $fc = $this->adoRecs->Fields->Count();
    for ($i = 0; $i < $fc; $i++) {
        $fld = $this->adoRecs->Fields($i);
        $tRet[trim($fld->Name)] = trim($fld->Value);
    }
    $this->adoRecs->MoveNext();

    return $tRet;
} // function getRecordEx()

} // class VDB

?>
