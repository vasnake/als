
/*
TODO:

function findAndPrintPointedLink($lon, $lat) {
// найти и распечатать ID указанного точкой линка
    $linkid = getFieldValue(getRecordset4SQL('select fncName(33.33,55.55) LINKID from dual'), 'LINKID');
    echo '<linkid>' .$linkid. '</linkid>';
select mogTopo.getLinkByPoint(33.33,55.55) LINKID from dual;

function findAndPrintLockingObjects ($failedlinks) { // list of  linkid, comma separated
// найти и распечатать обьекты (тип, ID) отсекающие течение газа в битые линки (а заодно и сами линки)
// GRS, GRP, Boiler, Bolt, Link, netMBR
// запорное устройство - комбинация из типа пункта, ID пункта, ID линка (GRP,77,33)
    echo '<listGRS>' .$listGRS. '</listGRS>';
    ...
select * from table(mogTopo.getLockers4FailedLinks('3,7,17')) order by type, objid, id;
             ID           OBJID TYPE
--------------- --------------- ------
             64               9 GRS
           4750             678 GRP
          38732            9543 PIPE

function findAndPrintCustomers($locked) { // LINK:4940,3989;GRS:16820,477;GRP:20818,19491;BOILER:17696,24281;BOLT:12446,1919
// найти потребителей (ГРП и котельные) отключенных от источника по причине перекрытия указанных запорных устройств
// если к потребителю подходит хоть один линк с газом - считать подключенным.
    echo '<listLink>' .$listLink. '</listLink>';
    ...
select * from table(mogTopo.getDisconnectedByDampedLinks('3,7,17'));
             ID           OBJID TYPE
--------------- --------------- ------
             64               9 GRS
           4750             678 GRP
          38732            9543 PIPE

*/

-- drop table tempTab;
-- create global temporary table tempTab (numval number) on commit delete rows;
-- create global temporary table tempTab (numval number) on commit preserve rows;

-- package interface {
-- select object_type, status, object_name from user_objects order by object_type, status, object_name;
select object_type, status, object_name from user_objects
    where object_name not like '%$%'
    order by object_type, status, object_name;

drop package mogTopo;
drop type tabTopoObjType;
drop type topoObjRecord;
drop type arrayNumType;

create or replace type topoObjRecord as object (
    id number,
    objid number,
    type varchar2(10)
);
/

create or replace type tabTopoObjType as table of topoObjRecord;
/

create or replace type arrayNumType is table of number;
/


create or replace package mogTopo
as
--	GRS, GRP, BOIL, BOLT
--	g_stopNodeType varchar2(10) default 'GRS';

    function getLinkByPoint(p_lon in number, p_lat in number) return number;
-- select mogTopo.getLinkByPoint(33.33,55.55) LINKID from dual;

    function getLockers4FailedLinks(p_links in varchar2) return tabTopoObjType;
-- select * from table(mogTopo.getLockers4FailedLinks('3,7,17')) order by type, objid, id;

    function getDisconnectedByDampedLinks(p_links in varchar2) return tabTopoObjType;
    function getDisconnectedByDampedLinks2(p_links in clob) return tabTopoObjType;
    function getDisconnByFailedLinks(p_links in varchar2) return tabTopoObjType;
-- select * from table(mogTopo.getDisconnectedByDampedLinks('3,7,17'));

-- вернуть таблицу обьектов связанных с узлом
    function getLinkedObjects4Node(p_NodeID in number) return tabTopoObjType;
end;
/
show errors;
-- package interface }


