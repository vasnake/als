<?xml version="1.0" encoding="WINDOWS-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="WINDOWS-1251" />
<xsl:template match="/">

<html lang="ru">
<head>
        <meta content="text/html; charset=windows-1251" http-equiv="content-type" />
        <meta content="�����" name="author" />
        <meta content="����� �� ������� ����������� ��������� (������) �� ������� ����" name="description" />

        <title><xsl:value-of select="/page/title" /></title>

        <link rel="stylesheet" type="text/css" href="/gismog/applications/css/main.css" />
        <script type="text/javascript" language="JavaScript" src="/gismog/applications/utils.js"></script>
        <script type="text/javascript" language="JavaScript" src="acc.localiz.rep.js"></script>

        <script language="JavaScript" type="text/JavaScript"
            src="/gismog/applications/carcasses/carcass_page/menu.js">
        </script>

        <script language="JavaScript" type="text/JavaScript"
            src="/gismog/applications/carcasses/carcass_page/page.js">
        </script>

    </head>
    <body onload="onAccLocalizPageLoad()" leftmargin="0" topmargin="0">
        <img style="height:20" src="/gismog/applications/spacer.gif" />
        <p class="Hd0">��ר�� � �������</p>
        <img style="height:20" src="/gismog/applications/spacer.gif" />

        <table width="546" style="margin-left:40; border:1px solid rgb(224, 224, 224); background-color:rgb(241, 241, 241)">
            <tr >
                <td width="226" align="left"><a href="js:Close Window" onclick="window.close(); return false;">�������</a></td>
                <td >	<a href="js:map" onclick="accLocalizRepShowMap(); return false;" target="_blank" title="������� ���� �����">�����</a></td>
                <td><a>|</a></td>
                <td><a href="js:Format Document For Print" onclick="JavaScript:formatForPrint(); return false;" title="������������� ��� ������">������ ��� ������</a></td>
                <td><a>|</a></td>
                <td><a href="js:Copy2Word" onclick="JavaScript:copy2Word(); return false;" title="���������� � MS Word">���������� � MS Word</a></td>
            </tr>
        </table>

        <img style="height:20" src="/gismog/applications/spacer.gif" />

<div style="display: none;">
<form target="_self"
    enctype="application/x-www-form-urlencoded"
    method="post"
    action="acc.localiz.php"
    name="formAccLocaliz"
    id="formAccLocaliz"
>
    <textarea name="taRep" id="taRep"><xsl:value-of select="/page/query/taRep" /></textarea>
    <input name="repType" id="repType" value="{/page/query/repType}" />
    <input name="action" id="repAction" value="report" />
</form>
</div>

        <div id="pageContent" style="margin-left: 40">

            <div class="aHead">
����� �� ����������� ������
                <xsl:value-of select="/page/App/currDate" />
            </div>

<br />
<div class="aHead" style="text-align: left;">
������� �������������� ����� ������:
</div>

<div class="tabHead" style="text-align: left;">
    <xsl:for-each select="/page/App/failedLinks/link">
    ��������: <xsl:value-of select="pipePress" />, �������: <xsl:value-of select="pipeDiam" /> ��,
    ����������: <xsl:value-of select="lon" /><xsl:text disable-output-escaping="yes">&amp;deg;�.�., </xsl:text>
    <xsl:value-of select="lat" /><xsl:text disable-output-escaping="yes">&amp;ordm;�.�.</xsl:text>
    <br />
    </xsl:for-each>
</div>
<br />

<div class="deptPane">
    <div class="aHead" style="text-align: left;">
    �������� ����������, ������������ ������
    </div>

<xsl:if test="/page/App/lockersBOLT/rowsCount != 0">
    <div class="tabHead" style="text-align: left;">
    �������� ���������� �� ������������:
    </div>
    <table style="width: 90%; text-align: center; vertical-align: middle; margin-left: auto; margin-right: auto;" border="1" cellpadding="2" cellspacing="0">
        <tr class="tabCaption">
            <td>�����</td>
            <td>������</td>
            <td>���</td>
            <td>��������������</td>
        </tr>
        <xsl:for-each select="/page/App/lockersBOLT/row">
            <tr>
                <td><xsl:value-of select="BoltID"/></td>
                <td><xsl:value-of select="DepartmentName"/></td>
                <td><xsl:value-of select="ServiceName"/></td>
                <td><xsl:value-of select="BoltAddress"/></td>

                <!-- td class="tdleft"><xsl:value-of select="DepName"/></td>
                <td class="tdright"><xsl:value-of select="NetLength"/></td -->
            </tr>
        </xsl:for-each>
    </table>
