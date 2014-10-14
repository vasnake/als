<?php
# -*- mode: coding: cp1251 -*-
# (c) Valik mailto:vasnake@gmail.com

include 'globals.php';
include 'utils.inc.php';
include 'vdb.inc.php';
// include '..\userinfo.inc.php';

error_reporting(E_ALL);
ini_set('display_errors', false);
ini_set('html_errors', false);
ini_set('track_errors', true);
set_time_limit ( 1700 );

ob_start();

header("Content-Type: application/xml; charset=WINDOWS-1251");
header("Expires: " . gmdate("D, d M Y H:i:s", mktime()+70 ) . " GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
// HTTP/1.1
//header("Cache-Control: no-store, no-cache, must-revalidate");
//header("Cache-Control: post-check=0, pre-check=0", false);
// HTTP/1.0
//header("Pragma: no-cache");

$appParams = array();
// db connection params:
$appParams['udlFileName'] = 'E:\files\website\mosoblgaz\html\_test\topo\topotest.udl';

OUT('<?xml version="1.0" encoding="WINDOWS-1251" ?>
<?xml-stylesheet type="text/xsl" href="acc.localiz.rep.xsl" ?>
<page>
    <id>acc.localiz.report</id>
    <title>Отчет. Локализация аварии - результаты расчетов</title>
<!-- вывод параметров запроса ($_REQUEST): -->'
);

$res = true;
$args = dumpQuery2XML($_REQUEST);
$app = new VApp;

OUT('<!-- вывод данных страницы: -->');
OUT('<App>');
    $app->Init($args);
    $res = $app->doWork();
OUT('</App>');

if ($res == false) {
    appERR('Выполнение прервано. Отправьте исходный текст страницы разработчику или свяжитесь с администратором системы.');
}

OUT('</page>');

if ( SEQ(GFA($args, 'xslt'), 'server') ) {
    $xmlDoc = new COM("Microsoft.XMLDOM") or die("Невозможно инициализировать XMLDOM");
    $xmlDoc->async = false;

    $xslDoc = new COM("Microsoft.XMLDOM") or die("Невозможно инициализировать XMLDOM");
    $xslDoc->async = false;

    $xmlDoc->loadXML(ob_get_contents());
    $xslDoc->load(realpath('acc.localiz.rep.xsl'));

    ob_end_clean();
    header("Content-Type: text/html; charset=WINDOWS-1251");
    OUT($xmlDoc->transformNode($xslDoc));
}
ob_end_flush();

// end of app code.

// classes

///////////////////////////////////////////////////////////////////////////////
//
//	App: {
//
///////////////////////////////////////////////////////////////////////////////

class VApp {
    var $bStat; var $db; var $req; var $bDebug; var $sAction;
    var $sHowDone;
    var $dbOra;

function VApp() {
    $this->bStat = false;
    $this->db = null;
    $this->req = array();
    $this->bDebug = false;
    $this->sAction = 'init';
    $this->sHowDone = '';
    $this->dbOra = null;
}


function Init($args) {
    $this->bStat = false;
    $this->sHowDone = 'инициализация приложения не завершена';
    foreach ($args as $key=>$value) {
        $this->req[$key] = trim($value);
    }

    global $glob_MOGSiteRoot;
    // site db connection string
    $connStrCdb = 'File Name=' . $glob_MOGSiteRoot . '\db\udl\cdb.udl';
    // oracle db connection string
    $connStrOra = 'File Name=' . $glob_MOGSiteRoot . '\db\udl\oragisdb.udl';

    // site db
    $db = new VDB3;
    if (false == $db->Open($connStrCdb)) {
        ERR('Невозможно открыть БД: ' . $connStrCdb); return false;
    }
    $this->db = $db;

    // oracle db
    $db = new VDB3;
    if (false == $db->Open($connStrOra)) {
        ERR('Невозможно открыть БД: ' . $connStrOra); return false;
    }
    $this->dbOra = $db;

    if ( SEQ(GFA($args, 'mode'), 'debug') ) {
        $this->bDebug = true;
    } else {
        $this->bDebug = false;
    }

// http://localhost/gismog/perspectives/acc.localiz/
// acc.localiz.php?client=ajax&action=findarc&lon=40.25449543571657&lat=55.0521175361913
    $this->sAction = GFA($args, 'action');
    if ( isEmpty($this->sAction) ) $this->sAction = 'init';
    // findarc

    $this->bStat = true;
    $this->sHowDone = 'инициализация приложения завершена';
} // Init


function findAndPrintPointedLink() {
    $this->bStat = false;
    $this->sHowDone = 'сбой при поиске указанного сегмента трубопровода';
    $args = $this->req;
    $lon = GFA( $args, 'lon' );
    $lat = GFA( $args, 'lat' );

// select id, type, objid from topolink where id=mogTopo.getLinkByPoint(40.25449, 55.052117);
$sql = '
select id, type, objid from topolink
    where id=mogTopo.getLinkByPoint(' .$lon. ', ' .$lat. ')
';
    if (false == $this->dbOra->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->dbOra, 'failedLink');

    $this->dbOra->recordsetMoveFirst();
    $arrRec = $this->dbOra->getRecord();
    $pipeID = GFA($arrRec, 'OBJID');
    $linkID = GFA($arrRec, 'ID');

$sql = '
select count(srcid) numsrc from toposrc
    where objtype=\'LINK\' and objid=' .$linkID. '
';
    if (false == $this->dbOra->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->dbOra, 'failedLinkSources');

$sql = '
SELECT Gas.PressureType.PressureTypeName, Gas.[Pipe].PipeDiam
    FROM Gas.[Pipe] INNER JOIN Gas.PressureType
    ON Gas.[Pipe].PressureTypeID = Gas.PressureType.PressureTypeID
    where Gas.[Pipe].PipeID = ' .$pipeID. '
';
/*
SELECT 'Давление: ' + Gas.PressureType.PressureTypeName + ', диаметр: ' + CONVERT(
    varchar, Gas.[Pipe].PipeDiam) + ' мм' AS PressureDiametr
    FROM Gas.[Pipe] INNER JOIN
    Gas.PressureType ON Gas.[Pipe].PressureTypeID = Gas.PressureType.PressureTypeID
    where Gas.[Pipe].PipeID = 4047;

*/
    if (false == $this->db->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->db, 'failedPipe');

    $this->sHowDone = 'Запрос обработан успешно.';
    $this->bStat = true;
    return true;
} // findAndPrintPointedLink


function findAndPrintLockersAndDisconn() {
    $this->bStat = false;
    $this->sHowDone = 'сбой при поиске запорных узлов и отключенных потребителей';
    $args = $this->req;
    $failedlinks = GFA( $args, 'failedlinks' );

    // найти запорные устройства (обьекты подсети):
$sql = '
select * from table(mogTopo.getLockers4FailedLinks(\'' .$failedlinks. '\'))
';
    if (false == $this->dbOra->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->dbOra, 'Lockers');

    // составить список линков, вырубленных запорными устройствами:
    $dampedlinks = '';
    $this->dbOra->recordsetMoveFirst();
    {
        $r = null;
        while ( ($r = $this->dbOra->getRecord()) != null) {
            $typ = GFA($r, 'TYPE');
            if (SEQ($typ, 'PART') || (SEQ($typ, 'WHOLE'))) {
                $lid = GFA($r, 'ID');
                if(isEmpty($dampedlinks) == false) $dampedlinks = $dampedlinks . ',';
                $dampedlinks = $dampedlinks . $lid;
            }
            // если запорных устройств больше 200 - обрубать расчет с уведомлением о ненормальности сети.
        } // recordset EOF
    } // end make dampedlinks list

/*
список линков длинной более 4000 байт не пролазит:
http://igate.geol.msu.ru/gismog/perspectives/acc.localiz/acc.localiz.php?client=ajax&action=findlockersanddisconn&failedlinks=54632
http://www.google.ru/search?q=ORA-01704
http://www.devguru.com/Technologies/ado/quickref/command_createparameter.html

$sql = '
select * from table(mogTopo.getDisconnectedByDampedLinks2(?))
';
    $cmdP = $this->dbOra->adoCmd->CreateParameter('lnks', 200, 1, count($dampedlinks));
    $this->dbOra->adoCmd->CommandText = $sql;
    $this->dbOra->adoCmd->CommandType = 1;
    $this->dbOra->adoCmd->ActiveConnection = $this->dbOra->adoConn;
    $this->dbOra->adoCmd->Parameters->Append($cmdP);
    $cmdP->value = $dampedlinks;
    $this->dbOra->adoRecs->Close();
    $this->dbOra->adoRecs->Open($this->dbOra->adoCmd);

$sql = '
select * from table(mogTopo.getDisconnectedByDampedLinks2(\'' .$dampedlinks. '\'))
';
    if (false == $this->dbOra->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->dbOra, 'Disconnected');

global temporary table
you can use FORALL to do a bulk bind and insert
create global temporary table foo (...) on commit delete rows;
*/

    // найти отключенных потребителей (обьекты сети без газа):
    if (strlen($dampedlinks) > 3000) {
$sql = '
select * from table(mogTopo.getDisconnByFailedLinks(\'' .$failedlinks. '\'))
';
    }
    else {
$sql = '
select * from table(mogTopo.getDisconnectedByDampedLinks2( ? ))
';
        $adParamInput = 1;
        $adLongVarChar = 201; // Long string value
        $this->dbOra->setCmdParameter( 'lnks', $adLongVarChar, $adParamInput, strlen($dampedlinks), $dampedlinks );
    }

    if (false == $this->dbOra->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->dbOra, 'Disconnected');

    // составить список линков оставшихся без газа:
    $disconnlinks = '';
    $this->dbOra->recordsetMoveFirst();
    {
        $r = null;
        while ( ($r = $this->dbOra->getRecord()) != null) {
            $typ = GFA($r, 'TYPE');
            if (SEQ($typ, 'PART') || (SEQ($typ, 'WHOLE'))) {
                $lid = GFA($r, 'ID');
                if(isEmpty($disconnlinks) == false) $disconnlinks = $disconnlinks . ',';
                $disconnlinks = $disconnlinks . $lid;
            }
        } // recordset EOF
    } // end make disconnlinks list

    // вычислить бокс для линков без газа:
$sql = '
select max(t.x) as MAXX, max(t.y) as MAXY, min(t.x) as MINX, min(t.y) as MINY from table
    ( select SDO_UTIL.GETVERTICES(mbr) from
    ( select sdo_aggr_mbr(geom) mbr from topolink where id in
    ( ' .$disconnlinks. ' ) ) ) t
';
    if (false == $this->dbOra->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->dbOra, 'netMBR');

    $this->sHowDone = 'Запрос обработан успешно.';
    $this->bStat = true;
    return true;
} // findAndPrintLockersAndDisconn


function printReport() {
    $this->bStat = false;
    $this->sHowDone = 'сбой при поиске составлении отчета';
    $args = $this->req;
    $objects = GFA( $args, 'taRep' );

    $arrParts = explode('*', $objects);
    $arrLockers = explode('#', $arrParts[0]);
    $arrDisconn = explode('#', $arrParts[1]);
    $arrFLinks = explode('#', $arrParts[2]);

    $arrLockersObj = array_unique( explode(',', $arrLockers[1]) ); // elem: GRS:139
    $arrDisconnObj = array_unique( explode(',', $arrDisconn[1]) ); // elem: BOIL:2392
    $arrFLinksObj = array_unique( explode(',', $arrFLinks[1]) ); // elem: 4047:высокое I категории:300:40.2342:55.0353

    OUT('<failedLinks>');
    for ($i = 0; $i < count($arrFLinksObj); $i++ ) {
        OUT('	<link>');
        $fl = explode(':', $arrFLinksObj[$i]);
        printTag('pipePress', $fl[1]);
        printTag('pipeDiam', $fl[2]);
        printTag('lon', $fl[3]);
        printTag('lat', $fl[4]);
        OUT('	</link>');
    }
    OUT('</failedLinks>');

    // 4 lists: lockers bolts, lockers grp, disconn grp, disconn boilers
    $strlistLockerBolt = '';
    for ($i = 0; $i < count($arrLockersObj); $i++) {
        $lo = explode(':', $arrLockersObj[$i]);
        if ( strncasecmp ( 'BOLT', $lo[0], 4 ) == 0 ) {
            if ( strlen($strlistLockerBolt) > 0 ) $strlistLockerBolt .= ',';
            $strlistLockerBolt = $strlistLockerBolt . $lo[1];
        }
    }

    $strlistLockerGrp = '';
    for ($i = 0; $i < count($arrLockersObj); $i++) {
        $lo = explode(':', $arrLockersObj[$i]);
        if ( strncasecmp ( 'GRP', $lo[0], 3 ) == 0 ) {
            if ( strlen($strlistLockerGrp) > 0 ) $strlistLockerGrp .= ',';
            $strlistLockerGrp .= $lo[1];
        }
    }

    $strlistDisconnGrp = '';
    for ($i = 0; $i < count($arrDisconnObj); $i++) {
        $lo = explode(':', $arrDisconnObj[$i]);
        if ( strncasecmp ( 'GRP', $lo[0], 3 ) == 0 ) {
            if ( strlen($strlistDisconnGrp) > 0 ) $strlistDisconnGrp .= ',';
            $strlistDisconnGrp .= $lo[1];
        }
    }

    $strlistDisconnBoil = '';
    for ($i = 0; $i < count($arrDisconnObj); $i++) {
        $lo = explode(':', $arrDisconnObj[$i]);
        if ( strncasecmp ( 'BOIL', $lo[0], 4 ) == 0 ) {
            if ( strlen($strlistDisconnBoil) > 0 ) $strlistDisconnBoil .= ',';
            $strlistDisconnBoil .= $lo[1];
        }
    }

    // lockers: bolts
$sql = '
SELECT Gas.Bolt.BoltID, Org.Department.DepartmentName, Org.Service.ServiceName, \'-\' AS BoltAddress
FROM Gas.Bolt
    INNER JOIN Org.Service ON Gas.Bolt.ServiceID = Org.Service.ServiceID
    INNER JOIN Org.Department ON Gas.Bolt.DepartmentID = Org.Department.DepartmentID
where Gas.Bolt.BoltID in (' .$strlistLockerBolt. ')
    ORDER BY Gas.Bolt.DepartmentID, Gas.Bolt.ServiceID, Gas.Bolt.BoltID
';
    if (strlen($strlistLockerBolt) > 0) {
    if (false == $this->db->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->db, 'lockersBOLT');}

    // lockers: GRP, SHRP
$sql = '
SELECT Gas.GRP.GrpID,
    Gas.GrpType.GrpTypeName, Gas.GRP.GrpNumber, Org.Department.DepartmentName,
    Org.Service.ServiceName,
    Gas.GRP.GrpName, Gas.GRP.GrpAddress,
    Gas.GasObjectProperty.GasObjPropertyName AS GrpServiceProperty,
    GasObjectProperty_1.GasObjPropertyName AS GrpBalanceProperty
FROM Org.Service
    INNER JOIN Gas.GRP ON Org.Service.ServiceID = Gas.GRP.ServiceID
    INNER JOIN Org.Department ON Gas.GRP.DepartmentID = Org.Department.DepartmentID
    INNER JOIN Gas.GasObjectProperty ON Gas.GRP.ServiceGasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID
    INNER JOIN Gas.GrpType ON Gas.GRP.GrpTypeID = Gas.GrpType.GrpTypeID
    INNER JOIN Gas.GasObjectProperty GasObjectProperty_1 ON Gas.GRP.BalanceGasObjPropertyID = GasObjectProperty_1.GasObjPropertyID
where Gas.GRP.GrpID in (' .$strlistLockerGrp. ')
    ORDER BY Org.Department.DepartmentName, Org.Service.ServiceName
';
    if (strlen($strlistLockerGrp) > 0) {
    if (false == $this->db->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->db, 'lockersGRP');}

    // disconn: GRP, SHRP
$sql = '
SELECT Gas.GRP.GrpID,
    Gas.GrpType.GrpTypeName, Gas.GRP.GrpNumber, Org.Department.DepartmentName,
    Org.Service.ServiceName,
    Gas.GRP.GrpName, Gas.GRP.GrpAddress,
    Gas.GasObjectProperty.GasObjPropertyName AS GrpServiceProperty,
    GasObjectProperty_1.GasObjPropertyName AS GrpBalanceProperty
FROM Org.Service INNER JOIN Gas.GRP ON Org.Service.ServiceID = Gas.GRP.ServiceID
    INNER JOIN Org.Department ON Gas.GRP.DepartmentID = Org.Department.DepartmentID
    INNER JOIN Gas.GasObjectProperty ON Gas.GRP.ServiceGasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID
    INNER JOIN Gas.GrpType ON Gas.GRP.GrpTypeID = Gas.GrpType.GrpTypeID
    INNER JOIN Gas.GasObjectProperty GasObjectProperty_1 ON Gas.GRP.BalanceGasObjPropertyID = GasObjectProperty_1.GasObjPropertyID
where Gas.GRP.GrpID in (' .$strlistDisconnGrp. ')
    ORDER BY Org.Department.DepartmentName, Org.Service.ServiceName
';
    if (strlen($strlistDisconnGrp) > 0) {
    if (false == $this->db->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->db, 'disconnGRP');}

    // disconn: boilers
$sql = '
SELECT Gas.Boiler.BoilerID, Org.Department.DepartmentName,
    Org.Service.ServiceName, \'-\' AS BoilerName, \'-\' AS BoilerAddress,
    Gas.GasObjectProperty.GasObjPropertyName
FROM Org.Service
    INNER JOIN Gas.Boiler ON Org.Service.ServiceID = Gas.Boiler.ServiceID
    INNER JOIN Org.Department ON Gas.Boiler.DepartmentID = Org.Department.DepartmentID
    INNER JOIN Gas.GasObjectProperty ON Gas.Boiler.GasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID
where Gas.Boiler.BoilerID in (' .$strlistDisconnBoil. ')
    ORDER BY Org.Department.DepartmentName, Org.Service.ServiceName
';
    if (strlen($strlistDisconnBoil) > 0) {
    if (false == $this->db->Execute($sql)) {
        ERR("Невозможно выполнить запрос к БД: " . $sql);
        return false;
    }
    $iRecCount = xmlDumpRecset($this->db, 'disconnBOIL');}

    setlocale(LC_TIME, array ('ru_RU.CP1251', 'rus_RUS.1251'));
    $strDate = strftime(' %d/%m/%Y');
    printTag('currDate', $strDate);

    $this->sHowDone = 'Запрос обработан успешно.';
    $this->bStat = true;
    return true;
} // printReport


function doWork() {
    if ( $this->bStat == false) {
        ERR('Ошибка инициализации. Обработка прервана.');
        return false;
    }

    if ( SEQ($this->sAction, 'findarc') ) {
        $this->findAndPrintPointedLink();
    }
    else if ( SEQ($this->sAction, 'findlockersanddisconn') ) {
        $this->findAndPrintLockersAndDisconn();
    }
    else if ( SEQ($this->sAction, 'report') ) {
        $this->printReport();
    }

    printTag('requestStatus', $this->sHowDone);
    return $this->bStat;
} // doWork

} // class VApp


function DBG($logStr, $pref = "PHP DBG") {
    echo "\n<DBG>\n\t$pref:\n"; // if <!-- DBG> then need replace every -- in dump.
    if (is_array($logStr)) {
        //print_r($logStr);
        foreach ($logStr as $key => $value)
            safeOUT("Array[$key]=$value");
            //safeOUT("Array[" .str_replace('-', '_', $key). "]=" .str_replace('-', '_', $value));
    }
    else {
        //echo $logStr;
        //safeOUT(str_replace('-', '_', $logStr));
        safeOUT($logStr);
    }
    echo "\t$pref.\n</DBG>\n";
    return;
};

?>
