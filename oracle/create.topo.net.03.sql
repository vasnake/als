-- find all network links
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
-------------------------------------------------------------------------------
    2. этап: заполнить таблицу линков

    id number, -- id	уникальный айди линка в сети
    startnodeid number, -- startnodeid	айди узла откуда линк выходит
    endnodeid number, -- endnodeid	айди узла куда приходит
    type varchar2(10) default 'PART', -- type	WHOLE, PART, тип линка. например составной или один к одному соответствует трубе.
    objid number, -- objid	айди обьекта, трубы.
    active varchar2(1) default 'Y', -- active	участвует в сети или нет.
    GEOM  MDSYS.SDO_GEOMETRY	--	выдрать из труб сегменты между узлами и записать сюда.
-------------------------------------------------------------------------------
*/


/*
алгоритм:
для каждой вершины трубы:
если вершина не попадает на узел то
    вершина добавляется в массив вершин линка
    количество сегментов увелич. на 1
иначе (вершина попадает на узел) то
    вершина добавляется в массив вершин линка
    если начальный узел не проинициализирован то
        устанавливается нач. узел
        сбрасывается количество сегментов
    иначе (нач. узел проинициализирован) то
        устанавливается конечный узел
        пишется линк в таблицу
        массив вершин инициализируется вершиной
        устанавливается нач. узел
        сбрасывается количество сегментов
    количество сегментов увелич. на 1
*/
declare
--66	g_tol number default 0.000001;
--91	g_tol number default 0.00001;
--73	g_tol number default 0.000005;
--65	g_tol number default 0.0000001;
    g_tol number default 0.0000001;
--66	g_tol number default 0.00000001;
    type arrayNumType is table of number;
    l_nodeonpoint number default 0;
    l_arraySeg arrayNumType := arrayNumType();
    l_startnode number default 0;
    l_endnode number default 0;
    l_numvertices number default 0;
    l_linktype varchar2(10) default 'PART';
    l_ordinates sdo_ordinate_array := sdo_ordinate_array();

-- процедура вывода на экран:
procedure dbg(p_str in varchar2)
    as begin dbms_output.put_line('tm:['||to_char(sysdate, 'HH24:MI:SS')||'] '||p_str);
end dbg;


-- добавить элемент к массиву
procedure push2Array(p_num in number, p_arr in out nocopy arrayNumType)
as
begin
    p_arr.extend; p_arr(p_arr.last) := p_num;
end push2Array;

procedure push2Array(p_x in number, p_y in number, p_arr in out nocopy sdo_ordinate_array)
as
begin
-- dbg('push2Array 1, ordinates.count: [' || p_arr.count || ']');
    p_arr.extend; p_arr(p_arr.last) := p_x;
    p_arr.extend; p_arr(p_arr.last) := p_y;
-- dbg('push2Array 2, x: [' || p_x || '], y: [' || p_y || ']');
-- dbg('push2Array 3, ordinates.count: [' || p_arr.count || ']');
end push2Array;


-- найти узел по его координатам
function getTopoNodeByCoords(p_x in number, p_y in number, p_tol in number)
return number
as
    l_res number default 0;
    l_xmax number default p_x + p_tol;
    l_xmin number default p_x - p_tol;
    l_ymax number default p_y + p_tol;
    l_ymin number default p_y - p_tol;
begin
    execute immediate
'select id from toponode where x >= :xmin and x <= :xmax and y >= :ymin and y <= :ymax and rownum < 2'
    into l_res using in l_xmin, in l_xmax, in l_ymin, in l_ymax;
-- dbg('getTopoNodeByCoords: node: ['||l_res||']');
    return l_res;
exception
    when others then
    l_res := 0;
-- dbg('getTopoNodeByCoords exept.: node: ['||l_res||']');
    return l_res;
end getTopoNodeByCoords;

-- найти узел по его координатам
function getTopoNodeByCoordsEx(p_x in number, p_y in number, p_tol in number)
return number
as
    l_res number default 0;
    l_xmax number default p_x + p_tol;
    l_xmin number default p_x - p_tol;
    l_ymax number default p_y + p_tol;
    l_ymin number default p_y - p_tol;
    l_minLen number default 999.999;
    l_len number default 0.0;
begin
-- dbg('getTopoNodeByCoordsEx: xmin: ['||l_xmin||'], xmax: ['||l_xmax||'], ymin: ['||l_ymin||'], ymax: ['||l_ymax||']');
    for x in(
        select * from toponode where
            x between l_xmin and l_xmax
            and y between l_ymin and l_ymax
            and type not in ('JUNC', 'END')
    ) loop
        l_len := ((x.x - p_x)*(x.x - p_x)) + ((x.y - p_y)*(x.y - p_y));
        if l_len < l_minLen then
            l_minLen := l_len;
            l_res := x.id;
        end if;
    end loop;
    return l_res;
end getTopoNodeByCoordsEx;


-- записать линк в таблицу (nodeID, nodeID, linkTYPE, OID, arrPipePointID)
procedure writeLink2Topo(p_node1 in number, p_node2 in number, p_type in varchar2, p_objid in number, p_arrseg in arrayNumType)
as
    l_oid number default 0;
