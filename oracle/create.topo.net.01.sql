-- create network topology tables
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
построить топологическую сеть:

pipegeom    - трубы
boilgeom    - узлы, потребители, задвижки
boltgeom    - узлы, задвижки
grpgeom     - узлы, потребители, задвижки
grsgeom     - узлы, источники, задвижки

*/

drop sequence seqtopoapps;
create sequence seqtopoapps;

drop table toponode;
create table toponode (
    id number, -- id	уникальный айди узла в топосети
    x number, -- lon	x координата
    y number, -- lat	y координата
    type varchar2(10), -- type	тип узла - GRS, GRP, BOIL, BOLT, JUNC (ТрубоСоединитель), END (хвост трубы)...
    objid number, -- objid	айди обьекта представляемого узлом. например айди ГРС, если узел представляет ГРС.
--	active varchar2(1) default 'Y' -- active	y/n активен или нет. участвует в сети или нет.
    active varchar2(1) -- active	y/n активен или нет. участвует в сети или нет.
);
ALTER TABLE toponode ADD CONSTRAINT pk_toponode PRIMARY KEY(id);
-- drop index idx_toponodecoord;
-- create unique index idx_toponodecoord on toponode(x, y);

drop table topolink;
create table topolink (
    id number, -- id	уникальный айди линка в сети
    startnodeid number, -- startnodeid	айди узла откуда линк выходит
    endnodeid number, -- endnodeid	айди узла куда приходит
--	type varchar2(10) default 'PART', -- type	WHOLE, PART, тип линка. например составной или один к одному соответствует трубе.
    type varchar2(10), -- type	WHOLE, PART, тип линка. например составной или один к одному соответствует трубе.
    objid number, -- objid	айди обьекта, трубы.
--	active varchar2(1) default 'Y', -- active	участвует в сети или нет.
    active varchar2(1), -- active	участвует в сети или нет.
    GEOM  MDSYS.SDO_GEOMETRY
);
alter table topolink add constraint pk_topolink primary key(id);
-- create index idxtopolinknodes on topolink(startnodeid, endnodeid);

DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TOPOLINK' AND COLUMN_NAME = 'GEOM' ;
INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, DIMINFO, SRID)
VALUES ( 'TOPOLINK', 'GEOM', MDSYS.SDO_DIM_ARRAY (
    MDSYS.SDO_DIM_ELEMENT('X', 33.000000000, 41.000000000, 0.000000100),
    MDSYS.SDO_DIM_ELEMENT('Y', 53.000000000, 58.000000000, 0.000000100) ),
NULL);

EXECUTE SDO_MIGRATE.TO_CURRENT('TOPOLINK','GEOM');
select count(*) from (
    SELECT p.id, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(p.geom, 0.0000001) as vld
    FROM topolink p where p.id > 0
    ) where vld <> 'TRUE';
CREATE INDEX idxspat_topolink ON topolink (geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;

drop table toposrc;
create table toposrc (
    objtype varchar2(10), -- type		тип топообьекта NODE, LINK
    objid number, -- id		айди топообьекта из соотв. таблицы узлов или линков
    srcid number -- id		айди NODE, от которого питается обьект (может питаться, газ дотекает) (в нашем случае только ГРС могут быть источниками)
);
create unique index idx_toposrc on toposrc (objtype, objid, srcid);

COMMIT;
