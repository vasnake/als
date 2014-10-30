-- find all flow sources
set serveroutput on size 1000000
set trimspool on
set long 5000
set linesize 123
set pagesize 9999
set numwidth 15
set timing on
set termout on
set wrap off;

-- fill table toposrc
declare
-- fill table toposrc
    l_tabObjects tabTopoObjType default null;
    l_objTypeName varchar2(10) default 'UNDEF';

-- процедура вывода на экран:
procedure dbg(p_str in varchar2)
    as begin dbms_output.put_line('tm:['||to_char(sysdate, 'HH24:MI:SS')||'] '||p_str);
end dbg;


begin
execute immediate
'truncate table toposrc';

-- for x in (select * from toponode where type = 'GRS' and objid=122) loop
for x in (select * from toponode where type = 'GRS' ) loop
dbg('main: get objects in flow, grs objid: ['||x.objid||'], grs node id: ['||x.id||']');
    l_tabObjects := mogTopo.getLinkedObjects4Node(x.id);
dbg('main: linked objects count: ['||l_tabObjects.count||']');
    for y in (select * from table(l_tabObjects) ) loop -- id, objid, type
        if y.type = 'WHOLE' or y.type = 'PART' then
-- dbg('main: have link');
            l_objTypeName := 'LINK';
        else -- GRS, GRP, BOIL, BOLT, JUNC, END
-- dbg('main: have node');
            l_objTypeName := 'NODE';
        end if;
        execute immediate
'insert into toposrc (objtype, objid, srcid) values (:otype, :oid, :sid)'
        using l_objTypeName, y.id, x.id;
    end loop; -- for each topoobject
end loop; -- for each GRS
commit;
-- fill table toposrc
end;
-- fill table toposrc
/