-- package body {
create or replace package body mogTopo
as
    g_stopNodeType varchar2(10) default 'GRS';

-- private -------------------------------------------------------------------

-- процедура вывода на экран:
procedure dbg(p_str in varchar2)
    as begin dbms_output.put_line('tm:['||to_char(sysdate, 'HH24:MI:SS')||'] '||p_str);
end dbg;


-- добавить элемент к массиву
procedure push2Array(p_id in number, p_oid in number, p_type in varchar2, p_arr in out nocopy tabTopoObjType)
as
begin
    p_arr.extend; p_arr(p_arr.last) := topoObjRecord(p_id, p_oid, p_type);
end push2Array;

-- добавить элемент к массиву
procedure push2Array(p_num in number, p_arr in out nocopy arrayNumType)
as
begin
    p_arr.extend; p_arr(p_arr.last) := p_num;
end push2Array;


-- содержится в массиве?
-- tabTopoObjType
function containInArray(p_arr in tabTopoObjType, p_val in topoObjRecord)
return number
as
    l_res number default 0;
    l_idx number default 0;
    l_val topoObjRecord default null;
begin
    l_idx := p_arr.first;
    loop
        exit when(l_idx is null);
        l_val := p_arr(l_idx);
        if l_val.id = p_val.id and l_val.objid = p_val.objid and l_val.type = p_val.type then
            l_res := l_idx; exit;
        end if;
        l_idx := p_arr.next(l_idx);
    end loop;

    return l_res;
end containInArray;

-- arrayNumType
function containInArray(p_arr in arrayNumType, p_num in number)
return number
as
    l_res number default 0;
    l_idx number default 0;
begin
    l_idx := p_arr.first;
    loop
        exit when(l_idx is null);
        if p_arr(l_idx) = p_num then
            l_res := l_idx; exit;
        end if;
        l_idx := p_arr.next(l_idx);
    end loop;

    return l_res;
end containInArray;


-- удалить уже пройденные линки из списка
-- tabTopoObjType
procedure removeExists(p_arrPassedLinks in tabTopoObjType, p_arrRes in out nocopy tabTopoObjType)
as
    l_idx number default 0;
    l_arr tabTopoObjType := tabTopoObjType();
begin
    for i in 1..p_arrPassedLinks.count loop
        loop
            l_idx := containInArray(p_arrRes, p_arrPassedLinks(i));
            exit when (l_idx <= 0);
            p_arrRes.delete(l_idx);
        end loop;
    end loop;
-- compact result:
    l_idx := p_arrRes.first;
    loop
        exit when(l_idx is null);
        l_arr.extend; l_arr(l_arr.count) := p_arrRes(l_idx);
        l_idx := p_arrRes.next(l_idx);
    end loop;
    p_arrRes := l_arr;
end removeExists;

-- arrayNumType
procedure removeExists(p_arrPassedLinks in arrayNumType, p_arrRes in out nocopy arrayNumType)
as
    l_idx number default 0;
    l_arr arrayNumType := arrayNumType();
begin
    for i in 1..p_arrPassedLinks.count loop
        loop
            l_idx := containInArray(p_arrRes, p_arrPassedLinks(i));
            exit when (l_idx <= 0);
            p_arrRes.delete(l_idx);
        end loop;
    end loop;
    -- compact result:
    l_idx := p_arrRes.first;
    loop
        exit when(l_idx is null);
        l_arr.extend; l_arr(l_arr.count) := p_arrRes(l_idx);
        l_idx := p_arrRes.next(l_idx);
    end loop;
    p_arrRes := l_arr;
end removeExists;


-- найти узлы для линка
procedure getLinkNodes(p_link in number, p_nodeA out number, p_nodeB out number)
as
begin
    execute immediate
    'select startnodeid, endnodeid from topolink where id = :linkid'
    into p_nodeA, p_nodeB using p_link;
end getLinkNodes;


-- проверка на стопузел
--	p_type = GRS or LOCKERS (GRS or GRS, GRP, BOIL, BOLT)
function isStopNode(p_node in number, p_type in varchar2)
return varchar2
as
    l_res varchar2(10) default 'TRUE';
begin
    execute immediate
    'select type from toponode where id = :nodeid'
    into l_res using p_node;

    if p_type = 'GRS' and l_res = p_type then
        l_res := 'TRUE';
    elsif p_type = 'LOCKERS' and instr('GRS,GRP,BOIL,BOLT', l_res) > 0 then
        l_res := 'TRUE';
    else
        l_res := 'FALSE';
    end if;
    return l_res;
end isStopNode;


-- получить список линков для узла
procedure getNodeLinks(p_node in number, p_arrLinks in out nocopy arrayNumType)
as
begin
    for x in (select * from topolink where startnodeid = p_node or endnodeid = p_node) loop
-- dbms_output.put_line('linkid: ' || x.id);
        p_arrLinks.extend; p_arrLinks(p_arrLinks.count) := x.id;
    end loop;
end getNodeLinks;


-- найти линки для узла, с учетом стопузлов и уже обойденных
-- procedure getNodeLinksEx(p_node in number, p_arrPassedNodes in out nocopy arrayNumType, p_appSubLinks in out nocopy arrayNumType)
function getNodeLinksEx(p_node in number, p_arrPassedNodes in out nocopy arrayNumType, p_appSubLinks in out nocopy arrayNumType)
return number
as
    l_res number default 0;
begin
    if containInArray(p_arrPassedNodes, p_node) > 0 then
        return l_res;
    end if;
    push2Array(p_node, p_arrPassedNodes);
--	if isStopNode(p_node, 'GRS') = 'TRUE' then
    if isStopNode(p_node, g_stopNodeType) = 'TRUE' then
        l_res := 1;
    else
        l_res := 0;
        getNodeLinks(p_node, p_appSubLinks);
    end if;
    return l_res;
end getNodeLinksEx;


-- добавить содержимое массива к другому массиву
-- tabTopoObjType
procedure addArray2Array(p_arrFrom in tabTopoObjType, p_arrTo in out nocopy tabTopoObjType)
as
    l_idx number default 0;
begin
    l_idx := p_arrFrom.first;
    loop
        exit when(l_idx is null);
        p_arrTo.extend; p_arrTo(p_arrTo.count) := p_arrFrom(l_idx);
        l_idx := p_arrFrom.next(l_idx);
    end loop;
end addArray2Array;

-- arrayNumType
procedure addArray2Array(p_arrFrom in arrayNumType, p_arrTo in out nocopy arrayNumType)
as
    l_idx number default 0;
begin
    l_idx := p_arrFrom.first;
    loop
        exit when(l_idx is null);
        p_arrTo.extend; p_arrTo(p_arrTo.count) := p_arrFrom(l_idx);
        l_idx := p_arrFrom.next(l_idx);
    end loop;
end addArray2Array;


-- получить два списка: линков и узлов, связанных с линками в переданном списке:
procedure getLinkedTopoObjects(p_arrStartLinks in arrayNumType, p_arrPassedLinks in out nocopy arrayNumType, p_arrPassedNodes in out nocopy arrayNumType)
as
    l_arrLinks arrayNumType := arrayNumType();
    l_arrLinks2 arrayNumType := arrayNumType();
    l_arrSubLinks arrayNumType := arrayNumType();
    l_nodeA number default 0; l_nodeB number default 0;
    l_isStopA number default 0; l_isStopB number default 0;
begin
    l_arrLinks := p_arrStartLinks;
    loop exit when(l_arrLinks.count <= 0);
        for i in 1..l_arrLinks.count loop
        -- get subLinks
            getLinkNodes(l_arrLinks(i), l_nodeA, l_nodeB);
            push2Array(l_arrLinks(i), p_arrPassedLinks);
--			getNodeLinksEx(l_nodeA, p_arrPassedNodes, l_arrSubLinks);
--			getNodeLinksEx(l_nodeB, p_arrPassedNodes, l_arrSubLinks);
            l_isStopA := getNodeLinksEx(l_nodeA, p_arrPassedNodes, l_arrSubLinks);
            l_isStopB := getNodeLinksEx(l_nodeB, p_arrPassedNodes, l_arrSubLinks);
            removeExists(p_arrPassedLinks, l_arrSubLinks);
            addArray2Array(l_arrSubLinks, l_arrLinks2); l_arrSubLinks.delete;
        -- for each link
        end loop;
        l_arrLinks.delete; l_arrLinks := l_arrLinks2; l_arrLinks2.delete;
    -- while have links
    end loop;
end getLinkedTopoObjects;


--	findFirstStopNode(l_startLinks, l_arrPassedLinks, l_arrPassedNodes);
-- получить два списка: линков и узлов, связанных с обьектом (указанного типа), искать до первого стопузла:
procedure findFirstStopNode(p_arrStartLinks in arrayNumType, p_arrPassedLinks in out nocopy arrayNumType, p_arrPassedNodes in out nocopy arrayNumType)
as
    l_arrLinks arrayNumType := arrayNumType();
    l_arrLinks2 arrayNumType := arrayNumType();
    l_arrSubLinks arrayNumType := arrayNumType();
    l_nodeA number default 0; l_nodeB number default 0;
    l_isStopA number default 0; l_isStopB number default 0;
begin
    l_arrLinks := p_arrStartLinks;
    loop exit when(l_arrLinks.count <= 0);
        for i in 1..l_arrLinks.count loop
        -- get subLinks
            getLinkNodes(l_arrLinks(i), l_nodeA, l_nodeB);
            push2Array(l_arrLinks(i), p_arrPassedLinks);
            l_isStopA := getNodeLinksEx(l_nodeA, p_arrPassedNodes, l_arrSubLinks);
            l_isStopB := getNodeLinksEx(l_nodeB, p_arrPassedNodes, l_arrSubLinks);
            if l_isStopA <> 0 or l_isStopB <> 0 then
                l_arrLinks2.delete;
                exit;
--				l_arrSubLinks.delete; l_arrLinks.delete; l_arrLinks2.delete;
            end if;
            removeExists(p_arrPassedLinks, l_arrSubLinks);
            addArray2Array(l_arrSubLinks, l_arrLinks2); l_arrSubLinks.delete;
        -- for each link
        end loop;
        l_arrLinks.delete; l_arrLinks := l_arrLinks2; l_arrLinks2.delete;
    -- while have links
    end loop;
end findFirstStopNode;


function str2array (p_str in long, p_delim in varchar2) return arrayNumType
as
    l_res arrayNumType default arrayNumType();
    l_str      long default p_str || p_delim;
    l_n        number;
begin
    loop
        l_n := instr( l_str, p_delim );
        exit when (nvl(l_n,0) = 0);
        push2Array( to_number(
            ltrim(rtrim( substr(l_str,1,l_n-1) )) ),
            l_res);
        l_str := substr( l_str, l_n+1 );
    end loop;
    return l_res;
end str2array;

function str2array (p_str in clob, p_delim in varchar2) return arrayNumType
as
    l_res arrayNumType default arrayNumType();
    l_str      clob default p_str || p_delim;
    l_n        number;
begin
    loop
        l_n := instr( l_str, p_delim );
        exit when (nvl(l_n,0) = 0);
        push2Array( to_number(
            ltrim(rtrim( substr(l_str,1,l_n-1) )) ),
            l_res);
        l_str := substr( l_str, l_n+1 );
    end loop;
    return l_res;
end str2array;

/*
function str2array (p_str in varchar2, p_delim in varchar2) return arrayNumType
as
    l_res arrayNumType default arrayNumType();
    l_str      long default p_str || p_delim;
    l_n        number;
begin
    loop
        l_n := instr( l_str, p_delim );
        exit when (nvl(l_n,0) = 0);
        push2Array( to_number(
            ltrim(rtrim( substr(l_str,1,l_n-1) )) ),
            l_res);
        l_str := substr( l_str, l_n+1 );
    end loop;
    return l_res;
end str2array;
*/


function removeDup(p_arr in arrayNumType) return arrayNumType
as
    l_res arrayNumType default arrayNumType();
begin
    for x in(
        select distinct * from table(p_arr)
    ) loop
        l_res.extend; l_res(l_res.count) := x.column_value;
    end loop;
    return l_res;
end removeDup;


/*
-- для отрубленных линков, для каждого из двух узлов
    проходим сеть не заходя в отрубленные линки
    если дотекаем до источника - линия подключена
    если источника нет - вся ветка отрублена. в накопитель отключенных.
*/
-- input: arrayNumType of linkid (damped); output: disconnected objects
function getDisconnectedByDampedLinks2(p_links in arrayNumType) return tabTopoObjType
as
    l_res tabTopoObjType default tabTopoObjType();
    l_arrDumpedLinks arrayNumType default null;
    l_startNodes arrayNumType default arrayNumType();
    l_startLinks arrayNumType default arrayNumType();
    l_arrPassedLinks arrayNumType default arrayNumType();
    l_arrPassedNodes arrayNumType default arrayNumType();
    l_haveGrs number default 0;
    l_arrDiscLinks arrayNumType default arrayNumType();
    l_arrDiscNodes arrayNumType default arrayNumType();
begin
    l_arrDumpedLinks := p_links;
for i in 1..l_arrDumpedLinks.count loop
dbg('getDisconnectedByDampedLinks2: input link: ['||l_arrDumpedLinks(i)||']');
end loop;
    addArray2Array(l_arrDumpedLinks, l_arrDiscLinks);

-- получить список узлов для вырубленных линков (без повторов)
-- select startnodeid, endnodeid from topolink where id in (41917);
    for x in (
        select startnodeid, endnodeid from topolink where
            id in (select * from table(l_arrDumpedLinks) )
    ) loop
        push2Array(x.startnodeid, l_startNodes);
        push2Array(x.endnodeid, l_startNodes);
    end loop;
    l_startNodes := removeDup(l_startNodes);

    addArray2Array(l_arrDumpedLinks, l_arrPassedLinks);
-- для каждого узла:
    for i in 1..l_startNodes.count loop
dbg('getDisconnectedByDampedLinks2: start check node: ['||l_startNodes(i)||']');
--	получить список связанных обьектов (до ГРС)
-- туду: не нужно проходить всю сеть, только до первого стопузла !
-- procedure getNodeLinks(p_node in number, p_arrLinks in out nocopy arrayNumType)
        l_startLinks.delete; getNodeLinks(l_startNodes(i), l_startLinks); removeExists(l_arrPassedLinks, l_startLinks);
dbg('getDisconnectedByDampedLinks2: start flow...');
        g_stopNodeType := 'GRS';
        findFirstStopNode(l_startLinks, l_arrPassedLinks, l_arrPassedNodes);
dbg('getDisconnectedByDampedLinks2: end flow.');
--	определяем - есть ГРС?
        l_haveGrs := 0;
        for x in (
            select count(id) grs from toponode where type = 'GRS' and id in
                ( select * from table(l_arrPassedNodes) )
        ) loop
            if x.grs > 0 then l_haveGrs := 1; end if;
        end loop;
--	если есть ГРС (текущ. узел подключен) - очистить список пройденных
--	туду: сохранить в список подключенных (и не очищать список пройденных!)
        if l_haveGrs = 1 then
dbg('getDisconnectedByDampedLinks2: connected.');
            l_arrPassedLinks.delete; l_arrPassedNodes.delete;
            addArray2Array(l_arrDiscLinks, l_arrPassedLinks);
            addArray2Array(l_arrDiscNodes, l_arrPassedNodes);
        else
--	если же нет (текущ. узел отключен) - копируем в список отключенных (без повторов)
--	туду: сравнить список узлов с списком подключенных узлов, если совпадения есть - тоже подключены.
dbg('getDisconnectedByDampedLinks2: disconnected.');
            push2Array(l_startNodes(i), l_arrDiscNodes);
            addArray2Array(l_arrPassedLinks, l_arrDiscLinks);
            addArray2Array(l_arrPassedNodes, l_arrDiscNodes);
            l_arrDiscLinks := removeDup(l_arrDiscLinks);
            l_arrDiscNodes := removeDup(l_arrDiscNodes);
        end if;
dbg('getDisconnectedByDampedLinks2: end check node: ['||l_startNodes(i)||']');
    end loop; -- для каждого узла

dbg('getDisconnectedByDampedLinks2: disconnLinks: ['||l_arrDiscLinks.count||']');
dbg('getDisconnectedByDampedLinks2: disconnNodes: ['||l_arrDiscNodes.count||']');

-- выводим результат:
    for x in (select id, objid, type from toponode where id in (select * from table(l_arrDiscNodes)) ) loop
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;
    for x in (select id, objid, type from topolink where id in (select * from table(l_arrDiscLinks)) ) loop
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;

dbms_output.put_line('getDisconnectedByDampedLinks2 res: ' || l_res.count);
    return l_res;
end getDisconnectedByDampedLinks2;


--	public:	---------------------------------------------------------------

-- вернуть таблицу обьектов связанных с узлом
function getLinkedObjects4Node(p_NodeID in number)
return tabTopoObjType
is
    l_res tabTopoObjType;
    l_arrLinks arrayNumType := arrayNumType();
    l_arrPassedLinks arrayNumType := arrayNumType();
    l_arrPassedNodes arrayNumType := arrayNumType();
begin
    l_res := tabTopoObjType();
--	push2Array(p_BrokenLinkID, l_arrPassedLinks);
    for x in (select id from topolink where startnodeid = p_NodeID or endnodeid = p_NodeID) loop
-- dbg('getLinkedObjects4Node: link id: [' || x.id||']');
        push2Array(x.id, l_arrLinks);
    end loop;
    removeExists(l_arrPassedLinks, l_arrLinks);
    push2Array(p_NodeID, l_arrPassedNodes);

    g_stopNodeType := 'GRS';
--	g_stopNodeType := 'LOCKERS';
    getLinkedTopoObjects(l_arrLinks, l_arrPassedLinks, l_arrPassedNodes);
--	for x in (select id, objid, type from toponode where id in (select * from table(l_arrPassedNodes)) and type in ('GRS', 'GRP') ) loop
    for x in (select id, objid, type from toponode where id in (select * from table(l_arrPassedNodes)) ) loop
--		l_res.extend; l_res(l_res.count) := topoObjRecord(x.id, x.objid, x.type);
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;
    for x in (select id, objid, type from topolink where id in (select * from table(l_arrPassedLinks)) ) loop
--		l_res.extend; l_res(l_res.count) := topoObjRecord(x.id, x.objid, 'PIPE');
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;
    return l_res;
end getLinkedObjects4Node;


--	web app backend:	---------------------------------------------------------------

-- найти линк по координатам точки:
-- input: point Lon,Lat; output: pointed link id in gas network
function getLinkByPoint(p_lon in number, p_lat in number) return number
as
    l_res number default 0;
    l_point sdo_geometry default null;
    l_pipeID number default 0;
    l_pipeGeom sdo_geometry default null;
begin
dbg('getLinkByPoint, lon: ' || p_lon || ', lat: ' || p_lat);
--	l_point := new sdo_geometry(2001, 8192, sdo_point_type(p_lon, p_lat, NULL), NULL, NULL);
    l_point := new sdo_geometry(2001, NULL, sdo_point_type(p_lon, p_lat, NULL), NULL, NULL);
    execute immediate
'SELECT p.id, p.objid, p.geom FROM topolink p WHERE SDO_NN(p.geom, :point, ''sdo_num_res=1'') = ''TRUE'''
    into l_res, l_pipeID, l_pipeGeom using l_point;
dbg('getLinkByPoint: pipeid: ' || l_pipeID||', linkid: ['||l_res||']');
    return l_res;
end getLinkByPoint;


/*
алгоритм простой:
составляем список стопузлов: все узлы типа GRS, GRP, BOIL, BOLT
составляем список линков, от которых плясать
для каждого стартового линка:
    получаем (по алг. растекания) все линки обрамленные узлами запоров. т.е. линки и узлы.
    удаляем дубли, сравнивая с результирующим набором
    добавляем к рез. набору
*/
-- input: comma separated string of linkid (failed); output: list of lockers, damped links
function getLockers4FailedLinks(p_links in varchar2) return tabTopoObjType
as
    l_res tabTopoObjType default tabTopoObjType();
    l_arrLinks arrayNumType default null;
    l_arrPassedLinks arrayNumType := arrayNumType();
    l_arrPassedNodes arrayNumType := arrayNumType();
begin
    l_arrLinks := str2array(p_links, ',');
for i in 1..l_arrLinks.count loop
dbg('getLockers4FailedLinks: input link: ['||l_arrLinks(i)||']');
end loop;
--	g_stopNodeType := 'GRS';
    g_stopNodeType := 'LOCKERS';
    getLinkedTopoObjects(l_arrLinks, l_arrPassedLinks, l_arrPassedNodes);
dbg('passLinks: ['||l_arrPassedLinks.count||'], passNodes: ['||l_arrPassedNodes.count||']');
    for x in (select id, objid, type from toponode where id in (select * from table(l_arrPassedNodes)) ) loop
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;
    for x in (select id, objid, type from topolink where id in (select * from table(l_arrPassedLinks)) ) loop
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;
/*
результирующий набор отключенных линков можно сохранить во временной таблице,
а можно в пакетной переменной. Оба этих способа не работают в режиме базы "шаред".
Поскольку завязаны на сессии.
Это можно обойти, введя уникальный ключ для "приложения" и сохраняя его вместе с набором.
И все это может понадобится из-за ограничения на передаваемые данные в OCI: 4000 байт.
Для SQL запросов к таблицам это обходится, а для запросов к PL/SQL - не нашел как.
Вопрос для исследования.

    execute immediate
    'insert into tempTab select id from table(:atab) where type=''PART'' or type=''WHOLE'''
    using l_res;

FORALL i IN 1 .. iterations -- use FORALL statement
INSERT INTO t2 VALUES (pnums(i), pnames(i));
*/
dbms_output.put_line('getLockers4FailedLinks: res.count: ' || l_res.count);
    return l_res;
end getLockers4FailedLinks;


/*
    найти отключенных потребителей. отключенных от источников газа.
    на входе линки сети, в которых перекрыто течение.
    варианты основного алгоритма
-- для отрубленных линков определяем источники
    от источников течем по сети, не заходя в отрубленные линки
    так находим всех подключенных для набора источников
    вычитаем из полного набора набор подключенных и получаем отключенных
-- для отрубленных линков, для каждого из двух узлов
    проходим сеть не заходя в отрубленные линки
    если дотекаем до источника - линия подключена
    если источника нет - вся ветка отрублена. в накопитель отключенных.
-- для отрубленных линков
    находим связанные линки, не входящие в коллекцию отрубленных (обрамляющие локализацию)
    если направление течения из области локализации - вся ветка отрублена.

    на входе строка: разделенные запятой айди линков, в которых течения нет.
    на выходе: список обьектов газ. сети к которым не поступает газ.
*/
function getDisconnByFailedLinks(p_links in varchar2) return tabTopoObjType
as
    l_res tabTopoObjType default null;
    l_lockers tabTopoObjType default null;
    l_arrDumpedLinks arrayNumType default arrayNumType();
begin
    l_lockers := getLockers4FailedLinks(p_links);
    for x in ( select id from table(l_lockers) where type='PART' or type='WHOLE' ) loop
-- dbg('getDisconnByFailedLinks: linkID: ['||x.id||']');
        push2Array(x.id, l_arrDumpedLinks);
    end loop;
    l_res := getDisconnectedByDampedLinks2(l_arrDumpedLinks);
    return l_res;
end getDisconnByFailedLinks;


-- input: comma separated string of linkid (damped); output: disconnected objects
function getDisconnectedByDampedLinks2(p_links in clob) return tabTopoObjType
as
    l_res tabTopoObjType default tabTopoObjType();
    l_arrDumpedLinks arrayNumType default null;
begin
-- преобразовать строку в массив айди линков
    l_arrDumpedLinks := str2array(p_links, ',');
    l_res := getDisconnectedByDampedLinks2(l_arrDumpedLinks);
    return l_res;
end getDisconnectedByDampedLinks2;


/*
преобразовать строку в массив айди линков
получить список (массив) айди источников для всех указанных линков
получаем массивы подключенных (с учетом вырубленных линков) обьектов
вычитаем из полного списка связанных с источниками список подключенных
*/
-- input: comma separated string of linkid (damped); output: disconnected objects
function getDisconnectedByDampedLinks(p_links in varchar2) return tabTopoObjType
as
    l_res tabTopoObjType default tabTopoObjType();
    l_arrDumpedLinks arrayNumType default null;
    l_arrSources arrayNumType default arrayNumType();
    l_arrLinksStartFlow arrayNumType default arrayNumType();
    l_arrPassedLinks arrayNumType default arrayNumType();
    l_arrPassedNodes arrayNumType default arrayNumType();
    l_arrDiscLinks arrayNumType default arrayNumType();
    l_arrDiscNodes arrayNumType default arrayNumType();
begin
-- преобразовать строку в массив айди линков
    l_arrDumpedLinks := str2array(p_links, ',');
for i in 1..l_arrDumpedLinks.count loop
dbg('getDisconnectedByDampedLinks: input link: ['||l_arrDumpedLinks(i)||']');
end loop;
-- получить список (массив) айди источников для всех указанных линков
    for x in (
        select distinct srcid from toposrc ts where
            ts.objtype = 'LINK' and ts.objid in
            (select * from table(l_arrDumpedLinks)) )
    loop
dbg('getDisconnectedByDampedLinks: srcid: ['||x.srcid||']');
        push2Array(x.srcid, l_arrSources);
        for y in (
            select id from topolink
                where startnodeid = x.srcid
                or endnodeid = x.srcid
        ) loop
dbg('getDisconnectedByDampedLinks: linkStart: ['||y.id||']');
            push2Array(y.id, l_arrLinksStartFlow);
        end loop;
    end loop;
-- получаем массивы подключенных (с учетом вырубленных линков) обьектов
    removeExists(l_arrDumpedLinks, l_arrLinksStartFlow);
    addArray2Array(l_arrDumpedLinks, l_arrPassedLinks);
    g_stopNodeType := 'GRS';
dbg('getDisconnectedByDampedLinks: start flow...');
    getLinkedTopoObjects(l_arrLinksStartFlow, l_arrPassedLinks, l_arrPassedNodes);
dbg('getDisconnectedByDampedLinks: end flow.');
    l_arrPassedLinks := removeDup(l_arrPassedLinks); l_arrPassedNodes := removeDup(l_arrPassedNodes);
    removeExists(l_arrDumpedLinks, l_arrPassedLinks);
dbg('getDisconnectedByDampedLinks: connLinks: ['||l_arrPassedLinks.count||'], connNodes: ['||l_arrPassedNodes.count||']');
-- вычитаем из полного списка связанных с источниками список подключенных
/*
    for x in (
        select distinct objid from toposrc ts where
            (ts.objtype = 'LINK' and ts.srcid in
            (select * from table(l_arrSources)) )
    ) loop
        push2Array(x.objid, l_arrDiscLinks);
    end loop;
dbg('getDisconnectedByDampedLinks: allLinks: ['||l_arrDiscLinks.count||']'); -- 259
    l_arrDiscLinks.delete;
    for x in (
        select distinct objid from toposrc ts where
            (ts.objtype = 'NODE' and ts.srcid in
            (select * from table(l_arrSources)) )
    ) loop
        push2Array(x.objid, l_arrDiscLinks);
    end loop;
dbg('getDisconnectedByDampedLinks: allNodes: ['||l_arrDiscLinks.count||']');
    l_arrDiscLinks.delete;
*/
    for x in (
        select distinct objid from toposrc ts where
            (ts.objtype = 'LINK' and ts.srcid in
            (select * from table(l_arrSources)) )
            and
            (ts.objid not in
            (select distinct * from table(l_arrPassedLinks)) )
    ) loop
        push2Array(x.objid, l_arrDiscLinks);
    end loop;
dbg('getDisconnectedByDampedLinks: disconnLinks: ['||l_arrDiscLinks.count||']'); -- 46
    for x in (
        select distinct objid from toposrc ts where
            (ts.objtype = 'NODE' and ts.srcid in
            (select * from table(l_arrSources)) )
            and
            (ts.objid not in
            (select distinct * from table(l_arrPassedNodes)) )
    ) loop
        push2Array(x.objid, l_arrDiscNodes);
    end loop;
dbg('getDisconnectedByDampedLinks: disconnNodes: ['||l_arrDiscNodes.count||']');

    for x in (select id, objid, type from toponode where id in (select * from table(l_arrDiscNodes)) ) loop
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;
    for x in (select id, objid, type from topolink where id in (select * from table(l_arrDiscLinks)) ) loop
        push2Array(x.id, x.objid, x.type, l_res);
    end loop;

dbms_output.put_line('getDisconnectedByDampedLinks res: ' || l_res.count);
    return l_res;
end getDisconnectedByDampedLinks;

end mogTopo;
/

show errors;
-- package body }


