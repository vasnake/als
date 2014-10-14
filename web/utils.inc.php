<?php

function OUT($logStr) {
    echo $logStr . "\n";
};

function ERR($logStr) {
    printTag('ERROR', $logStr, '');
};

function appERR($logStr) {
    printTag('applicationError', $logStr, '');
};

function safeStr($aStr) {
    return htmlspecialchars($aStr);
    //return htmlentities($aStr, ENT_COMPAT, 'cp1251');
};

function safe4Sql($aDataStr) {
    return str_replace("'", "''", $aDataStr);
};

function safeOUT($logStr) {
    echo safeStr($logStr) . "\n";
};

function SEQ($str1, $str2) {
    if(strcasecmp((string)$str1, (string)$str2) == 0)
        return TRUE;
    return FALSE;
};

function accSEQ($str1, $str2) {
    if(strcmp((string)$str1, (string)$str2) == 0)
        return TRUE;
    return FALSE;
};

function isEmpty($str) {
    if(isset($str) && !SEQ($str, ""))
        return false;
    return true;
};

function toUpper($content) {
    $content = strtr($content, "àáâãäå¸æçèéêëìíîðïñòóôõö÷øùúüûýþÿ", "ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÐÏÑÒÓÔÕÖ×ØÙÚÜÛÝÞß");
    return strtoupper($content);
};