<br />
</xsl:if>

<xsl:if test="/page/App/lockersGRP/rowsCount != 0">
    <div class="tabHead" style="text-align: left;">
    �������� ���������� ������ ������������ �������:
    </div>
    <table style="width: 90%; text-align: center; vertical-align: middle; margin-left: auto; margin-right: auto;" border="1" cellpadding="2" cellspacing="0">
        <tr class="tabCaption">
            <td>���</td>
            <td>�����</td>
            <td>������</td>
            <td>���</td>
            <td>��������</td>
            <td>��������������</td>
            <td>������������</td>
            <td>������</td>
        </tr>
        <xsl:for-each select="/page/App/lockersGRP/row">
            <tr>
                <td><xsl:value-of select="GrpTypeName"/></td>
                <td><xsl:value-of select="GrpNumber"/></td>
                <td><xsl:value-of select="DepartmentName"/></td>
                <td><xsl:value-of select="ServiceName"/></td>
                <td><xsl:value-of select="GrpName"/></td>
                <td> <xsl:value-of select="GrpAddress"/> <xsl:if test="string-length(GrpAddress) &lt; 2">-</xsl:if> </td>
                <td><xsl:value-of select="GrpServiceProperty"/></td>
                <td><xsl:value-of select="GrpBalanceProperty"/></td>
            </tr>
        </xsl:for-each>
    </table>
<br />
</xsl:if>

</div> <!-- deptPane -->

<br />
<br />

<div class="deptPane">
    <div class="aHead" style="text-align: left;">
    �������� ����������� ������������
    </div>

<xsl:if test="/page/App/disconnBOIL/rowsCount != 0">
    <div class="tabHead" style="text-align: left;">
    ���������:
    </div>
    <table style="width: 90%; text-align: center; vertical-align: middle; margin-left: auto; margin-right: auto;" border="1" cellpadding="2" cellspacing="0">
        <tr class="tabCaption">
            <td>����� (ID)</td>
            <td>������</td>
            <td>���</td>
            <td>��������</td>
            <td>��������������</td>
            <td>������</td>
        </tr>
        <xsl:for-each select="/page/App/disconnBOIL/row">
            <tr>
                <td><xsl:value-of select="BoilerID"/></td>
                <td><xsl:value-of select="DepartmentName"/></td>
                <td><xsl:value-of select="ServiceName"/></td>
                <td><xsl:value-of select="BoilerName"/></td>
                <td><xsl:value-of select="BoilerAddress"/></td>
                <td><xsl:value-of select="GasObjPropertyName"/></td>
            </tr>
        </xsl:for-each>
    </table>
<br />
</xsl:if>

<xsl:if test="/page/App/disconnGRP/rowsCount != 0">
    <div class="tabHead" style="text-align: left;">
    ������������ ������:
    </div>
    <table style="width: 90%; text-align: center; vertical-align: middle; margin-left: auto; margin-right: auto;" border="1" cellpadding="2" cellspacing="0">
        <tr class="tabCaption">
            <td>���</td>
            <td>�����</td>
            <td>������</td>
            <td>���</td>
            <td>��������</td>
            <td>��������������</td>
            <td>������������</td>
            <td>������</td>
        </tr>
        <xsl:for-each select="/page/App/disconnGRP/row">
            <tr>
                <td><xsl:value-of select="GrpTypeName"/></td>
                <td><xsl:value-of select="GrpNumber"/></td>
                <td><xsl:value-of select="DepartmentName"/></td>
                <td><xsl:value-of select="ServiceName"/></td>
                <td><xsl:value-of select="GrpName"/></td>
                <td> <xsl:value-of select="GrpAddress"/> <xsl:if test="string-length(GrpAddress) &lt; 2">-</xsl:if> </td>
                <td><xsl:value-of select="GrpServiceProperty"/></td>
                <td><xsl:value-of select="GrpBalanceProperty"/></td>
            </tr>
        </xsl:for-each>
    </table>
<br />
</xsl:if>

</div> <!-- deptPane -->

<br />

        </div> <!-- pageContent -->

        <img style="height:20" src="/gismog/applications/spacer.gif" />

</body>
</html>

</xsl:template>
</xsl:stylesheet>