/*
desc toposrc
 Eiy
 ------------------------
 OBJTYPE
 OBJID
 SRCID
select objtype from toposrc group by objtype;
OBJTYPE
----------
NODE
LINK
*/

/*

--	@pl.sql/mogtopo.plsql.package.sql

select object_type, status, object_name from user_objects order by object_type, status, object_name;

select count(*) from table(mogTopo.getLinkedObjects4Node(37));
select * from table(mogTopo.getLinkedObjects4Node(37));
select count(id), type from table(mogTopo.getLinkedObjects4Node(37)) group by type;

select mogTopo.getLinkByPoint(33.33,55.55) LINKID from dual;

select * from table(mogTopo.getLockers4FailedLinks('3,7,17')) order by type, objid, id;
select count(*) from table(mogTopo.getLockers4FailedLinks('54033, 54029'));
select * from table(mogTopo.getLockers4FailedLinks('54033, 54029')) order by type, objid, id;
select count(*) from table(mogTopo.getLockers4FailedLinks('42083'));

select * from table(mogTopo.getDisconnectedByDampedLinks('53968, 53933'));

дебаг - таймер, вывод времени
declare
l_start number default dbms_utility.get_time;
begin
dbms_output.put_line('systimestamp: ['||SYSTIMESTAMP||']');
dbms_output.put_line('sysdate: ['||sysdate||']');
dbms_output.put_line('systime: ['||to_char(sysdate, 'HH24:MI:SS')||']');
dbms_output.put_line
    ( round( (dbms_utility.get_time-l_start)/100, 2 ) ||
    ' seconds...' );
end;
/

запустить на большую сеть (какой линк связан с 33 источниками)
select * from table(mogTopo.getDisconnectedByDampedLinks('42054'));
tm:[03:16:37] getDisconnectedByDampedLinks: linkStart: [37907]
tm:[03:16:37] getDisconnectedByDampedLinks: start flow...
tm:[03:22:19] getDisconnectedByDampedLinks: end flow.
tm:[03:22:19] getDisconnectedByDampedLinks: connLinks: [11900], connNodes: [11725]
tm:[03:27:45] getDisconnectedByDampedLinks: disconnLinks: [1]
tm:[03:33:00] getDisconnectedByDampedLinks: disconnNodes: [0]
getDisconnectedByDampedLinks res: 1
Затрач.время: 00:16:23.73

select * from table(mogTopo.getDisconnectedByDampedLinks('54229'));
select * from table(mogTopo.getDisconnectedByDampedLinks('41233'));

select * from table(mogTopo.getDisconnectedByDampedLinks('41917'));
             ID           OBJID TYPE
--------------- --------------- ----------
          41917            6121 PART
tm:[20:01:14] getDisconnectedByDampedLinks: input link: [41917]
tm:[20:01:14] getDisconnectedByDampedLinks: srcid: [22]
tm:[20:01:14] getDisconnectedByDampedLinks: linkStart: [41721]
tm:[20:01:14] getDisconnectedByDampedLinks: srcid: [26]
tm:[20:01:14] getDisconnectedByDampedLinks: linkStart: [41643]
tm:[20:01:14] getDisconnectedByDampedLinks: linkStart: [40591]
tm:[20:01:14] getDisconnectedByDampedLinks: srcid: [27]
tm:[20:01:14] getDisconnectedByDampedLinks: linkStart: [41654]
tm:[20:01:14] getDisconnectedByDampedLinks: start flow...
tm:[20:01:24] getDisconnectedByDampedLinks: end flow.
tm:[20:01:24] getDisconnectedByDampedLinks: connLinks: [781], connNodes: [778]
tm:[20:01:25] getDisconnectedByDampedLinks: disconnLinks: [1]
tm:[20:01:25] getDisconnectedByDampedLinks: disconnNodes: [0]
getDisconnectedByDampedLinks res: 1
Затрач.время: 00:00:11.18

select * from table(mogTopo.getDisconnectedByDampedLinks2('41917'));
             ID           OBJID TYPE
--------------- --------------- ----------
          41917            6121 PART

tm:[22:05:18] getDisconnectedByDampedLinks2: input link: [41917]
tm:[22:05:18] getDisconnectedByDampedLinks2: start check node: [22541]
tm:[22:05:18] getDisconnectedByDampedLinks2: start flow...
tm:[22:05:26] getDisconnectedByDampedLinks2: end flow.
tm:[22:05:26] getDisconnectedByDampedLinks2: connected.
tm:[22:05:26] getDisconnectedByDampedLinks2: end check node: [22541]
tm:[22:05:26] getDisconnectedByDampedLinks2: start check node: [22571]
tm:[22:05:26] getDisconnectedByDampedLinks2: start flow...
tm:[22:05:34] getDisconnectedByDampedLinks2: end flow.
tm:[22:05:34] getDisconnectedByDampedLinks2: connected.
tm:[22:05:34] getDisconnectedByDampedLinks2: end check node: [22571]
tm:[22:05:34] getDisconnectedByDampedLinks2: disconnLinks: [1]
tm:[22:05:34] getDisconnectedByDampedLinks2: disconnNodes: [0]
getDisconnectedByDampedLinks2 res: 1
Затрач.время: 00:00:15.39


запустить на большую сеть (какой линк связан с 33 источниками)
select * from table(mogTopo.getDisconnectedByDampedLinks2('42054'));
             ID           OBJID TYPE
--------------- --------------- ----------
          42054            6183 PART
tm:[22:06:12] getDisconnectedByDampedLinks2: input link: [42054]
tm:[22:06:12] getDisconnectedByDampedLinks2: start check node: [22673]
tm:[22:06:12] getDisconnectedByDampedLinks2: start flow...
tm:[22:09:20] getDisconnectedByDampedLinks2: end flow.
tm:[22:09:20] getDisconnectedByDampedLinks2: connected.
tm:[22:09:20] getDisconnectedByDampedLinks2: end check node: [22673]
tm:[22:09:20] getDisconnectedByDampedLinks2: start check node: [22672]
tm:[22:09:20] getDisconnectedByDampedLinks2: start flow...
tm:[22:09:20] getDisconnectedByDampedLinks2: end flow.
tm:[22:09:20] getDisconnectedByDampedLinks2: connected.
tm:[22:09:20] getDisconnectedByDampedLinks2: end check node: [22672]
tm:[22:09:20] getDisconnectedByDampedLinks2: disconnLinks: [1]
tm:[22:09:20] getDisconnectedByDampedLinks2: disconnNodes: [0]
getDisconnectedByDampedLinks2 res: 1
Затрач.время: 00:03:08.92

select * from table(mogTopo.getDisconnectedByDampedLinks2('43574,44166,44171,44172,43577,44859,44860,44861,44900,45376,45377'));
tm:[00:06:13] getDisconnectedByDampedLinks2: disconnLinks: [17]
tm:[00:06:13] getDisconnectedByDampedLinks2: disconnNodes: [14]
Затрач.время: 00:00:33.23

select * from table(mogTopo.getDisconnectedByDampedLinks2('42047,42050,42051,42052,42053,42054,42055,42056,42057,55003,55004,59418,59419,59420,59421,59422,59423,59424,54464,54465,55002,55005,55470,55472,55481,55483,55485,55487,55541'));
tm:[00:23:12] getDisconnectedByDampedLinks2: disconnLinks: [94]
tm:[00:23:12] getDisconnectedByDampedLinks2: disconnNodes: [92]
getDisconnectedByDampedLinks2 res: 186
Затрач.время: 00:00:26.45

*/