function utf8win1251($s) {
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

function win12512utf($s) {
    $t = '';
    for($i=0,$m=strlen($s);$i<$m;$i++) {
        $c=ord($s[$i]);
        if ($c>127) // convert only special chars
        if     ($c==184) $t.=chr(209).chr(209); // small io
        elseif ($c==168) $t.=chr(208).chr(129); // capital io
        else              $t.=($c>239?chr(209):chr(208)).chr($c-48);
        else $t.=$s[$i];
    }
    return $t;
}

function win12513utf($s) {
    $t = '';
    for($i=0, $m=strlen($s); $i<$m; $i++) {
        $c=ord($s[$i]);
        if ($c<=127) {$t.=chr($c); continue; }
        if ($c>=192 && $c<=207) {$t.=chr(208).chr($c-48); continue; }
        if ($c>=208 && $c<=239) {$t.=chr(208).chr($c-48); continue; }
        if ($c>=240 && $c<=255) {$t.=chr(209).chr($c-112); continue; }
        if ($c==184) { $t.=chr(209).chr(209); continue; };
        if ($c==168) { $t.=chr(208).chr(129);  continue; };
    }
    return $t;
}

function win12512unicode($isoline){
    $uniline = "";
    for ($i=0; $i < strlen($isoline); $i++){
        $thischar=substr($isoline,$i,1);
        $charcode=ord($thischar);
        if ($charcode==168){
            $uniline.="&#".(26*32+3+12+10+($charcode)).";";
        } elseif ($charcode==184){
            $uniline.="&#".(26*32+3+12+10+60+4+($charcode)).";";
        } elseif (($charcode>=192) and ($charcode<=255)){
            $uniline.="&#".(26*32+3+12+1+($charcode)).";";
        } else {
            $uniline.=$thischar;
        }
    }
    return $uniline;
}


function getFromArray($arr, $key) {
    $tRet = "";
    if (isset($arr) && count($arr) > 0) {
        if (array_key_exists($key, $arr)) {
            $tRet = $arr[$key];
        }
    }
    return $tRet;
};

function GFA($arr, $key) {
    return getFromArray($arr, $key);
};

function printTag($tag, $val, $sp = '	') {
    if (isEmpty($val)) $val = '';
    OUT($sp . '<' .$tag. '>' .safeStr($val). '</' .$tag. '>');
}; // function printTag($tag, $val, $sp = '	')

function xmlDumpArray($arr, $tagname = '') {
    if (!SEQ('', $tagname)) OUT('<' .$tagname. '>');
    foreach ($arr as $key => $value) {
        printTag($key, $value);
    }
    if (!SEQ('', $tagname)) OUT('</' .$tagname. '>');
}; // function xmlDumpArray($arr)

function xmlDumpFields($arr, $tagname = '') {
    if (!SEQ('', $tagname)) OUT('<' .$tagname. '>');
    foreach ($arr as $key => $value) {
        OUT('	<field> <name>' .safeStr($key). '</name> <value>' .safeStr($value). '</value> </field>');
    }
    if (!SEQ('', $tagname)) OUT('</' .$tagname. '>');
}; // function xmlDumpFields($arr, $tagname = '')

function xmlDumpRecset($db, $tagname, $funcRecordProcessor='') {
    $r = null; $iRecCount = 0; $bContinue = true;
    OUT('<' .$tagname. '>');
    while ( ($r = $db->getRecord()) != null) {
        if ( !isEmpty($funcRecordProcessor) ) { $func = $funcRecordProcessor; $bContinue = $func($r); }
        if ( $bContinue == false ) continue;
        $iRecCount ++;
        xmlDumpArray($r, 'row');
    }
    printTag('rowsCount', $iRecCount);
    OUT('</' .$tagname. '>');
    return $iRecCount;
}; // function xmlDumpRecset($db, $tagname)

function dumpQuery2XML($req, $decode=false) {
//$args = dumpQuery2XML($_REQUEST);
    $args = array();
    OUT('<query>');
    foreach ($req as $key => $value) {
        $aVal = $value;
        if ($decode != false) $aVal = utf8win1251(urldecode($value));
        $args[$key] = $aVal;
        printTag($key, $aVal);
    }
    OUT('</query>');
    return $args;
}; // dumpQuery2XML

function getUserLogin() {
    $login = trim(getenv('REMOTE_USER'));
    if ( isEmpty($login) ) {
        $login = trim(getenv('REDIRECT_REMOTE_USER'));
    }
    if ( isEmpty($login) ) {
        $login = trim( $_SERVER['REMOTE_USER'] );
    }
    if ( isEmpty($login) ) {
        $login = trim( $_SERVER['REDIRECT_REMOTE_USER'] );
    }
    return $login;
};

function getUserGroups($login) {
    $groups = array();
    global $glob_GroupsFile;
    $fname = $glob_GroupsFile;

    $res = fopen($fname, 'r');
    if ($res == false) {
        DBG('Cannot open GroupsFile');
        return $groups;
    }

    while (!feof ($res)) {
        $buffer = fgets($res, 4096);
        if ($buffer == false) continue;
        if ($buffer{0} == '#') continue;

        $group = strtok($buffer, ':'); if ($group == false) continue;
        $user = strtok(' ');

        while ($user != false) {
            if (accSEQ(trim($user), $login)) {
                $groups[] = trim($group);
                break;
            }
            $user = strtok(' ');
        }
    } // end each line in file

    fclose($res);
    return $groups;
}; // function getUserGroups($login)

function getDateTimeStr($fmt = "US") {
    $sRet = "";
    $timenow = getdate();
    //DBG($timenow); //Array ( [seconds] => 3 [minutes] => 59 [hours] => 18 [mday] => 30 [wday] => 2 [mon] => 3 [year] => 2004 [yday] => 89 [weekday] => Tuesday [month] => March [0] => 1080658743 )
    $hours = substr("0" . $timenow["hours"], -2);
    $minutes = substr("0" . $timenow["minutes"], -2);
    $seconds = substr("0" . $timenow["seconds"], -2);
    $mon = substr("0" . $timenow["mon"], -2);
    $mday = substr("0" . $timenow["mday"], -2);
    //US: 03/30/2004 19:03:18
    $sStdDateTime = $mon . "/" . $mday . "/" . $timenow['year'] . " " . $hours . ":" . $minutes . ":" . $seconds;
    $sRet = $sStdDateTime;
    if (SEQ($fmt, 'RU')) {
    //RU: 30/03/2004 19:03:18
        $sStdDateTime = $mday . "/" . $mon . "/" . $timenow['year'] . " " . $hours . ":" . $minutes . ":" . $seconds; // 03/30/2004 19:03:18
    }
    else if (SEQ($fmt, 'VS')) {
    //VS: 2004-03-30 19:03:18
        $sStdDateTime = $timenow['year'] . "-" . $mon . "-" . $mday . " " . $hours . ":" . $minutes . ":" . $seconds; // 03/30/2004 19:03:18
    }
    $sRet = $sStdDateTime;
    return $sRet;
/*
These are examples of ODBC time and date constants:
{ ts '1998-05-02 01:23:56.123' }
{ d '1990-10-02' }
{ t '13:33:41' }
*/
}; // function getDateTimeStr($fmt = "US")

function formatDatetime($fmt, $val) {
    //formatDatetime("Y-m-d H:i:s", GFA($arrRec, 'EDTTIME'));
    $sRet = "";
    if(!SEQ("", $val)) $sRet = date($fmt, $val);
    return $sRet;
};

function getGUID() {
    $res = "";
    //$comKG = new COM("keygen.Util.1") or die("Íåâîçìîæíî ñãåíåðèðîâàòü GUID");
    $comKG = new COM("keygen.Util") or die("Íåâîçìîæíî ñãåíåðèðîâàòü GUID, âîçìîæíî îòñóòñòâóåò keygen.DLL");
    $res = $comKG->getNextKey();
    //DBG($res, "GUID");
    return $res;
    //return md5(uniqid(rand(), true));
}; // function getGUID()

function setFloat($aVal, $defVal) {
    $res = str_replace(",", ".", $aVal);
    if ( isEmpty($res) || is_nan($res) || $aVal == 0.0 ) $res = $defVal;
    return $res;
}

function swapValues(&$val1, &$val2) {
    $aTmp = $val1;
    $val1 = $val2; $val2 = $aTmp;
} // swapValues

function isEnclosure($aStr, $aChar) {
    $res = $aStr;
    $len = strlen($res);
    if ($len >= 2) {
        $pos1 = strpos($res, $aChar);
        $pos2 = strrpos($res, $aChar);
        if ($pos1 !== false && $pos2 !== false) {
            if ($pos1 == 0 && $pos2 == $len - 1) {
                return true;
            }
        }
    }
    return false;
}; // isEnclosure

?>
