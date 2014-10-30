-- filter actual data

drop table pipegeom;
create table pipegeom as
select * from pipe pp
where pp.pipeid in(
    select pa.pipeid from "PipeAttr" pa where pa.pressuretypeid <> 5 and pa.gasobjstatusid = 4
);

drop table boilgeom;
create table boilgeom as
select * from boil bb
where bb.boilerid in (
    select ba.boilerid from "BoilerAttr" ba where ba.gasobjstatusid = 4
);

drop table boltgeom;
create table boltgeom as
select * from bolt bb
where bb.boltid in (
    select ba.boltid from "BoltAttr" ba
);

drop table grpgeom;
create table grpgeom as
select * from grp gg
where gg.grpid in (
    select ga.grpid from "GRPAttr" ga where ga.gasobjstatusid = 4
);

drop table grsgeom;
create table grsgeom as
select * from grs gg
where gg.grsid in (
    select ga.grsid from "GRSAttr" ga
);

commit;

-- двойные записи:
select * from (
select count(geom) co, pipeid id from pipegeom group by pipeid
) where co > 1;

select * from (
select count(geom) co, grsid id from grsgeom group by grsid
) where co > 1;

select * from (
select count(geom) co, grpid id from grpgeom group by grpid
) where co > 1;


select * from (
select count(geom) co, boilerid id from boilgeom group by boilerid
) where co > 1;

select * from (
select count(geom) co, boltid id from boltgeom group by boltid
) where co > 1;
