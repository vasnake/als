set serveroutput on size 1000000
set trimspool on
set long 5000
set linesize 170
set pagesize 9999
set numwidth 15
set timing on

/*
select object_type, status, object_name from user_objects
    where object_name not like '%$%'
    order by object_type, status, object_name;
*/

select object_type, status, object_name from user_objects
    where object_name not like '%$%' and object_type = 'TABLE'
    order by object_type, status, object_name;

drop table "ADS";
drop table "BoilerAttr";
drop table "BoltAttr";
drop table "Department";
drop table "GasEquipment";
drop table "GasObjectProperty";
drop table "GasObjectStatus";
drop table "GRPAttr";
drop table "GrpGasEquipGroup";
drop table "GrpHeatEquipGroup";
drop table "GRP_PressureType";
drop table "GrpPurpose";
drop table "GrpSubType";
drop table "GrpType";
drop table "GRSAttr";
drop table "HeatingEquipment";
drop table "PipeArterial";
drop table "PipeAttr";
drop table "PipeLateral";
drop table "PipeStuff";
drop table "PressureType";
drop table "Service";

select object_type, status, object_name from user_objects
    where object_name not like '%$%'
    order by object_type, status, object_name;
