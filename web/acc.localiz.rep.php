<?php

include 'globals.php';
include 'utils.inc.php';
include 'vdb.inc.php';

error_reporting(E_ALL);
ini_set('display_errors', false);
ini_set('html_errors', false);
ini_set('track_errors', true);
set_time_limit ( 1700 );

ob_start();

header("Content-Type: application/xml; charset=WINDOWS-1251");
header("Expires: " . gmdate("D, d M Y H:i:s", mktime()+70) . " GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
// HTTP/1.1
//header("Cache-Control: no-store, no-cache, must-revalidate");
//header("Cache-Control: post-check=0, pre-check=0", false);
// HTTP/1.0
//header("Pragma: no-cache");

OUT('<?xml version="1.0" encoding="WINDOWS-1251" ?>
<?xml-stylesheet type="text/xsl" href="acc.localiz.rep.xsl" ?>
<page>
	<id>acc.localiz.report</id>
	<title>Отчет. Локализация аварии - результаты расчетов</title>
<!-- вывод параметров запроса ($_REQUEST): -->');

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


///////////////////////////////////////////////////////////////////////////////
//
//	App: {
//
///////////////////////////////////////////////////////////////////////////////

class VApp {
	var $bStat; var $db; var $req; var $bDebug; var $sAction;
	var $sHowDone;
function VApp() {
	$this->bStat = false; $this->db = null; $this->req = array(); $this->bDebug = false; $this->sAction = 'init';
	$this->sHowDone = '';
}
function Init($args) {
	$this->bStat = false;
	foreach ($args as $key=>$value) { $this->req[$key] = trim($value); }

	global $glob_MOGSiteRoot;
	$connStrCdb = 'File Name=' . $glob_MOGSiteRoot . '\db\udl\cdb.udl';

	$db = new VDB2; if (false == $db->Open($connStrCdb)) {
		ERR('Невозможно открыть БД: ' . $connStrCdb); return false;
	}
	$this->db = $db;

	if ( SEQ(GFA($args, 'mode'), 'debug') ) {
		$this->bDebug = true;
	} else {
		$this->bDebug = false;
	}

	$this->sAction = GFA($args, 'action'); if ( isEmpty($this->sAction) ) $this->sAction = 'init';

	$this->bStat = true;
} // Init

function printReport() {
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
	return true;
} // printReport

function doWork() {
	if ( $this->bStat == false) {
		ERR('Ошибка инициализации. Обработка прервана.'); return false;
	}
//	$this->printCommonData();

	if ( SEQ($this->sAction, 'report') ) {
		$this->bStat = $this->printReport();
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
