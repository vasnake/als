<?php

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
$appParams['udlFileName'] = 'E:\files\website\mosoblgaz\html\_test\topo\topotest.udl';

/*
OUT('<?xml version="1.0" encoding="WINDOWS-1251" ?>
<page>
	<id>acc.localiz.topotool.server.resp</id>
	<title>Результаты топологических расчетов</title>
<!-- вывод параметров запроса ($_REQUEST): -->
');
*/

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
	$xslDoc->load(realpath('acc.localiz.calc.xsl'));

	ob_end_clean();
	header("Content-Type: text/html; charset=WINDOWS-1251");
	OUT($xmlDoc->transformNode($xslDoc));
}
ob_end_flush();


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
	$this->bStat = false; $this->db = null; $this->req = array(); $this->bDebug = false; $this->sAction = 'init';
	$this->sHowDone = '';
	$this->dbOra = null;
}
function Init($args) {
	$this->bStat = false;
	$this->sHowDone = 'инициализация приложения не завершена';
	foreach ($args as $key=>$value) { $this->req[$key] = trim($value); }

	global $glob_MOGSiteRoot;
	$connStrCdb = 'File Name=' . $glob_MOGSiteRoot . '\db\udl\cdb.udl';
	$connStrOra = 'File Name=' . $glob_MOGSiteRoot . '\db\udl\oragisdb.udl';

	$db = new VDB3; if (false == $db->Open($connStrCdb)) {
		ERR('Невозможно открыть БД: ' . $connStrCdb); return false;
	}
	$this->db = $db;
	$db = new VDB3; if (false == $db->Open($connStrOra)) {
		ERR('Невозможно открыть БД: ' . $connStrOra); return false;
	}
	$this->dbOra = $db;

// http://igate.geol.msu.ru/gismog/perspectives/acc.localiz/
// acc.localiz.php?client=ajax&action=findarc&lon=40.25449543571657&lat=55.0521175361913

	if ( SEQ(GFA($args, 'mode'), 'debug') ) {
		$this->bDebug = true;
	} else {
		$this->bDebug = false;
	}

	$this->sAction = GFA($args, 'action'); if ( isEmpty($this->sAction) ) $this->sAction = 'init';
	// findarc

	$this->bStat = true;
	$this->sHowDone = 'инициализация приложения завершена';
} // Init

