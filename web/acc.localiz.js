// # -*- coding: cp1251 -*-
// # (c) Valik mailto:vasnake@gmail.com

/*
���������� "����������� ������ �� ���� �������� ��������� ���"
AJAX
*/

function namespaceAccLoc () {

/*
���������� ����������:
*/
this.app = null;
this.timerFormUpdate = null;

this.msgWait4Server = '���������� ��������� ��������� �������� �������. \n ���������.';

function getApp() {
    return acclocObj.app;
}


/*
###############################################################################
    ��������� ������� ���� {
###############################################################################
*/

/*
������� ��������: �������� �����������, ������������� ����������
������� ������ ���
������� ������ �������
*/
this.onHtmlBodyLoad = function() {
DBG('onHtmlBodyLoad \n');
    var o = acclocObj;
    o.app = new VApp();
    o.timerFormUpdate = window.setInterval(o.onTimerUpdateForm, 500);
} // onHtmlBodyLoad


/*
������� ������� ����������: ��������� ��������� ����������
    ����������������������� (� ���������� �������� ������ ����� ������):
    this.haveFailedLinks = false;
    ��������������� (� ���������� �������� ������ �������� ��������� � ����. ������������):
    this.haveDisconn = false;
    ����������������� (���� ����������� �� �������, ����):
    this.waitServer = false;
    ����������� (���� � ������ ����� �����������������):
    this.haveMap = false;
    ������������������������� (����� ��������� ���� ����� ������� �� ����� ������):
    this.dataParsedFL = false;
    ������������������������� (����� ��������� ���� ����� ������� �� ����. ������������):
    this.dataParsedDC = false;
*/
this.onTimerUpdateForm = function() {
    var o = acclocObj; var a = getApp();

    if (o.app.state.haveFailedLinks == false) {
        // clear textarea failedlinks
        var ta = document.getElementById('txtarFailLinks');
        if (ta != null) ta.value='';
    }

    if (o.app.state.haveDisconn == false) {
        // clear textarea results
        var ta = document.getElementById('txtarResults');
        if (ta != null) ta.value='';
    }

    // set busy flag
    if (o.app.state.waitServer == false) {
        setElemVisibility('divWaitServer', 'none');
    } else {
        setElemVisibility('divWaitServer', 'block');
    }

    // reinit map
    if (o.app.state.haveMap == false) {
        o.app.setMapObject(getMap());
    }

    // fill form field
    if (o.app.state.dataParsedFL != false) {
        o.app.state.setdataParsedFL(false);
        var txt = o.app.getFailedLinksText();
        var ta = document.getElementById('txtarFailLinks');
        if (ta != null) ta.value=txt;

        // �������� ��������� ���� �� �����:
        DBG('onTimerUpdateForm: make select flink... \n');
        {
            sLastError = '';
            var map = getMap();
            var ln = 'Links ora';
            var act = 'add';
            for (var i = 0; i < a.arrFailedLinks.length; i++) {
                var key = a.arrFailedLinks[i].linkID;
                if (mapAddToSelected(map, ln, key, act) == false) break;
            }
            DBG('onTimerUpdateForm: lastError: ['+sLastError+'] \n');
        }
    } // parsed failed link data

    // fill form field
    if (o.app.state.dataParsedDC != false) {
        if (a.state.needZoom != false && a.state.waitMap == false) {
            // zoom
            a.state.setwaitMap(true);
            DBG('onTimerUpdateForm: make ZoomPan... \n');
            zoomMapByBox(a.map, a.mbr.minx, a.mbr.maxy, a.mbr.maxx, a.mbr.miny, 1.2);
        } // zoom

        if (a.state.waitMap == false || (a.state.waitMap != false && a.map.isBusy() == false) ) {
            // highligth/select
            DBG('onTimerUpdateForm: make Select... \n');
            a.state.setwaitMap(false);
            o.app.state.setdataParsedDC(false);
            var txt = o.app.getCalcResultText();
            var ta = document.getElementById('txtarResults');
            if (ta != null) ta.value=txt;

            // ���������� � �����������, �������� ����� � ����:
            {
                sLastError = ''; // select
                var msel = a.map.getSelection(); msel.clear();
                var ln = 'Links ora'; // oraNODES
                var act = 'add';
                for (var i = 0; i < a.arrLockers.length; i++) {
                    var to = a.arrLockers[i];
                    if (to.isLink()) ln = 'Links ora';
                    else ln = 'oraNODES';
                    if (mapAddToSelected(a.map, ln, to.id, act) == false) {
                        window.status = '�� �������� ��������� ������� �� ���������';
                    };
                }
                for (var i = 0; i < a.arrDisconn.length; i++) {
                    var to = a.arrDisconn[i];
                    if (to.isLink()) ln = 'Links ora';
                    else ln = 'oraNODES';
                    if (mapAddToSelected(a.map, ln, to.id, act) == false) {
                        window.status = '�� �������� ��������� ������� �� ���������';
                    };
                }
                DBG('onTimerUpdateForm: lastError: ['+sLastError+'] \n');
            } // select

        } // map is free after zoom
    } // parsed disconnected

    o.app.state.changed = false;
} // onTimerUpdateForm


/*
������� �����: ������ ������ "������� �����"
������� ����� �� �����
*/
this.onPickPointButton = function() {
    DBG('onPickPointButton \n');
    var o = acclocObj;
    var map = o.app.map;
    if (map == null || map.isBusy()) {
        alert("����� ����������, ���������� �����.");
        return;
    }
    // ������������� ���������� ������� ��� ����� (���������� �� ��� ������������� ���� �� mapwindow.js ):
    onDigitizedPoint = o.onMapDigitizedPoint;
    map.digitizePoint();
} // onPickPointButton


/*
������� �����: ������������ ������ ����� �� �����
��������� ������ �� ������.
���������� ���������� ������� �����������
�������� ��������� ������������� �������
������� � ���� ����� ������
*/
this.onMapDigitizedPoint = function (map, point) {
    DBG('onMapDigitizedPoint \n');
    var o = acclocObj; var a = getApp();
    if (o.app.state.waitServer != false) {
        alert('���������� ��������� ��������� �������� �������. \n ���������.');
        return;
    }

    var latVal = point.getY(); var lonVal = point.getX();
    a.rll.addPoint(map, point, ''+lonVal+';'+latVal+'',  ''+lonVal+';'+latVal+'', '');
    // ��� ����� �� ������ ���������� ������.
    // ��� ����� ������� ����� ������� ����������� �����, � �� ��������� ������:
    o.app.state.sethaveDisconn(false);
    a.resetLockersAndDisconn();
    o.app.findLinkByPoint(lonVal, latVal);
} // onMapDigitizedPoint


/*
������� �����: ������ ������ "������������"
���� �� ������� ����� (��� ����� ������), ��������� � �����
��������� ������ �������� ��������� � ����. ������������ (�� �������
�� ����������� ������� ���������� (����������), ����������� �����, �������� �������
*/
this.onLocalizButton = function() {
    DBG('onLocalizButton \n');
    var o = acclocObj; var a = getApp();
    if (a == null || a.state == null) alert('so bad 2');

    if (a.state.haveFailedLinks == false) {
        alert('������� ����� ���������� ������������ �������.'); return;
    }
    if (a.state.waitServer != false) {
        alert('���������� ��������� ��������� �������� �������. \n ���������.'); return;
    }
    a.findLockersAndDisconn();
} // onLocalizButton


/*
������� �����: ������ ������ "��������"
�������� � ���� ��� �������
*/
this.onResetButton = function() {
    DBG('onResetButton \n');
    var o = acclocObj;  var a = getApp();
    a.resetFailedLinks();
    a.resetLockersAndDisconn();
    a.resetSrvConn();
    var msel = a.map.getSelection(); msel.clear();
    a.rll.clearLayer();
} // onResetButton


/*
������� �����: ������������� "�����������"
*/
this.onZoomCheckbox = function() {
    DBG('onZoomCheckbox \n');
    var o = acclocObj;  var a = getApp();
    var cb = document.getElementById('chkboxZoomAndPan');
    if (cb != null) {
        if (cb.checked == false) {
            DBG('onZoomCheckbox: turn OFF zoom & pan \n');
            a.state.setneedZoom(false);
        } else {
            DBG('onZoomCheckbox: turn ON zoom & pan \n');
            a.state.setneedZoom(true);
        }
    }
    else {
        DBG('onZoomCheckbox: widget is null ! \n');
    }
} // onZoomCheckbox


/*
������� �����: ������ ������ "�����"
���� �� ������� �����, ��������� � �����
������� ���� � �������
*/
this.onOpenReportButton = function() {
    DBG('onOpenReportButton \n');
    var o = acclocObj;  var a = getApp();
    if (a.state.haveDisconn == false) {
        alert('������� ����� ���������� �������� ���������� � ����������� ������������ (������ "������������").');
        return;
    }
    if (a.state.waitServer != false) {
        alert('���������� ��������� ��������� �������� �������. \n ���������.');
        return;
    }

    var frm = document.getElementById('formAccLocaliz');
    if (frm == null) return;

    frm.taRep.value = a.getLockersAndDisconn4Rep();
    DBG('onOpenReportButton: repInput: ['+frm.taRep.value+'] \n');
    frm.submit();
} // onOpenReportButton


/*
������� ����: ������ ������ ������
*/
this.onAjaxResponse = function() {
    DBG('onAjaxResponse \n');
    var o = acclocObj;  var a = getApp();
    var xmlhttp = a.getXmlHttpReqObj();
    var respProcessor = a.getXmlRespProcessor();

    DBG('onAjaxResponse:xmlhttp.readyState: ['+xmlhttp.readyState+'] \n');
    if (xmlhttp.readyState == 4) {
        // completed:
        DBG('onAjaxResponse:xmlhttp.status: ['+xmlhttp.status+'] \n');
        if (xmlhttp.status == 200) {
            // http succes:
            DBG('onAjaxResponse:xmlhttp.responseText: ['+xmlhttp.responseText+'] \n');
            try { respProcessor(xmlhttp.responseXML); }
            catch(err) { alert('onAjaxResponse: ���� ��������� XML.'); }
        } // end on done (200)
        else { // http err:
            // http fail:
            DBG('\nonAjaxResponse:xmlhttp.responseText: ['+xmlhttp.responseText+'] \n');
            DBG('\nonAjaxResponse:xmlhttp.statusText: ['+xmlhttp.statusText+'] \n');
            alert(
                '���� ��������� ������� AJAX (http status: ' +
                xmlhttp.status +
                '). \n ������������: \n ������� CTRL-R');
        } // end http err
        o.app.state.setwaitServer(false);
    } // end on completed (4)
} // onAjaxResponse

/*
###############################################################################
    ��������� ������� ���� }
###############################################################################
*/


/*
###############################################################################
    ������ �������� ���������� {
###############################################################################
*/

///////////////////////////////////////////////////////////////////////////////
//
//	class VState
//
///////////////////////////////////////////////////////////////////////////////
function VState() {
    DBG('VState constructor \n');
    // ��������� ����������:

    //	��������� ���� ��������:
    this.changed = true;

    //	����������������������� (� ���������� �������� ������ ����� ������):
    this.haveFailedLinks = false;

    //	��������������� (� ���������� �������� ������ �������� ��������� � ����. ������������):
    this.haveDisconn = false;

    //	����������������� (���� ����������� �� �������, ����):
    this.waitServer = false;

    //	����������� (���� � ������ ����� �����������������):
    this.haveMap = false;

    //	������������������������� (����� ��������� ���� ����� ������� �� ����� ������):
    this.dataParsedFL = false;

    //	������������������������� (����� ��������� ���� ����� ������� �� ����. ������������):
    this.dataParsedDC = false;

    //	��������� ����������� ����� ����� ��������� ������� ����������� � ��������:
    this.needZoom = true;

    //	� �������� ��������� ��������� ����� � ���� ��������� ���� isBusy() == false:
    this.waitMap = false;

    this.sethaveFailedLinks = function(val) {
        this.changed = true;
        if (val == false) {
            this.haveDisconn = false;
        } else { ; }
        this.haveFailedLinks = val;
        return this.haveFailedLinks;
    }

    this.sethaveDisconn = function(val) {
        this.haveDisconn = val;
        return this.haveDisconn;
    }

    this.setwaitServer = function(val) {
        DBG('state.setwaitServer: ['+val+'] \n');
        this.waitServer = val;
        return this.waitServer;
    }

    this.sethaveMap = function(val) {
        DBG('state.sethaveMap: ['+val+'] \n');
        this.haveMap = val;
        return this.haveMap;
    }

    this.setdataParsedFL = function(val) { this.dataParsedFL = val; return this.dataParsedFL;}
    this.setdataParsedDC = function(val) { this.dataParsedDC = val; return this.dataParsedDC;}
    this.setneedZoom = function(val) { this.needZoom = val; return this.needZoom;}
    this.setwaitMap = function(val) { this.waitMap = val; return this.waitMap; }

/*
��������� ����������:
    this.state.sethaveFailedLinks();
    this.state.sethaveDisconn();
    this.state.setwaitServer();
    this.state.sethaveMap();
    this.state.setdataParsedFL();
    this.state.setdataParsedDC();
    this.state.setneedZoom();
*/
    return this;
} // VState


///////////////////////////////////////////////////////////////////////////////
//
//	class VApp
//
///////////////////////////////////////////////////////////////////////////////
function VApp() {
    DBG('VApp constructor \n');
    this.state = new VState();
    this.map = null;
    this.srvConn = new VAJAX();

    this.arrFailedLinks = new Array();
    this.arrLockers = new Array();
    this.arrDisconn = new Array();
    this.mbr = new VBox();
    this.rll = new VRedlinePointLyr();

this.getXmlHttpReqObj = function() {
    return this.srvConn.xmlhttp;
} // getXmlHttpReqObj

this.getXmlRespProcessor = function () {
    return this.srvConn.processXMLResponse;
} // getXmlRespProcessor

this.setMapObject = function(amap) {
    if (amap == null || amap.isBusy()) {
        DBG('app.setMapObject: map busy \n');
        return false;
    }
    this.map = amap;
    this.state.sethaveMap(true);
    this.rll.Init(amap, '������� �� ���������');
    return true;
} // setMapObject

this.resetFailedLinks = function() {
    this.state.sethaveFailedLinks(false);
    this.state.setdataParsedFL(false);
    // �������� ������ ������:
    this.arrFailedLinks = new Array();
} // resetFailedLinks

this.resetLockersAndDisconn = function() {
    this.state.sethaveDisconn(false);
    this.state.setdataParsedDC(false);
    // �������� ������ ����������� � ������ �������:
    this.arrLockers = new Array();
    this.arrDisconn = new Array();
} // resetLockersAndDisconn

this.resetSrvConn = function() {
    this.srvConn.reset();
    this.state.setwaitServer(false);
} // resetSrvConn

this.getFailedLinksText = function() {
    DBG('app.getFailedLinksText \n');
    var res = '������� 1 ���., d=200; x=37.123456, y=56.123456\n������� 2 ���., d=200; x=37.123456, y=56.123456';
    res = '';
    for (var i = 0; i < this.arrFailedLinks.length; i++) {
        var fl = this.arrFailedLinks[i];
        var ln = ''+fl.pipePress+
            '\n  d='+fl.pipeDiam+
            '\n  x='+(fl.lon.toString()).substring(0,7)+
            ', y='+(fl.lat.toString()).substring(0,7)+'\n';
        res = res+ln;
    }
    return res;
} // getFailedLinksText


this.getCalcResultText = function() {
    DBG('app.getCalcResultText \n');
    var res = '�������� ��������� - 0\n������������ - 0';
    var numLockers = 0; var numCustomers = 0;
    for (var i = 0; i < this.arrLockers.length; i++) {
        var lo = this.arrLockers[i];
        if (lo.isLocker() != false) {
            numLockers++;
        }
    }

    for (var i = 0; i < this.arrDisconn.length; i++) {
        var dis = this.arrDisconn[i];
        if (dis.isCustomer() != false) {
            numCustomers++;
        }
    }
    res = '�������� ��������� - '+numLockers+'\n������������ - '+numCustomers+'';
    return res;
} // getCalcResultText


this.getLockersAndDisconn4Rep = function() {
    DBG('app.getLockersAndDisconn4Rep \n');
    var res = '';
    //  LOCKERS#GRS:139,GRP:4590,GRP:4589
    // *DISCONN#BOIL:2392,BOIL:2391,GRP:4590
    // *FAILLINKS#333:������� 1 ���:200:40.11:55.22,444 ...
    res = 'LOCKERS#';
    for (var i = 0; i < this.arrLockers.length; i++) {
        var lo = this.arrLockers[i];
        if (lo.isLocker() != false) {
            if (res.length > 9) res = res + ',';
            res = res + lo.type+':'+lo.objid;
        }
    }

    res = res + '*DISCONN#';
    for (var i = 0; i < this.arrDisconn.length; i++) {
        var dis = this.arrDisconn[i];
        if (dis.isCustomer() != false) {
            if (res.substring(res.length-1, res.length) != '#') res = res + ',';
            res = res + dis.type+':'+dis.objid;
        }
    }

    res = res + '*FAILLINKS#';
    for (var i = 0; i < this.arrFailedLinks.length; i++) {
        var fl = this.arrFailedLinks[i];
        var ln = ''+fl.linkObjID+
            ':'+fl.pipePress+
            ':'+fl.pipeDiam+
            ':'+(fl.lon.toString()).substring(0,7)+
            ':'+(fl.lat.toString()).substring(0,7);
        if (res.substring(res.length-1, res.length) != '#') res = res + ',';
        res = res+ln;
    }

    return res;
} // getLockersAndDisconn4Rep


this.findLinkByPoint = function(lonVal, latVal) {
    // ��������� ������ � ������� � ����������� ���������� ������:
    // ������ ������� � ����� ����� �����: ������� 1 ���., d=200; x=37.123456, y=56.123456
    DBG('app.findLinkByPoint: x:['+lonVal+'], y:['+latVal+'] \n');
    var o = acclocObj;
    if (this.state.waitServer != false) {
        alert('���������� ��������� ��������� �������� �������. \n ���������.');
        return;
    }

    this.srvConn.processXMLResponse = this.parseXmlFailedLink;
    var url = 'acc.localiz.php?client=ajax&action=findarc&lon='+lonVal+'&lat='+latVal;

    this.state.setwaitServer(true);
    if (this.srvConn.queryGET(url) == false ) {
        this.state.setwaitServer(false);
    }
} // findLinkByPoint


/*
���� �� ������� ����� (��� ����� ������), ��������� � �����.
��������� ������ �������� ��������� � ����. ������������ (�� �������).
�� ����������� ������� ���������� (����������), ����������� �����, �������� �������
*/
this.findLockersAndDisconn = function() {
    // ��������� ������ � ������� � ����������� ���������� ������:
    DBG('app.findLockersAndDisconn \n');
    var o = acclocObj;
    if (this.state.waitServer != false) {
        alert('���������� ��������� ��������� �������� �������. \n ���������.');
        return;
    }

    // ��������� ������� ����� ������:
    if (this.arrFailedLinks.length <= 0) {
        this.state.sethaveDisconn(false);
        alert('������� ����� ���������� ������������ �������.'); return;
    }

    var fll = '';
    for (var i = 0; i < this.arrFailedLinks.length; i++) {
        var fl = this.arrFailedLinks[i];
//		if (fl.linkNumSrc > 3) {
//			if (window.confirm('���������� ���, �������� ������������ ������� ������ ���.\n \
//����� ������� ����� ��������� 5 �����.\n \
//����������?') == false) {
//				return;
//			}
//		}
        if (fll.length > 0) fll = fll+',';
        fll = fll + fl.linkID + '';
    }
    this.resetLockersAndDisconn();

    // ����������:
    this.srvConn.processXMLResponse = this.parseXmlLockersAndDisconn;
    var url = 'acc.localiz.php?client=ajax&action=findlockersanddisconn&failedlinks='+fll;

    this.state.setwaitServer(true);
    if (this.srvConn.queryGET(url) == false ) {
        this.state.setwaitServer(false);
    }
} // findLockersAndDisconn


/*
���������� ��� ������ �� �������, ������� ��������� ����� (��������� �������������) ����:
�������� � ������ ����� ������ ��������� (��������� ������������) ������� ��� �� �����.
��������� ����� �������� ����� ���������� ������������ ����������.
���������� ������:
    sethaveFailedLinks(true)
    setwaitServer(false)
    setdataParsedFL(true)
*/
this.parseXmlFailedLink = function(xml) {
    DBG('app.parseXmlFailedLink \n');
    var a = this;
    if (a == null || a.state == null) {
        // alert('parseXmlFailedLink: I need App object !!!');
        a = getApp();
    }

/*
��� ��������� �����:
    /page/query/
        lon
        lat
    /page/App/failedLink/row/
        ID
        TYPE
        OBJID
    /page/App/failedLinkSources/row
        NUMSRC
    /page/App/failedPipe/row/
        PressureTypeName
        PipeDiam
*/

    var fl = new VFailedLink();
    var arrQry = xml.getElementsByTagName('query');
//  for (var i = 0; arrQry != null && i < arrQry.length; i++) {
//  DBG('app.parseXmlFailedLink: page.query.lon: ['+getElementTextNS('', 'lon', arrQry[i], 0)+'] \n');}
    fl.setPoint(arrQry[0]);
    arrQry = xml.getElementsByTagName('failedLink');
    fl.setLink(arrQry[0]);
    arrQry = xml.getElementsByTagName('failedLinkSources');
    fl.setNumSrc(arrQry[0]);
    arrQry = xml.getElementsByTagName('failedPipe');
    fl.setPipe(arrQry[0]);

    var bExists = false;
    for (var i = 0; a.arrFailedLinks != null && i < a.arrFailedLinks.length; i++) {
        var t = a.arrFailedLinks[i];
        if (t.linkID.valueOf() == fl.linkID.valueOf()) {
            bExists = true; break;
        }
    }
    if (bExists == false) {
        if (a.arrFailedLinks == null) a.arrFailedLinks = new Array();
//		this.arrFailedLinks.push(fl);
        a.arrFailedLinks[a.arrFailedLinks.length] = fl;
    }

    a.state.sethaveFailedLinks(true);
    a.state.setdataParsedFL(true);
    a.state.setwaitServer(false);
} // parseXmlFailedLink


/*
���������� ��� ������ �� �������, ������� �������� ���������� � ����. ������������ (�� ����� ������)
������� �������: �������, ����������� (������ ������ ��� ��������)
���������� ������:
    a.state.sethaveDisconn(true);
    a.state.setwaitServer(false);
    a.state.setdataParsedDC(true);
*/
this.parseXmlLockersAndDisconn = function(xml ) {
    DBG('app.parseXmlLockersAndDisconn \n');
    var a = this;
    if (a == null || a.state == null) {
        // alert('parseXmlLockersAndDisconn: I need App object !!!');
        a = getApp();
    }

/*
xml parameters:
    /page/query/
        client
        action
        failedlinks
    /page/App/Lockers/row (list)
        ID
        OBJID
        TYPE
    /page/App/Disconnected/row (list)
        ID
        OBJID
        TYPE
    /page/App/netMBR/row
        MAXX
        MAXY
        MINX
        MINY
*/

    a.arrLockers = new Array();
    var rows = xml.getElementsByTagName('Lockers');
    var lockers = rows[0].getElementsByTagName('row');
    DBG('app.parseXmlLockersAndDisconn: lockers: ['+lockers.length+'] \n');
    for (var i = 0; i < lockers.length; i++) {
        var lo = new VToponetObj(
            getElementTextNS('', 'ID', lockers[i], 0),
            getElementTextNS('', 'OBJID', lockers[i], 0),
            getElementTextNS('', 'TYPE', lockers[i], 0)
        );
        if (lo.type.valueOf() != 'JUNC' && lo.type.valueOf() != 'END') {
            a.arrLockers[a.arrLockers.length] = lo;
        }
    }

    a.arrDisconn = new Array();
    rows = xml.getElementsByTagName('Disconnected');
    var disconn = rows[0].getElementsByTagName('row');
    DBG('app.parseXmlLockersAndDisconn: disconn: ['+disconn.length+'] \n');
    for (var i = 0; i < disconn.length; i++) {
        var dis = new VToponetObj(
            getElementTextNS('', 'ID', disconn[i], 0),
            getElementTextNS('', 'OBJID', disconn[i], 0),
            getElementTextNS('', 'TYPE', disconn[i], 0)
        );
        if (dis.type.valueOf() != 'JUNC' && dis.type.valueOf() != 'END') {
            a.arrDisconn[a.arrDisconn.length] = dis;
        }
    }

    rows = xml.getElementsByTagName('netMBR');
    var mbrs = rows[0].getElementsByTagName('row');
    a.mbr.loadFromXMLNode(mbrs[0]);

    a.state.sethaveDisconn(true);
    a.state.setdataParsedDC(true);
    a.state.setwaitServer(false);
} // parseXmlLockersAndDisconn

} // VApp


///////////////////////////////////////////////////////////////////////////////
//
//	class VToponetObj
//
///////////////////////////////////////////////////////////////////////////////
function VToponetObj(p_id, p_objid, p_type) {
/*
links types:
    WHOLE
    PART
node types:
    GRP
    BOIL
    GRS
    END
    JUNC
    BOLT
*/
    this.id = new String(p_id);
    this.objid = new String(p_objid);
    this.type = new String(p_type);
    // DBG('VToponetObj: id:['+this.id+'], objid:['+this.objid+'], type:['+this.type+'] \n');

this.isLocker = function() {
    if (
        this.type.valueOf() == 'GRS' ||
        this.type.valueOf() == 'GRP' ||
        this.type.valueOf() == 'BOIL' ||
        this.type.valueOf() == 'BOLT'
    )	return true;
    return false;
}

this.isCustomer = function() {
    if (
        this.type.valueOf() == 'GRP' ||
        this.type.valueOf() == 'BOIL'
    )	return true;
    return false;
}

this.isLink = function() {
    if (
        this.type.valueOf() == 'WHOLE' ||
        this.type.valueOf() == 'PART'
    )	return true;
    return false;
}

} // VToponetObj


///////////////////////////////////////////////////////////////////////////////
//
//	class VFailedLink
//
///////////////////////////////////////////////////////////////////////////////
function VFailedLink() {
/*
��� ��������� �����:
    /page/query/
        lon
        lat
    /page/App/failedLink/row/
        ID
        TYPE
        OBJID
    /page/App/failedLinkSources/row
        NUMSRC
    /page/App/failedPipe/row/
        PressureTypeName
        PipeDiam
*/
    this.lon = 0.0;
    this.lat = 0.0;

    this.linkID = '';
    this.linkType = '';
    this.linkObjID = '';
    this.linkNumSrc = '';

    this.pipePress = '';
    this.pipeDiam = '';

this.setPoint = function(xmlnode) {
    this.lon = str2Float(getElementTextNS('', 'lon', xmlnode, 0));
    this.lat = str2Float(getElementTextNS('', 'lat', xmlnode, 0));
    DBG('failedlink.setPoint: lon:['+this.lon+'], lat:['+this.lat+'] \n');
}

this.setLink = function(xmlnode) {
    this.linkID = getElementTextNS('', 'ID', xmlnode, 0);
    this.linkType = getElementTextNS('', 'TYPE', xmlnode, 0);
    this.linkObjID = getElementTextNS('', 'OBJID', xmlnode, 0);
    DBG('failedlink.setLink: id:['+this.linkID+'], type:['+this.linkType+'], objid:['+this.linkObjID+'] \n');
}

this.setNumSrc = function(xmlnode) {
    this.linkNumSrc = getElementTextNS('', 'NUMSRC', xmlnode, 0);
    DBG('failedlink.setNumSrc: count:['+this.linkNumSrc+'] \n');
}

this.setPipe = function(xmlnode) {
    this.pipePress = getElementTextNS('', 'PressureTypeName', xmlnode, 0);
    this.pipeDiam = getElementTextNS('', 'PipeDiam', xmlnode, 0);
    DBG('failedlink.setPipe: pressure:['+this.pipePress+'], diam:['+this.pipeDiam+'] \n');
}

} // VFailedLink


///////////////////////////////////////////////////////////////////////////////
//
//	class VBox
//
///////////////////////////////////////////////////////////////////////////////
function VBox() {
    this.bInit = false;
    this.maxx = null;
    this.maxy = null;
    this.minx = null;
    this.miny = null;

this.loadFromXMLNode = function(xmlnode) {
    this.maxx = getElementTextNS("", "MAXX", xmlnode, 0).replace(',', '.');
    this.maxy = getElementTextNS("", "MAXY", xmlnode, 0).replace(',', '.');
    this.miny = getElementTextNS("", "MINY", xmlnode, 0).replace(',', '.');
    this.minx = getElementTextNS("", "MINX", xmlnode, 0).replace(',', '.');
    // DBG('VBox: get: maxx: '+this.maxx+'; maxy: '+this.maxy+'; minx: '+this.minx+'; miny: '+this.miny+'\n');
    this.convertStr2Number();
    this.normalizeValues();
    this.bInit = true;
    DBG('VBox: norm: maxx: '+this.maxx+'; maxy: '+this.maxy+'; minx: '+this.minx+'; miny: '+this.miny+'\n');
}

this.convertStr2Number = function() {
    this.maxx = parseFloat(this.maxx);
    this.maxy = parseFloat(this.maxy);
    this.miny = parseFloat(this.miny);
    this.minx = parseFloat(this.minx);
}

this.normalizeValues = function () {
    if (this.maxx < this.minx) {
        var x = Math.max(this.maxx, this.minx);
        var n = Math.min(this.maxx, this.minx);
        this.maxx = x; this.minx = n;
    }
    if (this.maxy < this.miny) {
        var x = Math.max(this.maxy, this.miny);
        var n = Math.min(this.maxy, this.miny);
        this.maxy = x; this.miny = n;
    }
}

} // VBox


///////////////////////////////////////////////////////////////////////////////
//
//	class VRedlinePointLyr
//
///////////////////////////////////////////////////////////////////////////////
function VRedlinePointLyr() {
    this.statOK = false; // true
    this.map = null;
    this.sLyrName = 'redline markers';
    return this;
};

VRedlinePointLyr.prototype.Init = function(map, lyrName) {
    this.statOK = false;
    this.map = map;
    this.sLyrName = lyrName;
    if ( map == null || map.isBusy() ) return false;
    this.statOK = true;

    var redlineSetup = map.getRedLineSetup();
    var symbSetup = redlineSetup.getSymbolAttr();
    //	if (false == symbSetup.setSymbol("Markers - Diamond Outline"))
    //	if (false == symbSetup.setSymbol('Stars - Red'))
    if (false == symbSetup.setSymbol('Accident - accident')) {
        symbSetup.setRotation(45.0);
        alert("������ ��� ������� �����������.\n ���������� ������ �� ���������.");
    }
    symbSetup.setHeight(100.0, "M")
    symbSetup.setWidth(100.0, "M")
    return true;
}

VRedlinePointLyr.prototype.getLayer = function() {
    var map = this.map;
    if (map == null || map.isBusy()) return null;
    var lyr = map.getMapLayer(this.sLyrName);
    if (lyr == null) {
        lyr = map.createLayer("redline", this.sLyrName);
    }
    return lyr;
}

VRedlinePointLyr.prototype.clearLayer = function() {
    var map = this.map;
    var redlineLayer = this.getLayer();
    // Get selected objects and delete
    if(map != null && redlineLayer != null && !map.isBusy()) {
        var objects = redlineLayer.getMapObjectsEx();
        if (objects.size() > 0) {
            //if(window.confirm("Remove?"))
            redlineLayer.removeObjects(objects);
        }
        else
            ;//alert("no objects.");
    }
    else
        ;//alert("no layer.");
}

VRedlinePointLyr.prototype.addPoint = function(p_map, point, sKey, sName, sUrl) {
    var map = this.map;
    var latVal = point.getY(); var lonVal = point.getX();
    var redlineLayer = this.getLayer();
    var vertex = map.lonLatToMcs(lonVal, latVal);
    // Add point
    var aPoint = redlineLayer.getMapObject(sKey);
    if(aPoint == null) aPoint = redlineLayer.createMapObject(sKey, sName, sUrl);
    aPoint.addSymbolPrimitive(vertex, true);
} // addPoint
// VRedlinePointLyr



///////////////////////////////////////////////////////////////////////////////
//
//	class VAJAX
//
///////////////////////////////////////////////////////////////////////////////
function VAJAX () {
    DBG('VAJAX constructor \n');
    this.xmlhttp = null;

this.reset = function() {
    try {
        if (this.xmlhttp == null) this.xmlhttp = new ActiveXObject('Msxml2.XMLHTTP');
        else { this.xmlhttp.onreadystatechange = function() {;}; this.xmlhttp.abort(); }
    } catch(err) {
        alert('Error, cannot initialize AJAX');
        this.xmlhttp = null;
    }
    this.xmlhttp.onreadystatechange = acclocObj.onAjaxResponse;
} // reset

this.queryGET = function(url) {
    DBG('AJAX:queryGET 1: url: ['+url+'] \n');
    if ( this.isBusy() ) {
        alert('AJAX: ��������� ��������� �������� �������.');
        return false;
    }
    // onAjaxResponse - ���������� �������. ��������� � ������ "�������":
    this.xmlhttp.open('GET', url, true);
    this.xmlhttp.onreadystatechange = acclocObj.onAjaxResponse;
    this.xmlhttp.send(null);
    DBG('AJAX:queryGET 2: done. wait now. \n');
    return true;
} // queryGET

this.isBusy = function() {
    var res = true;
    if ( this.xmlhttp != null && (this.xmlhttp.readyState == 4 || this.xmlhttp.readyState == 0) ) {
        res = false;
    }
    DBG('AJAX:isBusy: ['+res+'] \n');
    return res;
}

this.processXMLResponse = function(xml) {
    DBG('AJAX:processXMLResponse: ['+xml+'] \n');
    return true;
} // processXMLResponse

    this.reset();
    return this;
} // VAJAX


/*
###############################################################################
    ������ �������� ���������� }
###############################################################################
*/

/*
###############################################################################
    ������� {
###############################################################################
*/

function getMap() {
    return window.map;
}

function setElemVisibility(elemName, visStatus) {
    var aElem = document.getElementById(elemName);
    if (aElem != null) {
        aElem.style.display = visStatus; // none; block, inline
    }
} // setElemVisibility

function getElementTextNS(prefix, local, parentElem, index) {
    var result = null;
    result = parentElem.getElementsByTagName(local);
    if (result) result = result[index];
    if (result) result = result.firstChild;
    if (result) result = result.nodeValue;

    if (result) return ''+result+'';
    else return '';
} // getElementTextNS
/*
xml examples:

var rows = xmltext.getElementsByTagName("netmbr");
for (var i = 0; i < rows.length; i++) {
    this.vCustSubnetMBR.loadFromXMLNode(rows[i]);
}

nodetext = getElementTextNS("", "lon", xmltext, 0).replace(',', '.');;
var lon = parseFloat(nodetext);
*/

function str2Float(str) {
    return parseFloat(str.replace(',', '.'));
} // str2Float

function mapAddToSelected(map, sLayerName, sKey, action) {
    // action: add or remove
    if (map.isBusy()) {alert('����� ������, ���������� �����.'); return false;}
    var sel = map.getSelection();
    var lyr = map.getMapLayer(sLayerName);
    if (lyr == null) {
        sLastError = "���� {"+sLayerName+"} ����������� � �����, ������� �� ��������.";
        return false;
    }

    var feature = lyr.getMapObject(sKey);
    if (feature != null) {
        if (action === 'add') sel.addObject(feature, false);
        else sel.removeObject(feature, false);
    } else {
        sLastError = "��� ������� �� �����: key: {"+sKey+"}, lyr: {"+sLayerName+"}";
        return false;
    }
    return true;
} // mapAddToSelected

function zoomMapByBox(map, left, top, right, bottom, zoomf) {
    if (map.isBusy()) map.stop();
    var xyPt1 = map.lonLatToMcs(left, bottom);
    var xyPt2 = map.lonLatToMcs(right, top);
    var width = Math.abs(( xyPt2.getX()-xyPt1.getX() ) * zoomf); if (width <= 0) width = 0.0001;
    var height = Math.abs(( xyPt2.getY()-xyPt1.getY() ) * zoomf); if (height <= 0) height = 0.0001;
    var fLat = bottom+((top-bottom)/2.0);
    var fLon = left+((right-left)/2.0);

    var ext = map.getMapExtent(false, false);
    var fLeft = ext.getMinX(), fRight = ext.getMaxX();
    var fTop = ext.getMaxY(), fBottom = ext.getMinY();
    if (fLat > fTop) fLat = fTop; if (fLat < fBottom) fLat = fBottom;
    if (fLon > fRight) fLon = fRight; if (fLon < fLeft) fLon = fLeft;

    // ���� ����� �������, ���������� ���� �� ������
    var mapH = map.getHeight('M'), mapW = map.getWidth('M');
    if (mapW/mapH > width/height) {
        width = width * ((mapW/mapH) / (width/height));
    }
    DBG("zoomParams: lat:{"+fLat+"}, lon:{"+fLon+"}, width:{"+width+"M} \n");
    map.zoomWidth(fLat, fLon, width, "M");
} // zoomMapByBox


/*
###############################################################################
    ������� }
###############################################################################
*/

};
acclocObj = new namespaceAccLoc();
