// # -*- coding: cp1251 -*-
// # (c) Valik mailto:vasnake@gmail.com

function onAccLocalizPageLoad() {
    //	if (window.name == "PageForPrint") doPrinterFormat();
    window.focus();
    var frm = document.getElementById('formAccLocaliz');
    if (frm != null) {
        if (frm.repType.value == 'LockersAndDisconn4Print')
            doPrinterFormat();
    }
}

function formatForPrint() {
    //	aWind = window.open(document.URL, "PageForPrint");
    var frm = document.getElementById('formAccLocaliz');
    if (frm != null) {
        frm.repType.value = 'LockersAndDisconn4Print';
        frm.submit();
    }
}


function copy2Word() {
    hideDecoration();

    var tr = document.body.createTextRange();
    tr.moveToElementText(document.getElementById("pageContent"));
    tr.select();
    tr.execCommand("Copy");
    tr.findText(' '); tr.select();

    var appW = null;
    try {
    appW = GetObject("Word.Application");
    } catch (err) {
        try{ appW = new ActiveXObject("Word.Application"); } catch(err) {
            alert('Программа MS Word не обнаружена.\n \
 Попробуйте вручную вставить содержимое буфера обмена в документ.');
        }
    }

    if (appW != null) {
        appW.Visible = true;
        var docs = appW.Documents;
        var doc = null;
        if (docs.Count == 0) {
            doc = docs.Add();
        } else {
            doc = appW.ActiveDocument;
        }
        try {
            appW.Visible = false;
            var sel = doc.ActiveWindow.Selection;
            sel. Collapse();
            sel.Paste();
            appW.Visible = true;
        } catch(err) { alert("Сбой копирования"); }
        try {
            copyMap2Clipboard();
            appW.Visible = false;
            var sel = doc.ActiveWindow.Selection;
            sel. Collapse();
            sel.Paste();
            appW.Visible = true;
        } catch(err) { alert("Сбой копирования карты"); }
    }

    showDecoration();
} // copy2Word


function hideDecoration() {
    setElemVisibility("aHeadImg", "none");
    setElemVisibility("divToolsLinks", "none");
}

function showDecoration() {
    setElemVisibility("aHeadImg", "block");
    setElemVisibility("divToolsLinks", "block");
}


function doPrinterFormat() {
    hideDecoration();

    var aContentObj = document.getElementById("pageContent");
    if (aContentObj == null) alert("Нет содержимого для печати.");
    var aBodyObj = document.body;
    if (aBodyObj == null) alert("Нет документа для печати.");

    var sContent = aContentObj.innerHTML;
    aBodyObj.innerHTML = sContent;
    aBodyObj.background = "";
}


function accLocalizRepShowMap() {
    try {
        if (opener != null) opener.focus();
        else throw 'error';
    } catch(err) {
        alert('Карта недоступна. ');
    }
} // accLocalizRepShowMap


function copyMap2Clipboard() {
    var map = null;
    try { map = window.map; } catch(err) { ; }
    if (map == null ) try { map = opener.window.map; } catch(err) { ; }
    if (map == null ) try { map = parent.window.map; } catch(err) { ; }
    if (map != null ) { try {
        if (map.isBusy()) map.stop();
        map.copyMap();
    } catch(err) { ; } }
    return map;
} // copyMap2Clipboard