function findAndPrintPointedLink() {
	$this->bStat = false;
	$this->sHowDone = 'сбой при поиске указанного сегмента трубопровода';
	$args = $this->req;
	$lon = GFA( $args, 'lon' ); $lat = GFA( $args, 'lat' );

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

	if (false == $this->db->Execute($sql)) {
		ERR("Невозможно выполнить запрос к БД: " . $sql);
		return false;
	}
	$iRecCount = xmlDumpRecset($this->db, 'failedPipe');

/*
SELECT 'Давление: ' + Gas.PressureType.PressureTypeName + ', диаметр: ' + CONVERT(
	varchar, Gas.[Pipe].PipeDiam) + ' мм' AS PressureDiametr
	FROM Gas.[Pipe] INNER JOIN
	Gas.PressureType ON Gas.[Pipe].PressureTypeID = Gas.PressureType.PressureTypeID
	where Gas.[Pipe].PipeID = 4047;

*/
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
http://www.google.ru/search?q=ORA-01704&sourceid=mozilla-search&start=0&start=0&ie=utf-8&oe=utf-8&client=firefox-a&rls=org.mozilla:en-US:official
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
		$adLongVarChar = 201; // 	Long string value
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
	FROM Gas.Bolt INNER JOIN Org.Service
	ON Gas.Bolt.ServiceID = Org.Service.ServiceID INNER JOIN Org.Department
	ON Gas.Bolt.DepartmentID = Org.Department.DepartmentID
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
	FROM Org.Service INNER JOIN Gas.GRP
	ON Org.Service.ServiceID = Gas.GRP.ServiceID INNER JOIN Org.Department
	ON Gas.GRP.DepartmentID = Org.Department.DepartmentID INNER JOIN Gas.GasObjectProperty
	ON Gas.GRP.ServiceGasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID INNER JOIN Gas.GrpType
	ON Gas.GRP.GrpTypeID = Gas.GrpType.GrpTypeID INNER JOIN Gas.GasObjectProperty GasObjectProperty_1
	ON Gas.GRP.BalanceGasObjPropertyID = GasObjectProperty_1.GasObjPropertyID
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
	FROM Org.Service INNER JOIN Gas.GRP
	ON Org.Service.ServiceID = Gas.GRP.ServiceID INNER JOIN Org.Department
	ON Gas.GRP.DepartmentID = Org.Department.DepartmentID INNER JOIN Gas.GasObjectProperty
	ON Gas.GRP.ServiceGasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID INNER JOIN Gas.GrpType
	ON Gas.GRP.GrpTypeID = Gas.GrpType.GrpTypeID INNER JOIN Gas.GasObjectProperty GasObjectProperty_1
	ON Gas.GRP.BalanceGasObjPropertyID = GasObjectProperty_1.GasObjPropertyID
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
	FROM Org.Service INNER JOIN Gas.Boiler
	ON Org.Service.ServiceID = Gas.Boiler.ServiceID INNER JOIN Org.Department
	ON Gas.Boiler.DepartmentID = Org.Department.DepartmentID INNER JOIN Gas.GasObjectProperty
	ON Gas.Boiler.GasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID
where Gas.Boiler.BoilerID in (' .$strlistDisconnBoil. ')
	ORDER BY Org.Department.DepartmentName, Org.Service.ServiceName
';
	if (strlen($strlistDisconnBoil) > 0) {
	if (false == $this->db->Execute($sql)) {
		ERR("Невозможно выполнить запрос к БД: " . $sql);
		return false;
	}
	$iRecCount = xmlDumpRecset($this->db, 'disconnBOIL');}

/*

на входе:
<action>report</action>
<taRep>
LOCKERS#GRS:139,GRP:4590,GRP:4589
*DISCONN#BOIL:2392,GRP:4703
*FAILLINKS#4047:высокое I категории:300:40.2342:55.0353,4022:высокое II категории:110:39.9870:55.2302
pipeID:press:diam:lon:lat, ...
</taRep>

нужно вывести:

дату 25 ноября 2005
setlocale (LC_ALL, array ('ru_RU.CP1251', 'rus_RUS.1251'));
LC_TIME
string strftime ( string format [, int timestamp ] )
%e - day of the month as a decimal number, a single digit is preceded by a space (range ' 1' to '31')
%B - full month name according to the current locale
%Y - year as a decimal number including the century

битые линки:
	давление диаметр координаты

запорные устройства задвижки:
	номер, филиал, рэс, местоположение

запорные устройства рег.пунктов:
	тип, номер, филиал, рэс, название, местоположение, обслуживание, баланс
«Запорные устройства внутри регуляторных пунктов» (аналогично для отключенных потребителей – «Регуляторные пункты»)
SELECT     Gas.GrpType.GrpTypeName, Gas.GRP.GrpNumber, Org.Department.DepartmentName, Org.Service.ServiceName,
                      Gas.GRP.GrpName, Gas.GRP.GrpAddress, Gas.GasObjectProperty.GasObjPropertyName AS GrpServiceProperty,
                      GasObjectProperty_1.GasObjPropertyName AS GrpBalanceProperty
FROM         Org.Service INNER JOIN
                      Gas.GRP ON Org.Service.ServiceID = Gas.GRP.ServiceID INNER JOIN
                      Org.Department ON Gas.GRP.DepartmentID = Org.Department.DepartmentID INNER JOIN
                      Gas.GasObjectProperty ON Gas.GRP.ServiceGasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID INNER JOIN
                      Gas.GrpType ON Gas.GRP.GrpTypeID = Gas.GrpType.GrpTypeID INNER JOIN
                      Gas.GasObjectProperty GasObjectProperty_1 ON Gas.GRP.BalanceGasObjPropertyID = GasObjectProperty_1.GasObjPropertyID
ORDER BY Org.Department.DepartmentName, Org.Service.ServiceName

отключенные потребители:

	котельные:
		номер, филиал, рэс, название, местоположение, баланс
Котельные
SELECT     Gas.Boiler.BoilerID, Org.Department.DepartmentName, Org.Service.ServiceName, '-' AS BoilerName, '-' AS BoilerAddress,
                      Gas.GasObjectProperty.GasObjPropertyName
FROM         Org.Service INNER JOIN
                      Gas.Boiler ON Org.Service.ServiceID = Gas.Boiler.ServiceID INNER JOIN
                      Org.Department ON Gas.Boiler.DepartmentID = Org.Department.DepartmentID INNER JOIN
                      Gas.GasObjectProperty ON Gas.Boiler.GasObjPropertyID = Gas.GasObjectProperty.GasObjPropertyID
ORDER BY Org.Department.DepartmentName, Org.Service.ServiceName

	рег. пункты:
		тип, номер, филиал, рэс, название, местоположение, обслуживание, баланс

*/

	setlocale(LC_TIME, array ('ru_RU.CP1251', 'rus_RUS.1251'));
	//$strDate = strftime(' %d %B %Y');
	$strDate = strftime(' %d/%m/%Y');
	printTag('currDate', $strDate);

	$this->sHowDone = 'Запрос обработан успешно.';
	$this->bStat = true;
	return true;
} // printReport


