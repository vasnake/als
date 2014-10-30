-- update metadata, indexes; check geometry

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
-- блок добавляет метаданные для простр. таблиц, создает индексы
*/

declare

procedure add_geom_meta(p_tabname in varchar2, p_pkfieldname in varchar2)
as
    l_res number default 0;
begin
dbms_output.put_line('table ' || p_tabname || ', begin...');
-- убить простр. индекс
    begin
        execute immediate
    'drop index idxspat_' || p_tabname;
    EXCEPTION WHEN OTHERS THEN dbms_output.put_line('plsql block 1.0 - oops, ' || SQLERRM);
    end;
-- убить первичн. ключ
    begin
        execute immediate
    'alter table ' || p_tabname || ' drop constraint pk_' || p_tabname;
    EXCEPTION WHEN OTHERS THEN dbms_output.put_line('plsql block 1.1 - oops, ' || SQLERRM);
    end;

dbms_output.put_line('table ' || p_tabname || ', begin 2...');
-- создать метаданные и индексы
    execute immediate
'begin

DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = ''' || p_tabname || ''' AND COLUMN_NAME = ''GEOM'';

INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, DIMINFO, SRID)
VALUES ( ''' || p_tabname || ''', ''GEOM'', MDSYS.SDO_DIM_ARRAY (
    MDSYS.SDO_DIM_ELEMENT(''X'', 33.000000000, 41.000000000, 0.000000100),
    MDSYS.SDO_DIM_ELEMENT(''Y'', 53.000000000, 58.000000000, 0.000000100) ),
NULL);

SDO_MIGRATE.TO_CURRENT(''' || p_tabname || ''',''GEOM'');

execute immediate ''CREATE INDEX idxspat_' || p_tabname || '
ON ' || p_tabname || ' (geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX'';

execute immediate ''ALTER TABLE ' || p_tabname || ' ADD CONSTRAINT pk_' || p_tabname || '
PRIMARY KEY(' || p_pkfieldname || ')'';

end;';

-- проверить валидность простр. данных
    execute immediate
'select count(*) from (SELECT p.' || p_pkfieldname || ', SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(p.geom, 0.0000001) as
vld FROM ' || p_tabname || ' p where p.' || p_pkfieldname || ' > 0) where vld <> ''TRUE'''
    into l_res;

dbms_output.put_line('table ' || p_tabname || ', invalid row count: ' || l_res);
    commit;
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('plsql block 2 - oops, ' || SQLERRM);
end add_geom_meta;

-- даем задачку:
begin
    add_geom_meta('BOIL', 'boilerid');
    add_geom_meta('BOILGEOM', 'boilerid');
    add_geom_meta('BOLT', 'boltid');
    add_geom_meta('BOLTGEOM', 'boltid');
    add_geom_meta('GRP', 'grpid');
    add_geom_meta('GRPGEOM', 'grpid');
    add_geom_meta('GRS', 'grsid');
    add_geom_meta('GRSGEOM', 'grsid');
    add_geom_meta('PIPE', 'pipeid');
    add_geom_meta('PIPEGEOM', 'pipeid');
end; -- declare
/