begin
-- dbg('writeLink2Topo: wrong link commit method!');
    select seqtopoapps.nextval nv into l_oid from dual;
    execute immediate
'insert into topolink(id, startnodeid, endnodeid, type, objid)
    values(:seqnextval, :startnode, :endnode, :objtype, :obj)'
    using l_oid, p_node1, p_node2, p_type, p_objid;
commit;
end writeLink2Topo;

procedure writeLink2Topo(p_node1 in number, p_node2 in number, p_type in varchar2, p_objid in number, p_arrseg in arrayNumType, p_ordinates in sdo_ordinate_array)
as
    l_oid number default 0;
    l_geom sdo_geometry default null;
begin
--	l_geom := new sdo_geometry(2002, 8192, NULL, SDO_ELEM_INFO_ARRAY(1, 2, 1), p_ordinates);
    l_geom := new sdo_geometry(2002, NULL, NULL, SDO_ELEM_INFO_ARRAY(1, 2, 1), p_ordinates);
    select seqtopoapps.nextval nv into l_oid from dual;
if p_ordinates.count < 4 then
dbg('writeLink2Topo: ordinates.count: [' || p_ordinates.count || '], oid: ['||p_objid||'], id: ['||l_oid||']');
dbg('writeLink2Topo: segm.count: [' || p_arrseg.count || ']');
end if;
    execute immediate
'insert into topolink(id, startnodeid, endnodeid, type, objid, geom)
    values(:seqnextval, :startnode, :endnode, :objtype, :obj, :objgeom)'
    using l_oid, p_node1, p_node2, p_type, p_objid, l_geom;
commit;
end writeLink2Topo;


--	BEGIN:	---------------------------------------------------------------
begin
execute immediate 'truncate table topolink';
commit;
execute immediate 'create unique index tmp_idx_toponodecoord on toponode(x, y)';
execute immediate 'drop INDEX idxspat_topolink';

-- для каждой трубы находим все узлы и сегменты между узлами
-- for x in (select * from pipegeom where pipeid = 15631 order by pipeid) loop
for x in (select * from pipegeom order by pipeid) loop
    l_startnode := 0; l_endnode := 0; l_arraySeg.delete; l_ordinates := sdo_ordinate_array();
    select sdo_util.getnumvertices(x.geom) nv into l_numvertices from dual;
    for y in (select t.x, t.y, t.id from table (select sdo_util.getvertices(x.geom) from dual) t order by id) loop
        push2Array(y.x, y.y, l_ordinates);
--		l_nodeonpoint := getTopoNodeByCoords(y.x, y.y, 0.000000001);
--		l_nodeonpoint := getTopoNodeByCoords(y.x, y.y, g_tol);
        l_nodeonpoint := getTopoNodeByCoordsEx(y.x, y.y, (g_tol*10));
        if l_nodeonpoint <= 0 then
            l_nodeonpoint := getTopoNodeByCoords(y.x, y.y, g_tol);
-- dbg('main: no real node, juncORend nodeid: ['||l_nodeonpoint||']');
        end if;
        if l_nodeonpoint > 0 then
-- dbg('main: pipe point on node, process link');
            if l_startnode <> 0 then
-- dbg('main: end node, commit link');
                l_endnode := l_nodeonpoint;
                if l_arraySeg.count < l_numvertices - 1 then
                    l_linktype := 'PART';
                else
                    l_linktype := 'WHOLE';
                end if;
                -- write2topolink and topolinkseg
                writeLink2Topo(l_startnode, l_endnode, l_linktype, x.pipeid, l_arraySeg, l_ordinates);
-- dbg('main: clear ordinate_arr');
                l_ordinates := sdo_ordinate_array();
                push2Array(y.x, y.y, l_ordinates);
            end if;
-- dbg('main: set start node');
            l_startnode := l_nodeonpoint;
            l_arraySeg.delete;
        else
            if y.id = 1 or y.id = l_numvertices then
dbg('main: ERROR? pipe point not on node, point is first or last');
dbg('-- oid: ['||x.pipeid||'], lon: ['||y.x||'], lat: ['||y.y||']');
            end if;
        end if;
        push2Array(y.id, l_arraySeg);
    end loop;
end loop;
commit;

execute immediate 'drop index tmp_idx_toponodecoord';
execute immediate 'CREATE INDEX idxspat_topolink ON topolink (geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX';
end;
/

create index idx_topolink_all on topolink(id, startnodeid, endnodeid);

select count(id), vld from (
    SELECT p.id, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(p.geom, 0.00000001) as vld
    FROM topolink p where p.id > 0
) where vld <> 'TRUE' group by vld;

select (select count(id) from toponode) as allnodes,
    ( select count(id)
      from toponode
      where id in (select distinct startnodeid from topolink
        union all
        select distinct endnodeid from topolink
    )  ) as linkednodes
    from dual;

select  (select count(id) from toponode) - ( select count(id)
      from toponode
      where id in (select distinct startnodeid from topolink
        union all
        select distinct endnodeid from topolink )
    )
    as orphannodes from dual;

select count(n.id) from toponode n;
select count(n.id)
  from toponode n
  where n.id in (select distinct startnodeid from topolink
    union all
    select distinct endnodeid from topolink
);

select count(id), type
    from toponode
    group by type order by type;

