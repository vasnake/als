-- find all network nodes
set serveroutput on size 1000000
set trimspool on
set long 5000
set linesize 123
set pagesize 9999
set numwidth 15
set timing on
set termout on
set wrap off;

/*
select object_type, status, object_name from user_objects
where object_name not like '%$%'
order by object_type, status, object_name;
*/

/*
-------------------------------------------------------------------------------
    заполнить таблицы данными топологической сети
    -- этап 1
    -- заполн€ем таблицу узлов:
-------------------------------------------------------------------------------
*/

declare
--66	g_tol number default 0.000001;
--91	g_tol number default 0.00001;
--73	g_tol number default 0.000005;
--65	g_tol number default 0.0000001;
    g_tol number default 0.0000001;
--66	g_tol number default 0.00000001;

procedure dbg(p_str in varchar2)
    as begin dbms_output.put_line('tm:['||to_char(sysdate, 'HH24:MI:SS')||'] '||p_str);
end dbg;


-- вносим в таблицу топоузлов toponode набор реальных узлов
-- на входе запрос типа select t.grsid id, t.geom from grs t where t.grsid > 200;
-- и тип обьектов, например 'GRS'
function copyobjtonode(selobjqry in varchar2, objtype in varchar2)
return number
as
    type refcursor_Type is ref cursor;
    cur refcursor_Type;
    recid number default 0;
    recgeom sdo_geometry;
    res number default 0;
    xval number default 0;
    yval number default 0;
    oid number default 0;
begin
open cur for selobjqry;
loop
    fetch cur into recid, recgeom;
    exit when cur%notfound;
    res := res + 1;
    for y in (select t.x, t.y, t.id from table (select sdo_util.getvertices(recgeom) from dual) t) loop
        xval := y.x; yval := y.y; exit;
    end loop;
    select seqtopoapps.nextval nv into oid from dual;
    execute immediate
'insert into toponode(id, x, y, type, objid) values(:seqnextval, :xval, :yval, :objtype, :recid)'
    using oid, xval, yval, objtype, recid;
end loop;
close cur;
    return res;
end copyobjtonode;


-- процедура заливки реальных грс и грп в таблицу узлов:
procedure copyRealNodes2topo
as
    l_numobj number default 0;
begin
    l_numobj := copyobjtonode('select t.grsid id, t.geom from grsgeom t', 'GRS');
dbg('ins. GRS nodes: ' || l_numobj);

    l_numobj := copyobjtonode('select t.grpid id, t.geom from grpgeom t', 'GRP');
dbg('ins. GRP nodes: ' || l_numobj);

    l_numobj := copyobjtonode('select t.boilerid id, t.geom from boilgeom t', 'BOIL');
dbg('ins. BOIL nodes: ' || l_numobj);

    l_numobj := copyobjtonode('select t.boltid id, t.geom from boltgeom t', 'BOLT');
dbg('ins. BOLT nodes: ' || l_numobj);

end copyRealNodes2topo;


-- return point of intersect btw 2 lines
function getIntersectionPoint(g1 in sdo_geometry, g2 in sdo_geometry)
return sdo_geometry
as
    res sdo_geometry default null;
    numip number default 0;
begin
--	select SDO_GEOM.SDO_INTERSECTION(g1, g2, 0.0000001) pi into res from dual;
    select SDO_GEOM.SDO_INTERSECTION(g1, g2, g_tol) pi into res from dual;
    select sdo_util.getnumelem(res) into numip from dual;
    if numip > 1 then
        dbg('ERR! multiple intersect: ' || numip);
    end if;
    return res;
end getIntersectionPoint;


-- вставка в "таблицу узлов" нового узла. если с такими координатами узел есть, не вставл€ть.
function insertNodeWithCoordsCheck(p_x in number, p_y in number, p_type in varchar2, p_objid in number, p_tol in number)
return number
as
    l_res number default 0;
    l_xmax number default p_x + p_tol;
    l_xmin number default p_x - p_tol;
    l_ymax number default p_y + p_tol;
    l_ymin number default p_y - p_tol;
begin
    execute immediate
'select count(id) from toponode where x >= :xmin and x <= :xmax and y >= :ymin and y <= :ymax'
    into l_res using in l_xmin, in l_xmax, in l_ymin, in l_ymax;
    if l_res = 0 then
        insert into toponode(id, x, y, type, objid) values(seqtopoapps.nextval, p_x, p_y, p_type, p_objid);
    end if;
    return l_res;
end insertNodeWithCoordsCheck;


-- заливка псевдоузлов:
-- вносим в таблицу узлов все точки пересечени€ и концы. удал€€ дубли узлов:
procedure copyJuncNodes2Topo
as
    l_ip sdo_geometry default null;
    l_resnumber number default 0;
    l_numJuncEQNode number default 0;
    l_numPoints number default 0;
begin
for x in (select * from pipegeom order by pipeid) loop
-- вставл€ем точку пересечени€ труб:
    for y in (select * from pipegeom where sdo_relate(geom, x.geom, 'mask=touch')='TRUE') loop
        l_ip := getIntersectionPoint(x.geom, y.geom);
--		l_resnumber := insertNodeWithCoordsCheck(l_ip.sdo_ordinates(1), l_ip.sdo_ordinates(2), 'JUNC', x.pipeid, 0.000000001);
        l_resnumber := insertNodeWithCoordsCheck(l_ip.sdo_ordinates(1), l_ip.sdo_ordinates(2), 'JUNC', x.pipeid, g_tol);
        if l_resnumber > 0 then
            l_numJuncEQNode := l_numJuncEQNode + 1;
-- dbms_output.put_line('junc point EQ node, pipeid: ' || x.pipeid || ', count: ' || l_resnumber);
        end if;
    end loop;
-- вставл€ем начальную и конечную точки линии
    select sdo_util.getnumvertices(x.geom) nv into l_numPoints from dual;
    for y in (select t.x, t.y, t.id from table (select sdo_util.getvertices(x.geom) from dual) t) loop
        if y.id = 1 or y.id = l_numPoints then
--			l_resnumber := insertNodeWithCoordsCheck(y.x, y.y, 'END', x.pipeid, 0.000000001);
            l_resnumber := insertNodeWithCoordsCheck(y.x, y.y, 'END', x.pipeid, g_tol);
            if l_resnumber > 0 then
                l_numJuncEQNode := l_numJuncEQNode + 1;
            end if;
        end if;
    end loop;
end loop;
dbg('found junc points EQ nodes: ' || l_numJuncEQNode);
end copyJuncNodes2Topo;


begin
    execute immediate 'truncate table toponode';

-- пишем все реальные узлы в таблицу.
    copyRealNodes2topo;
    commit;
    execute immediate 'create unique index tmp_idx_toponodecoord on toponode(x, y)';

-- находим все псевдоузлы
    copyJuncNodes2Topo;
    commit;

    execute immediate 'drop index tmp_idx_toponodecoord';
end;
/