/*
select * from table(mogTopo.getDisconnectedByDampedLinks2('42881,42967,43016,43017,43018,43023,43024,43049,43050,43105,41954,41955,41956,41957,41969,42725,42728,42729,42730,42731,42732,42734,42736,42738,42740,42742,42743,42744,42745,42746,42747,42748,42749,42750,42751,42752,42753,42754,42755,54836,54837,54838,54839,54840,54841,54842,54843,54844,54845,54846,54847,54848,54849,54850,54851,54852,54853,54854,54855,54858,54865,54866,54871,54872,54873,54874,54875,54876,54877,54878,54879,54889,54890,54891,54892,54893,54894,54895,54896,54897,54899,54900,54901,54902,54903,54913,54915,54919,54923,54925,54926,54927,54928,54929,54930,54931,54932,54933,54934,54935,54936,54937,54938,54939,54940,54941,54942,54943,54944,54945,54946,54947,54948,54949,54950,54951,54952,54953,54954,54955,54956,54957,54958,54959,54960,54961,54962,54963,54964,54965,54966,54967,54968,54970,54971,54972,54327,54328,54329,54330,54973,54974,54975,54976,54987,54988,54989,54990,54991,55006,55007,55008,55009,55010,55011,55012,55013,55014,55015,55016,55017,54331,54334,54335,54336,54337,54338,54353,54357,54367,54371,54372,54373,54374,54375,54376,54377,54378,54379,54381,54382,54383,54384,54385,54388,54389,54390,54391,54392,54393,54394,54395,54396,54397,54440,54441,54442,54443,54444,54445,54446,54447,54448,54449,54466,54467,54468,54469,54470,54471,54472,54473,54474,54475,54476,54477,54478,54479,54480,54481,54482,54483,54484,54485,54486,54487,54488,54489,54490,54491,54492,54493,54494,54495,54496,54497,54498,54499,54500,54501,54502,54503,54504,54505,54506,54507,54517,54518,54519,54520,54521,54522,54523,54524,54525,54526,54527,54528,54529,54530,54531,54532,54533,54534,54535,54536,54537,54538,54539,54540,54541,54542,54589,54590,54591,54592,54593,54594,54595,54596,54597,54598,54599,54600,54601,54602,54603,54604,54605,54606,54607,54608,54609,54610,54611,54612,54613,54614,54615,54616,54617,54618,54619,54620,54621,54622,54623,54624,54628,54629,54630,54631,54632,54633,54634,54635,54636,54637,54638,54639,54640,54641,54642,54643,54644,54645,54646,54647,54648,54649,54650,54651,54652,54653,54654,54655,54656,54657,54658,54659,54660,54661,54662,54663,54664,54665,54666,54667,54668,54669,54670,54671,54672,54673,54674,54675,54676,54677,54678,54679,54680,54681,54682,54683,54684,54685,54686,54687,54688,54689,54690,54691,54692,54693,54694,54695,54696,54697,54698,54699,54700,54701,54702,54703,54704,54705,54706,54707,54708,54709,54710,54711,54712,54713,54714,54715,54716,54717,54718,54719,54720,54721,54722,54723,54724,54725,54726,54727,54728,54729,54730,54731,54732,54733,54734,54735,54736,54737,54738,54739,54740,54741,54742,54743,54744,54745,54746,54747,54748,54749,54750,54751,54752,54753,54754,54755,54756,54757,54758,54759,54760,54761,54762,54763,54764,54765,54766,54767,54768,54769,54770,54771,54772,54773,54774,54775,54776,54777,54778,54779,54780,54781,54782,54783,54784,54785,54786,54787,54788,54789,54790,54791,54792,54793,54794,54795,54796,54797,54798,54799,54800,54801,54802,54803,54804,54805,54806,54807,54808,54809,54810,54811,54812,54813,54814,54815,54816,54817,54818,54819,54820,54821,54822,54823,54824,54825,54826,54827,54828,54829,54830,54831,54832,54833,54834,54835,55018,55019,55020,55023,55024,55025,55026,55027,55028,55029,55030,55031,55032,55033,55034,55052,55053,55054,55055,55056,55057,55058,55059,55060,55061,55062,55063,55064,55065,55066,55067,55068,55069,55070,55071,55072,55073,55074,55075,55076,55077,55078,55079,55080,55081,55082,55083,55084,55085,55086,55087,55088,55089,55090,55091,55092,55093,55094,55095,55096,55097,55098,55099,55100,55101,55102,55103,55104,55105,55106,55107,55108,55109,55826,55827,55828,55110,55111,55112,55113,55114,55115,55116,55117,55118,55119,55120,55121,55122,55123,55124,55125,55126,55127,55128,55129,55130,55131,55132,55133,55134,55135,55136,55137,55138,55139,55140,55141,55142,55143,55144,55145,55146,55147,55148,55149,55150,55151,55152,55153,55154,55155,55156,55157,55158,55159,55160,55161,55162,55163,55164,55165,55166,55167,55168,55169,55170,55171,55172,55173,55222,55223,55224,55234,55235,55236,55238,55239,55240,55241,55242,55243,55244,55245,55246,55247,55248,55249,55250,55251,55252,55253,55254,55255,55256,55257,55258,55259,55260,55261,55262,55263,55264,55265,55266,55267,55268,55269,55270,55271,55272,55273,55274,55275,55276,55277,55278,55279,55280,55281,55286,55287,55288,55289,55290,55291,55292,55293,55294,55295,55296,55297,55298,55299,55300,55301,55302,55303,55304,55305,55307,55308,55309,55310,55311,55313,55314,55315,55316,55318,55321,55322,55323,55325,55326,55327,55328,55329,55330,55331,55332,55333,55334,55335,55336,55337,55339,55340,55341,55349,55350,55351,61770,61771,61772,61773,61784,61785,61786,61787,61788,61789,61790,61797,61816,61817,61818,61819,62551,61855,61857,62300,62301,62302,62303,62304,62305,62306,62307,62308,62309,62310,62311,62312,62313,62314,62315,62331,61691,61692,61693,61694,61695,61696,61697,61698,61699,61700,61701,61702,61703,61704,61705,61706,61707,61708,61709,61710,61711,61712,61714,61715,61716,61717,61718,61719,61720,61721,61722,61723,61724,61725,61726,62405,61727,61728,61729,61730,61731,61732,61733,61734,61735,61736,61737,61738,61739,61740,61741,61742,61743,61746,61747,61748,61749,61750,61751,61752,61753,61754,61755,61756,61757,61758,61759,61760,61761,61762,61763,61764,61765,61766,61767,61768,61769'));

select * from table(mogTopo.getDisconnByFailedLinks('54632'));
52.76
50.70
50.42

*/

create index idx_toponode_all on toponode(id, x, y, type, objid);
create index idx_topolink_all on topolink(id, startnodeid, endnodeid, type, objid);
drop index idx_toponode_all;
drop index idx_topolink_all;
create index idx_topolink_all on topolink(id, startnodeid, endnodeid);
-- разница в две секунды.
