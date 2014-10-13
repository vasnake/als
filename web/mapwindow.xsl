<?xml version="1.0" encoding="WINDOWS-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="WINDOWS-1251" />
<xsl:template match="/">

<html lang="ru">
<head>
        <title>
            <xsl:value-of select="page/TITLE" />
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
        <link rel="stylesheet" href="/gismog/applications/css/main.css" type="text/css" />
        <style type="text/css">
            a { color: #FFFFFF; text-decoration : underline; }
            a:hover {  color: #3151EF}
        </style>
        <script language="JavaScript" type="text/JavaScript"
            src="/gismog/applications/carcasses/carcass_map/dhtml.js">
        </script>
        <script language="JavaScript" type="text/JavaScript"
            src="/gismog/applications/carcasses/carcass_map/maptoolbar.js">
        </script>
        <xsl:if test="contains(/page/appsList,'settlRedline')">
            <script language="JavaScript" type="text/JavaScript"
                src="/gismog/applications/carcasses/carcass_map/settlRedline/settl.rl.mapwindow.js">
            </script>
        </xsl:if>

<!-- локализация аварий на сети, скрипты, стили для формы { -->
<xsl:if test="contains(/page/appsList,'accidentLocalization')">
    <link rel="stylesheet" href="acc.localiz.css" type="text/css" />
    <script language="JavaScript" type="text/JavaScript"
        src="acc.localiz.js">
    </script>
</xsl:if>
<!-- локализация аварий на сети, скрипты, стили для формы } -->

</head>
<body bgcolor="#558ab6" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0"
    onload="onBodyLoad(); acclocObj.onHtmlBodyLoad();">

<xsl:if test="contains(/page/showDebugWnd,'yes')">
    <!-- Debug messages window: -->
    <div id="divDebug" style="display: block; color:#ffffff; background:#bbbbbb;">
    <form id="frmDebug">
        <textarea id="taDbg" rows="7" readonly="readonly" wrap="nowrap" style="width: 790px"></textarea>
    </form></div>
</xsl:if>

<!-- page error processing: -->
<xsl:if test="contains(/page/applicationError,' ')">
    <div id="divErrorContainer"
        style="width:800px; height:100px; z-index:1; background-color: #FF9999; layer-background-color: #FF9999; border: 1px none #000000; visibility: visible;">
    <table width="90%"  border="0" cellspacing="1" cellpadding="3">
    <tr> <td>
    <xsl:value-of select="/page/applicationError" />
    </td> </tr>
    <tr> <td>
        <form name="frmError" id="frmError" method="post" action="">
        <textarea name="errTextarea" wrap="VIRTUAL" rows="7" style="width: 700px">
    <xsl:for-each select="/page/ERROR">
    <xsl:value-of select="." />
    </xsl:for-each>
        </textarea>
        <br />
        <input name="btnErrBack" type="button" id="btnErrBack" onclick="history.back();" value="Вернуться &lt;" />
        </form>
    </td> </tr>
    </table>
    </div>
</xsl:if>

<div id="Layer1" style="left:0px; top:0px; width:800px; height:600px; z-index:1; visibility:visible">
<!--#include virtual="../../applications/carcasses/carcass_map/mapToolbar.inc.html" -->
        <object id="map" width="800" height="580"
            align="top"
            classid="CLSID:62789780-B744-11D0-986B-00609731A21D"
            codebase="/files/mgaxctrl.cab#Version=6,5,5,7"
        >
        <param name="ToolBar" value="Off" />

        <xsl:if test="not(contains(/page/applicationError,' '))">
            <param name="URL" value="{/page/MAP}" />
        </xsl:if>

        <xsl:if test="string-length(/page/MapCenterLat) &gt; 2">
            <!-- xsl:if test="string-length(/page/MapCenterLat) > 2" -->
            <!-- Scale, or Width + Units -->
            <param name="Lat" value="{translate(/page/MapCenterLat, ',', '.')}" />
            <param name="Lon" value="{translate(/page/MapCenterLon, ',', '.')}" />
            <param name="MapScale" value="{translate(/page/MapScale, ',', '.')}" />
        </xsl:if>
<!--
    <param name="StatusBar" value="On" />
    <param name="URL" value="MO_vys_sred_settl.mwf" />
    <param name="Lat" value="55.702857" />
    <param name="Lon" value="36.186178" />
    <param name="MapScale" value="30000" />
    <param name="MapWidth" value="4.1" />
    <param name="Units" value="KM" />
    <param name="ToolBar" value="On" />
    <param name="LayersViewWidth" value="150" />
    <param name="Selobjs" value="LayerName,37,73,55" />
    <param name="DefaultTarget" value="_new" />
    <param name="ObjectLinkTarget" value="_new" />
    <param name="ReportTarget" value="_new" />
    <param name="ErrorTarget" value="_new" />
    <param name="URLList" value="Off" />
    <param name="URLListTarget" value="_new" />
    <param name="AutoLinkLayers" value="LayerName" />
    <param name="AutoLinkTarget" value="_new" />
    <param name="AutoLinkDelay" value="20" />
-->
        </object> <!-- map -->
</div> <!-- Layer1 -->

        <map name="Image1Map" id="Image1Map">
            <area shape="circle" coords="176,22,9" onClick="openHelpWindow('/gismog/applications/help/help.html#searchsettl')" />
            <area shape="poly" coords="0,0,182,0,178,9,164,15,164,31,0,31" onclick="switchFrame('wndSearchSettl');" />
        </map>

        <map name="Image2Map" id="Image2Map">
            <area shape="circle" coords="176,22,9" onClick="openHelpWindow('/gismog/applications/help/help.html#accreg')" />
            <area shape="poly" coords="0,0,182,0,178,9,164,15,164,31,0,31" onclick="switchFrame('wndRedlineControls');" />
        </map>

        <map name="imGazAttr" id="imGazAttr">
            <area shape="circle" coords="176,22,9" onClick="openHelpWindow('/gismog/applications/help/help.html#gazattr')" />
            <area shape="poly" coords="0,0,182,0,178,9,164,15,164,31,0,31" onclick="switchFrame('wndGazAttr');" />
        </map>

        <map name="imSS100K" id="imSS100K"> <!-- SettlementsSearch100KAtlas -->
            <area shape="circle" coords="176,22,9" onClick="openHelpWindow('/gismog/applications/help/help.html#searchsettl100K')" />
            <area shape="poly" coords="0,0,182,0,178,9,164,15,164,31,0,31" onclick="switchFrame('wndSS100K');" />
        </map>

        <map name="Image4Map" id="Image4Map">
            <area shape="circle" coords="176,22,9" onClick="openHelpWindow('/gismog/applications/help/help.html#gpplanning')" />
            <area shape="poly" coords="0,0,182,0,178,9,164,15,164,31,0,31" onclick="switchFrame('wndRedlineControls');" />
        </map>

        <map name="mapBoilers" id="mapBoilers">
            <area shape="circle" coords="176,22,9" onClick="openHelpWindow('/gismog/applications/help/help.html#boilers')" />
            <area shape="poly" coords="0,0,182,0,178,9,164,15,164,31,0,31" onclick="switchFrame('wndBoiler');" />
        </map>

        <map name="mapRLSettl" id="mapRLSettl">
            <area shape="circle" coords="176,22,9" onClick="openHelpWindow('/gismog/applications/help/help.html#RLSettl')" />
            <area shape="poly" coords="0,0,182,0,178,9,164,15,164,31,0,31" onclick="switchFrame('wndRLSettl');" />
        </map>

<div id="lyrRightVertStripe"
    style="position:absolute; left:803px; top:0px; width:190px; height:600px; z-index:2; background-color: #6897be; layer-background-color: #6897be; border: 1px none #000000"
    class="hdr3"
>

        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top"><a href="/gismog/" style="font-family: Verdana; font-size: 10px;">Начало</a></td>
                <td><h5 align="right" style="color: #FF0000;">Для служебного пользования</h5></td>
            </tr>
        </table>

<div style="margin: 0px 0px 7px; padding: 0px; display: block;">
        <xsl:if test="string-length(/page/HEAD) &gt; 2">
            <xsl:value-of select="/page/HEAD" />
        </xsl:if>
        <xsl:if test="string-length(/page/HEAD) &lt; 2">
            <xsl:value-of select="/page/TITLE" />
        </xsl:if>
</div>

        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#999999" bgcolor="#7aa4c6">
<!-- кнопки вызова функций карты: -->
            <tr>
                <td>
<!--#include virtual="../../applications/carcasses/carcass_map/copyMap2Word.php?${QUERY_STRING}" -->
                    <button id="btnMapDistance" title="Измерить расстояние на карте (ALT-E)" accesskey="e" onclick="getDistanceOnMap()" style="background:#ffffff;">
                        <img src="/gismog/applications/carcasses/carcass_map/picture/distance3.png" />
                    </button>
                    <button id="btnSearch" title="Поиск (ALT-F)" accesskey="f" onclick="onClickSearchButton()" style="background:#ffffff;">
                        <img src="/gismog/applications/carcasses/carcass_map/picture/search.png" />
                    </button>

                    <xsl:if test="contains(/page/appsList,'settlRedline')">
                        <br />
                        <button id="btnRedlineSettl"
                            title="Нас. пункты. Актуализация (ALT-H)"
                            accesskey="h"
                            onclick="onClickRedlineSettlButton()"
                            style="background:#ffffff; height: 30px; width: 41px">
                            <img src="/gismog/applications/carcasses/carcass_map/picture/settl.rl.png" />
                        </button>
                    </xsl:if>
                </td>
            </tr>
            <tr>
                <td bgcolor="#6897be"><span style="color:6897be; font-size: 3px; line-height: 3px;">placer</span></td>
            </tr>

        <xsl:if test="contains(/page/appsList,'objRedline')">
<!-- redline gp planning: -->
            <tr>
                <td onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','/gismog/applications/carcasses/carcass_map/picture/plan2.png',1)">
                    <div id="divGPPlanning" style="cursor:pointer;" class="rlink1">
                        <img src="/gismog/applications/carcasses/carcass_map/picture/plan1.png" alt="газопроводы" name="Image4" width="185" height="31"
                            border="0" usemap="#Image4Map" id="Image4" />
                    </div>
                    <iframe src="/gismog/applications/carcasses/carcass_map/objRedline/gasif.tubeframe.php?sAction=start" frameborder="0" scrolling="no" align="left"
                        name="wndRedlineControls" style=" width:200px; height:450px; display:none;" hspace="0" vspace="0" marginheight="0" marginwidth="0"
                        id="wndRedlineControls">Map redline controls:<br/>
                    </iframe>
                </td>
            </tr>

            <tr>
                <td bgcolor="#6897be"><span style="color:6897be; font-size: 3px; line-height: 3px;">placer</span></td>
            </tr>
<!-- redline boilers: -->
            <tr>
                <td onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('imgBoilersTab','','/gismog/applications/carcasses/carcass_map/picture/boilers2.png',1)">
                    <div id="divBoilers" style="cursor:pointer;" class="rlink1">
                        <img src="/gismog/applications/carcasses/carcass_map/picture/boilers1.png" alt="Котельные" id="imgBoilersTab" name="imgBoilersTab"
                            width="185" height="31" border="0" usemap="#mapBoilers" />
                    </div>
                    <iframe src="/gismog/applications/carcasses/carcass_map/objRedline/gasif.boilerframe.xml?sAction=start" id="wndBoiler" name="wndBoiler" frameborder="0"
                        scrolling="no" align="left" style=" width:200px; height:320px; display:none;" hspace="0" vspace="0" marginheight="0" marginwidth="0">RedLine Boilers
                    </iframe>
                </td>
            </tr>

            <tr>
                <td bgcolor="#6897be"><span style="color:6897be; font-size: 3px; line-height: 3px;">placer</span></td>
            </tr>
<!-- redline settlements: -->
            <tr>
                <td onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('imgRLSettlTab','','/gismog/applications/carcasses/carcass_map/picture/ogasif2.png',1)">
                    <div id="divRLSettl" style="cursor:pointer;" class="rlink1">
                        <img src="/gismog/applications/carcasses/carcass_map/picture/ogasif1.png" alt="Нас. пункты" id="imgRLSettlTab"
                            name="imgRLSettlTab" width="185" height="31" border="0" usemap="#mapRLSettl" />
                    </div>
                    <iframe src="/gismog/applications/carcasses/carcass_map/objRedline/gasif.settlframe.xml?sAction=start" id="wndRLSettl" name="wndRLSettl" frameborder="0"
                        scrolling="no" align="left" style=" width:200px; height:400px; display:none;" hspace="0" vspace="0" marginheight="0" marginwidth="0">RedLine Settlements
                    </iframe>
                </td>
            </tr>

            <tr>
                <td bgcolor="#6897be"><span style="color:6897be; font-size: 3px; line-height: 3px;">placer</span></td>
            </tr>
        </xsl:if>

<!-- redline accidents: -->
        <xsl:if test="contains(/page/appsList,'accidentsRedline')">
            <tr>
                <td onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image2','','/gismog/applications/carcasses/carcass_map/picture/acc2.png',1)">
                    <div id="divAccReg" style="cursor:pointer;" class="rlink1">
                        <img src="/gismog/applications/carcasses/carcass_map/picture/acc1.png" alt="регистрация аварий" name="Image2"
                            width="185" height="31" border="0" usemap="#Image2Map" id="Image2" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <iframe src="/gismog/applications/carcasses/carcass_map/accidentsRedline/rl-accident.php?sAction=start"
                        frameborder="0" scrolling="no" align="left" name="wndRedlineControls" style=" width:200px; height:500px; display:none;"
                        hspace="0" vspace="0" marginheight="0" marginwidth="0" id="wndRedlineControls">Map redline controls:<br/>
                    </iframe>
                </td>
            </tr>
            <tr>
                <td bgcolor="#6897be"><span style="color:6897be; font-size: 3px; line-height: 3px;">placer</span></td>
            </tr>
        </xsl:if>


<!-- локализация аварий { -->
<xsl:if test="contains(/page/appsList,'accidentLocalization')">
            <tr><td>

<table
    class="accloc"
    style="width: 180px;"
    border="0" cellpadding="0" cellspacing="0"
> <tbody>

<tr> <td class="localizHead">
<div id="divWaitServer" class="divWaitServer"> подождите ... </div>
<div style="float: left;">Локализация</div>
<a href="js:Help" class="help"
    onclick="openHelpWindow('/gismog/applications/help/help.html#acclocaliz'); return false;"
    title="справка по использованию приложения"
></a>
</td> </tr>

<tr> <td style="white-space: nowrap; ">

<form  class="accloc"
    style="width: 180px;"
    target="accLocalizRep"
    enctype="application/x-www-form-urlencoded"
    method="post"
    action="acc.localiz.php"
    name="formAccLocaliz"
    id="formAccLocaliz"
>
<div style="display: none;">
    <textarea name="taRep" id="taRep"></textarea>
    <input name="repType" id="repType" value="LockersAndDisconn" />
    <input name="action" id="repAction" value="report" />
</div>

<fieldset style="padding: 3px 2px;">

<legend style="caption-side: left;">Параметры расчёта
</legend>
<!-- div id="divWaitServer" class="divWaitServer"> загрузка... </div -->

<input class="accloc"
    tabindex="1" name="btnPickPoint"
    value="Указать место аварии &gt;&gt;" type="button"
    onclick="acclocObj.onPickPointButton()"
    title="укажите на карте местоположение инцидента"
/>

<div style="font-weight: bold;">Поврежденные участки:</div>

<textarea class="accloc"
    readonly="readonly" tabindex="2" wrap="virtual" rows="3"
    name="txtarFailLinks" id="txtarFailLinks"
>
Высокое 1 кат., d=200; x=37.123456, y=56.123456
Высокое 2 кат., d=200; x=37.123456, y=56.123456
</textarea>
<br />

<input class="accloc halfsize"
    tabindex="3" name="btnGoLocaliz"
    value="Локализовать" type="button"
    onclick="acclocObj.onLocalizButton()"
    title="выполнить расчеты для определения запорных устройств и отключенных потребителей"
/>
<input class="accloc halfsize"
    tabindex="4" name="btnResetApp"
    value="Очистить" type="button"
    onclick="acclocObj.onResetButton()"
    title="сбросить все параметры и начать с начала"
/>

<br />
<label>
    <input checked="checked" tabindex="5"
        name="chkboxZoomAndPan" id="chkboxZoomAndPan"
        value="checked" type="checkbox"
        onclick="acclocObj.onZoomCheckbox()"
        title="выполнить кадрирование карты по результатам расчета"
    />Кадрировать
</label>

</fieldset>

<fieldset style="padding: 3px 2px;">

<legend style="caption-side: left; font-weight: bold;">Результаты расчёта
</legend>

<textarea class="accloc"
    readonly="readonly" tabindex="2" wrap="virtual" rows="2"
    name="txtarResults" id="txtarResults"
>
Запорных устройств - 7
Потребителей - 5
</textarea>
<br />
<input class="accloc halfsize"
    style="float: right;" tabindex="7" name="btnReport"
    value="Отчёт..." type="button"
    onclick="acclocObj.onOpenReportButton()"
    title="вывести отчет в отдельном окне"
/>

</fieldset>

</form>

</td></tr></tbody>
</table>

            </td></tr>
</xsl:if>
<!-- локализация аварий } -->


<!-- Просмотр атрибутики по газовому хозяйству: -->
        <xsl:if test="contains(/page/appsList,'gazObjAttribs')">
            <tr>
                <td onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('imgGazAttr','','/gismog/applications/carcasses/carcass_map/picture/gazattr2.png',1)">
                    <div id="divGazAttr" style="cursor:pointer;" class="rlink1">
                        <img src="/gismog/applications/carcasses/carcass_map/picture/gazattr1.png" alt="атрибуты обьектов ГХ" name="imgGazAttr"
                            id="imgGazAttr" width="185" height="31" border="0" usemap="#imGazAttr" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <iframe src="/gismog/applications/carcasses/carcass_map/gazObjAttribs/attribs.xml" name="wndGazAttr" id="wndGazAttr" frameborder="0"
                        scrolling="no" align="left" style=" width:185px; height:300px; display:none;" hspace="1" vspace="1" marginheight="1"
                        marginwidth="1">Атрибуты обьектов ГХ<br/>
                    </iframe>
                </td>
            </tr>
            <tr>
                <td bgcolor="#6897be"><span style="color:6897be; font-size: 3px; line-height: 3px;">placer</span></td>
            </tr>
        </xsl:if>

<!-- resource comments: -->
            <tr>
                <td>
                    <div id="lyrRightLinks" style="width:179px; height:30px; z-index:4; overflow: hidden">
                        <table width="100%" border="0" cellspacing="3" cellpadding="3" bordercolor="#999999" bgcolor="#7aa4c6">
                            <tr>
                                <td align="center" valign="middle" >
                                    <a href="/gismog/applications/carcasses/carcass_map/comments.php?tfResourceID={page/MAP}" target="_blank"
                                         onclick="wndComm=window.open('/gismog/applications/carcasses/carcass_map/comments.php?tfResourceID={page/MAP}', 'comments',
                                         'channelmode=no,directories=no,fullscreen=no,height=350,left=20,location=no,menubar=no,resizable=no,scrollbars,status=no,titlebar,toolbar=no,top=20,width=500');
                                         wndComm.focus(); return false;">Комментарии к странице...</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>

</div> <!-- lyrRightVertStripe -->

        <div id="lyrBottSpace" style="position:absolute; left:13px; top:622px; width:887px; height:182px; z-index:3" class="formtxt">
            <form name="frmMapSize" method="post" action="">
                <b>Установка размера окна карты под разрешение экрана (Шир. Х Выс.): </b><br />
                <input type="radio" id="rg1024" name="rgMapSize" value="1024" checked="checked" onclick="selectFixedMapSize()" />
                <label for="rg1024"> 1024x768 </label><br />
                <input type="radio" id="rg1280" name="rgMapSize" value="1280" onclick="selectFixedMapSize()" />
                <label for="rg1280"> 1280x1024 </label><br/>
                <input type="text" name="tfWidth" value="800"/>   X
                <input type="text" name="tfHeight" value="570"/>
                <input type="button" name="Button" value="Установить" onclick="mapSize()"/>
            </form><br/>
        </div>

<!--
    App scripts {
-->

        <xsl:if test="not(contains(/page/appsList,'accidentsRedline')) and not(contains(/page/appsList,'objRedline'))">
<!-- раньше было include virtual -->
            <script language="JavaScript" type="text/JavaScript"
                src="/gismog/applications/carcasses/carcass_map/mapwindow.js">
            </script>
        </xsl:if>

        <xsl:if test="contains(/page/appsList,'accidentsRedline')">
<!-- раньше было include virtual -->
            <script language="JavaScript" type="text/JavaScript"
                src="/gismog/applications/carcasses/carcass_map/accidentsRedline/accidents_rl_VS.js">
            </script>
        </xsl:if>

        <xsl:if test="contains(/page/appsList,'objRedline')">
            <div id="divSystemForm" style="display: none; ">
                <form name="frmSystemForm" method="get" action="">
                    <input name="sfWndName" id="sfWndName" type="hidden" value="" />
                    <input name="sfFrmName" id="sfFrmName" type="hidden" value="" />
                </form>
            </div>
<!-- раньше было include virtual -->
            <script language="JavaScript" type="text/JavaScript"
                src="/gismog/applications/carcasses/carcass_map/objRedline/gp-planning.js">
            </script>
        </xsl:if>

<!--
    App scripts }
-->
    </body>

</html>

</xsl:template>
</xsl:stylesheet>