function doWork() {
	if ( $this->bStat == false) {
		ERR('Ошибка инициализации. Обработка прервана.'); return false;
	}
//	$this->printCommonData();

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


///////////////////////////////////////////////////////////////////////////////

/*

error_reporting(E_ALL);
ini_set('display_errors', false);
ini_set('html_errors', false);
ini_set('track_errors', true);
set_time_limit ( 1700 );

// http заголовки для страницы
header("Content-Type: application/xml; charset=WINDOWS-1251");
// header("Expires: " . gmdate("D, d M Y H:i:s", mktime()+70 ) . " GMT");
header("Expires: " . gmdate("D, d M Y H:i:s") . " GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");

$appParams = array();
$appParams['udlFileName'] = 'E:\files\website\mosoblgaz\html\_test\topo\topotest.udl';

// стандартная шапка страницы
echo '<?xml version="1.0" encoding="WINDOWS-1251"?>';
echo '<page>';
// echo '</page>';
// exit();

// http://igate.geol.msu.ru/gismog/perspectives/acc.localiz/acc.localiz.php?client=ajax&action=findarc&lon=40.25449543571657&lat=55.0521175361913

adoInitLibrary();

// забираем параметры из http запроса
echo '<qry>';
$action = $_REQUEST['action'];
echo '<action>' .$action. '</action>';

if (SEQ($action, 'findarc') != false) { // find pointed link
	$lon = $_REQUEST['lon'];
	$lat = $_REQUEST['lat'];
	echo '<lon>' .$lon. '</lon> <lat>' .$lat. '</lat>';
	echo '</qry>';
	findAndPrintPointedLink($lon, $lat);
} else if (SEQ($action, 'findbolts') != false) { // find bolts for cut off gas
	$failedlinks = $_REQUEST['failedlinks'];
	$failedlinks = utf8win1251(urldecode($failedlinks)); // JavaScript: encodeURIComponent();
	echo '<failedlinks>' .safeStr($failedlinks). '</failedlinks>';
	echo '</qry>';
	findAndPrintLockingObjects($failedlinks);
} else if (SEQ($action, 'findcust') != false) { // find customers, who without gas
	$locked = $_REQUEST['locked'];
	$locked = utf8win1251(urldecode($locked)); // JavaScript: encodeURIComponent();
	echo '<locked>' .safeStr($locked). '</locked>';
	echo '</qry>';
	findAndPrintCustomers($locked);
} else {
	echo '</qry>';
}

// закрываем страницу
echo '</page>';

function findAndPrintPointedLink($lon, $lat) {
// найти и распечатать ID указанного точкой линка
//	$linkid = rand();
//	echo '<linkid>' .$linkid. '</linkid>';
//	select mogTopo.getLinkByPoint(33.33,55.55) LINKID from dual;
	$adoRecs = adoExecQuery('select mogTopo.getLinkByPoint(' .$lon. ', ' .$lat. ') linkid from dual');
	while ($adoRecs != null && $adoRecs->State == 1 && !$adoRecs->EOF) {
		for ($i = 0; $i < $adoRecs->Fields->Count(); $i++) {
			$fld = $adoRecs->Fields->Item($i); $fn = strtolower((string)$fld->Name); $fv = (string)$fld->Value;
			echo'<' . $fn . '>' . $fv . '</' . $fn . '>';
		}
		$adoRecs->MoveNext();
	}
}; // findAndPrintPointedLink

function findAndPrintLockingObjects ($failedlinks) { // list of  linkid, comma separated
// найти и распечатать обьекты (тип, ID) отсекающие течение газа в битые линки (а заодно и сами линки)
// GRS, GRP, Boiler, Bolt, Link, netMBR
// запорное устройство - комбинация из типа пункта, ID пункта, ID линка (GRP,77,33)
// select * from table(mogTopo.getLockers4FailedLinks('3,7,17')) order by type, objid, id;
	global $appParams;

	getObjectsBySql('select * from table(mogTopo.getLockers4FailedLinks(\'' .$failedlinks. '\')) order by type, objid, id');
	$arrGRPID = $appParams['arrGRPID'];
	$arrGRSID = $appParams['arrGRSID'];
	$arrPipeID = $appParams['arrPipeID'];
	$arrBoilerID = $appParams['arrBoilerID'];
	$arrBoltID = $appParams['arrBoltID'];
	$arrEndID = $appParams['arrEndID'];

// создаем строки - списки ID
	$listGRP = implode(',', $arrGRPID);
	$listGRS = implode(',', $arrGRSID);
	$listLink = implode(',', $arrPipeID);
	$listBoiler = implode(',', $arrBoilerID);
	$listBolt = implode(',', $arrBoltID);
	$listEnds = implode(',', $arrEndID);

	$maxx = -180; $minx = 180; $maxy = -90; $miny = 90;

	echo '<listGRS>' .$listGRS. '</listGRS>';
	echo '<listGRP>' .$listGRP. '</listGRP>';
	echo '<listBoiler>' .$listBoiler. '</listBoiler>';
	echo '<listBolt>' .$listBolt. '</listBolt>';
	echo '<listLink>' .$listLink. '</listLink>';
	echo '<listEnds>' .$listEnds. '</listEnds>';

// MBR:
	$sql = 'select max(t.x) as MAXX, max(t.y) as MAXY, min(t.x) as MINX, min(t.y) as MINY from table
( select SDO_UTIL.GETVERTICES(mbr) from
( select sdo_aggr_mbr(geom) mbr from topolink where id in
( ' .$listLink. ' )
) ) t';

	echo '<netmbr>';
	getObjectsBySql($sql);
	echo '</netmbr>';
//	echo '<netmbr> <MAXX>' .$maxx. '</MAXX> <MAXY>' .$maxy. '</MAXY> <MINX>' .$minx. '</MINX> <MINY>' .$miny. '</MINY> </netmbr>';
}; // findAndPrintLockingObjects

function findAndPrintCustomers($locked) { // LINK:4940,3989;GRS:16820,477;GRP:20818,19491;BOILER:17696,24281;BOLT:12446,1919
// найти потребителей (ГРП и котельные) отключенных от источника по причине перекрытия указанных запорных устройств
// если к потребителю подходит хоть один линк с газом - считать подключенным.
// select * from table(mogTopo.getDisconnectedByDampedLinks('3,7,17'));
	global $appParams;

// найти список вырубленных линков:
	$strLinks = '';
	$arrT = explode(';', $locked);
	$arrTLength =count($arrT);
	for ($i = 0; $i < $arrTLength; $i++) {
		if ( strncasecmp ( 'LINK', $arrT[$i], 4 ) == 0 ) {
			$strLinks = $arrT[$i];
			break;
		}
	}
	$arrT = explode(':', $strLinks);
	$strLinks = $arrT[1];

// получим массивы обьектов (ГХ)
	getObjectsBySql('select * from table(mogTopo.getDisconnectedByDampedLinks(\'' .$strLinks. '\'))');
	$arrGRPID = $appParams['arrGRPID'];
	$arrPipeID = $appParams['arrPipeID'];
	$arrBoilerID = $appParams['arrBoilerID'];

	$listGRP = implode(',', $arrGRPID);
	$listLink = implode(',', $arrPipeID);
	$listBoiler = implode(',', $arrBoilerID);

	$maxx = -180; $minx = 180; $maxy = -90; $miny = 90;
	echo '<listLink>' .$listLink. '</listLink>';
	echo '<listGRP>' .$listGRP. '</listGRP>';
	echo '<listBoiler>' .$listBoiler. '</listBoiler>';

	$sql = 'select max(t.x) as MAXX, max(t.y) as MAXY, min(t.x) as MINX, min(t.y) as MINY from table
( select SDO_UTIL.GETVERTICES(mbr) from
( select sdo_aggr_mbr(geom) mbr from topolink where id in
( ' .$listLink. ' )
) ) t';

	echo '<netmbr>';
	getObjectsBySql($sql);
	echo '</netmbr>';
//	echo '<netmbr> <MAXX>' .$maxx. '</MAXX> <MAXY>' .$maxy. '</MAXY> <MINX>' .$minx. '</MINX> <MINY>' .$miny. '</MINY> </netmbr>';

}; // findAndPrintCustomers

function getObjectsBySql($sql) {
	global $appParams;
// создаем массивы для сохранения списков ID обьектов
	$arrGRPID = array();
	$arrGRSID = array();
	$arrPipeID = array();
	$arrBoilerID = array();
	$arrBoltID = array();
	$arrEndID = array();
// выполняем запрос и перебираем строки
	$adoRecs = adoExecQuery($sql);
echo '
<DBG>adorecs is null: ' .(($adoRecs == null)?'true':'false'). ', adorecs.state: ' .$adoRecs->State. ', adorecs.eof: ' .(($adoRecs->EOF == false)?'no':'yes'). '</DBG>
';

	while ($adoRecs != null && $adoRecs->State == 1 && !$adoRecs->EOF) {
		echo '<row>';
		for ($i = 0; $i < $adoRecs->Fields->Count(); $i++) {
			$fld = $adoRecs->Fields->Item($i);
			$fn = strtolower((string)$fld->Name);
			$fv = (string)$fld->Value;
			echo'<' . $fn . '>' . $fv . '</' . $fn . '>';
// попутно сохраняем ID в массивы
			if ( SEQ($fn, 'TYPE') ) {
//				$fld = $adoRecs->Fields->Item('objid'); $oid = $fld->Value;
				$fld_id = $adoRecs->Fields->Item('id'); $id = $fld_id->Value;
				if (      SEQ($fv, 'GRS') ) $arrGRSID[] = $id;
				else if ( SEQ($fv, 'GRP') ) $arrGRPID[] = $id;
				else if ( SEQ($fv, 'BOIL') ) $arrBoilerID[] = $id;
				else if ( SEQ($fv, 'BOLT') ) $arrBoltID[] = $id;
				else if ( SEQ($fv, 'END') ) $arrEndID[] = $id;
				else if ( SEQ($fv, 'PART') || SEQ($fv, 'WHOLE') ) $arrPipeID[] = $id;
			}
		}
		echo '</row>';
		$adoRecs->MoveNext();
	} // end recordset

	$arrGRPID = array_unique($arrGRPID); $arrGRSID = array_unique($arrGRSID);
	$arrPipeID = array_unique($arrPipeID);
	$arrBoilerID = array_unique($arrBoilerID); $arrBoltID = array_unique($arrBoltID);
	$arrEndID = array_unique($arrEndID);
// сохраняем результат:
	$appParams['arrGRPID'] = $arrGRPID;
	$appParams['arrGRSID'] = $arrGRSID;
	$appParams['arrPipeID'] = $arrPipeID;
	$appParams['arrBoilerID'] = $arrBoilerID;
	$appParams['arrBoltID'] = $arrBoltID;
	$appParams['arrEndID'] = $arrEndID;
}; // getObjectsBySql



// ###############################################################################
// utils
// ###############################################################################


function outXmlTag ( $aTagName, $aTagValue) {
	echo '<' .$aTagName. '>' .$aTagValue. '</' .$aTagName. '>';
}; // outXmlTag

function SEQ ( $str1, $str2 ) {
	if ( strcasecmp ( (string)$str1, (string)$str2 ) == 0 )	return TRUE;
	return FALSE;
};

function utf8win1251($s){
	$out=""; $c1=""; $byte2=false;
	for ($c=0; $c < strlen($s); $c++){
		$i=ord($s[$c]);
		if ($i <= 127) $out .= $s[$c];
		if ($byte2){
			$new_c2 = ($c1 & 3) * 64 + ($i & 63);
			$new_c1 = ($c1 >> 2) & 5;
			$new_i = $new_c1 * 256 + $new_c2;
			if ($new_i == 1025) $out_i = 168;
			else if ($new_i == 1105) $out_i = 184;
			else $out_i = $new_i - 848;
			$out .= chr($out_i);
			$byte2 = false;
		}
		if ( ($i>>5)==6) {$c1=$i; $byte2 = true;}
	}
	return $out;
}; // function utf8win1251($s)

function safeStr($aStr) {
	return htmlspecialchars($aStr);
	//return htmlentities($aStr, ENT_COMPAT, 'cp1251');
};

//$adoRecs = adoExecQuery('select mogTopo.getLinkByPoint(' .$lon. ', ' .$lat. ') LINKID from dual');
function adoExecQuery($sql) {
	global $appParams;
	$adoCmd = $appParams['adoCmd'];
	$adoConn = $appParams['adoConn'];
	$adoRecs = $appParams['adoRecs'];

	$adoCmd->CommandText = $sql;
	if ($adoConn->State == 1) {
		if ($adoRecs->State == 1) $adoRecs->Close();
		$adoCmd->ActiveConnection = $adoConn;
		$adoRecs->Open($adoCmd);
	}
	echo '<DBG><qry>' . safeStr($adoCmd->CommandText) . '</qry><Recsstat>' . $adoRecs->State . '</Recsstat></DBG>';
	return $adoRecs;
}; // adoExecQuery

function adoInitLibrary() {
	global $appParams;
	$udlFileName = $appParams['udlFileName'];
// создаем обьекты ADODB
	$adoConn = new COM("ADODB.Connection") or die("Невозможно инициализировать ADO");
	$adoRecs = new COM("ADODB.Recordset") or die("Невозможно инициализировать ADO");
	$adoCmd = new COM("ADODB.Command") or die("Невозможно инициализировать ADO");
// открываем БД
	if ($adoConn->State != 1) $adoConn->Open('File Name=' . $udlFileName);
	echo '<DBG><connstat>' . $adoConn->State . '</connstat></DBG>';
	//$adoCmd->CommandType = 0x0001;
	//$adoRecs->CursorLocation = 3;
	$adoRecs->CursorLocation = 2;

	$appParams['adoCmd'] = $adoCmd;
	$appParams['adoConn'] = $adoConn;
	$appParams['adoRecs'] = $adoRecs;

	return $adoConn->State;
}; // adoInitLibrary

function testAdoAndOracle() {
	global $appParams;
	$udlFileName = $appParams['udlFileName'];
// создаем обьекты ADODB
	$adoConn = new COM("ADODB.Connection") or die("Невозможно инициализировать ADO");
	$adoRecs = new COM("ADODB.Recordset") or die("Невозможно инициализировать ADO");
	$adoCmd = new COM("ADODB.Command") or die("Невозможно инициализировать ADO");

// открываем БД
	if ($adoConn->State != 1) $adoConn->Open('File Name=' . $udlFileName);
	echo '<connstat>' . $adoConn->State . '</connstat>';
	//$adoCmd->CommandType = 0x0001;
	//$adoRecs->CursorLocation = 3;
	$adoRecs->CursorLocation = 2;

// выполняем запрос
	$adoCmd->CommandText = 'select * from dept';

	if ($adoConn->State == 1) {
		$adoCmd->ActiveConnection = $adoConn;
		echo '<DBG>' .$adoCmd->CommandText. '</DBG>';
		$adoRecs->Open($adoCmd);
	}
	echo '<Recsstat>' . $adoRecs->State . '</Recsstat>';

// перебираем строки выборки
	while ($adoRecs != null && $adoRecs->State == 1 && !$adoRecs->EOF) {
	// распечатываем данные строки
		echo'<row>';
		for ($i = 0; $i < $adoRecs->Fields->Count(); $i++) {
			$fld = $adoRecs->Fields->Item($i); $fn = (string)$fld->Name; $fv = (string)$fld->Value;
			echo'<' . $fn . '>' . $fv . '</' . $fn . '>';
		}
		echo'</row>';
		$adoRecs->MoveNext();
	}
}; // testAdoAndOracle

function testPersistentOracleConnection() {
// php.ini
// extension=php_oracle.dll
	$query = 'select * from dept';
	//$oraConn = ora_logon('scott@gisdb.vsrb', 'tiger');
	$oraConn = ora_plogon('scott@gisdb.vsrb', 'tiger');
	outXmlTag('oraConn', $oraConn);
	$oraCursor = ora_open($oraConn);
	outXmlTag('oraCursor', $oraCursor);
	if ($oraCursor != FALSE) {
		if (ora_parse ($oraCursor, $query) != FALSE) {
			outXmlTag('oraCursorParse', $oraCursor);
			if (ora_exec($oraCursor) != FALSE) {
				outXmlTag('oraExec', $oraCursor);
				while(ora_fetch($oraCursor)) {
					echo '<row>';
					$numfields = ora_numcols($oraCursor);
					for($col=0;$col<$numfields;$col++){
						outXmlTag(ora_columnname($oraCursor, $col), ora_getcolumn($oraCursor, $col));
					}
					echo '</row>';
				}
			}
		}
		ora_close($oraCursor);
//		ora_commit($oraConn);
	}
//	ora_logoff($oraConn);
}; // testPersistentOracleConnection

*/

?>
