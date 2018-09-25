drop table temp_nghitemptable2;
drop table temp_nghitemptable1;
drop table temp_stayslast2year;
drop table temp_nghitemptable3;

create table temp_nghitemptable2 nologging
as
select * from TEMP_MYOWNVIEW;
-------------------------------------------------------------------------
create table temp_nghitemptable1 nologging as
select M.PRODUCTMGRID, C.GIVENNAME,C.FAMILYNAME,M.EXTERNALMEMBERID,M.SOURCEID,M.MEMBERSHIPLEVEL,M.JOINEDDATE CREATIONDATE
,NVL((SELECT RV.POINTSBALANCE FROM temp_nghitemptable2 RV WHERE RV.EXTERNALMEMBERID = M.EXTERNALMEMBERID AND RV.PRODUCTMGRID = M.PRODUCTMGRID),0) POINTSBALANCE
,M.ENROLMENTCODE,M.COMPANYCODEID,C.EMAILADDRESS,
cm.packcode, cm.cardid, cm.expirydate
from member m, customerinformation c, cardmember cm
where m.productmgrid in (22181,22191)
  and m.externalmemberid like 'R%'
  and m.membershiplevel = 0
  and not exists (select * from cardmember c where c.externalmemberid = m.externalmemberid and c.productmgrid = m.productmgrid and c.cardid like '%6299173%')
  and m.personid = c.personid
  and m.externalmemberid = cm.externalmemberid
  and m.productmgrid = cm.productmgrid
  and cm.status < 50
order by externalmemberid;
-------------------------------------------------------------------------
create table temp_stayslast2year nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.transactiondate >= to_date('01/07/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('01/07/2018','dd/mm/yyyy') 
   and i.issuanceflag = 1;
-------------------------------------------------------------------------
CREATE INDEX temp_temp_stayslast2year_indx ON temp_stayslast2year
(EXTERNALMEMBERID, PRODUCTMGRID)
NOLOGGING;
-------------------------------------------------------------------------
create table temp_nghitemptable3 nologging
as 
select d.*,
(select nvl(count(terminaltransactionid),0) from temp_stayslast2year t where t.externalmemberid = d.externalmemberid and t.productmgrid = d.productmgrid) stays
from temp_nghitemptable1 d
where d.pointsbalance < 20;
-------------------------------------------------------------------------
with datatable as
(
select M.PRODUCTMGRID, C.GIVENNAME,C.FAMILYNAME,M.EXTERNALMEMBERID,M.SOURCEID,M.MEMBERSHIPLEVEL,M.JOINEDDATE CREATIONDATE
,NVL((SELECT RV.POINTSBALANCE FROM temp_nghitemptable2 RV WHERE RV.EXTERNALMEMBERID = M.EXTERNALMEMBERID AND RV.PRODUCTMGRID = M.PRODUCTMGRID),0) POINTSBALANCE
,M.ENROLMENTCODE,M.COMPANYCODEID,C.EMAILADDRESS,
cm.packcode, cm.cardid, cm.expirydate
from member m, customerinformation c, cardmember cm
where m.productmgrid in (22181,22191)
  and m.externalmemberid like 'R%'
  and m.membershiplevel = 0
  and not exists (select * from cardmember c where c.externalmemberid = m.externalmemberid and c.productmgrid = m.productmgrid and c.cardid like '%6299173%')
  and m.personid = c.personid
  and m.externalmemberid = cm.externalmemberid
  and m.productmgrid = cm.productmgrid
  and cm.status < 50
  --and cm.expirydate > sysdate
order by externalmemberid
)
select d.*,
(select count(terminaltransactionid) from temp_stayslast2year t where t.externalmemberid = d.externalmemberid and t.productmgrid = d.productmgrid) stays
from datatable d
where d.pointsbalance < 20;
-------------------------------------------------------------------------
select * from temp_nghitemptable3
where stays >= 2;