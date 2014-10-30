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
��������� �������������� ����:

pipegeom    - �����
boilgeom    - ����, �����������, ��������
boltgeom    - ����, ��������
grpgeom     - ����, �����������, ��������
grsgeom     - ����, ���������, ��������

*/

drop sequence seqtopoapps;
create sequence seqtopoapps;

drop table toponode;
create table toponode (
    id number, -- id	���������� ���� ���� � ��������
    x number, -- lon	x ����������
    y number, -- lat	y ����������
    type varchar2(10), -- type	��� ���� - GRS, GRP, BOIL, BOLT, JUNC (����������������), END (����� �����)...
    objid number, -- objid	���� ������� ��������������� �����. �������� ���� ���, ���� ���� ������������ ���.
--	active varchar2(1) default 'Y' -- active	y/n ������� ��� ���. ��������� � ���� ��� ���.
    active varchar2(1) -- active	y/n ������� ��� ���. ��������� � ���� ��� ���.
);
ALTER TABLE toponode ADD CONSTRAINT pk_toponode PRIMARY KEY(id);
-- drop index idx_toponodecoord;
-- create unique index idx_toponodecoord on toponode(x, y);

drop table topolink;
create table topolink (
    id number, -- id	���������� ���� ����� � ����
    startnodeid number, -- startnodeid	���� ���� ������ ���� �������
    endnodeid number, -- endnodeid	���� ���� ���� ��������
--	type varchar2(10) default 'PART', -- type	WHOLE, PART, ��� �����. �������� ��������� ��� ���� � ������ ������������� �����.
    type varchar2(10), -- type	WHOLE, PART, ��� �����. �������� ��������� ��� ���� � ������ ������������� �����.
    objid number, -- objid	���� �������, �����.
--	active varchar2(1) default 'Y', -- active	��������� � ���� ��� ���.
    active varchar2(1), -- active	��������� � ���� ��� ���.
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
    objtype varchar2(10), -- type		��� ����������� NODE, LINK
    objid number, -- id		���� ����������� �� �����. ������� ����� ��� ������
    srcid number -- id		���� NODE, �� �������� �������� ������ (����� ��������, ��� ��������) (� ����� ������ ������ ��� ����� ���� �����������)
);
create unique index idx_toposrc on toposrc (objtype, objid, srcid);

COMMIT;
