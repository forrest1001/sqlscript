DROP VIEW TEMP_MYOWNVIEW;

/* Formatted on 9/07/2018 10:32:38 AM (QP5 v5.300) */
CREATE OR REPLACE FORCE VIEW TEMP_MYOWNVIEW
(
    GIVENNAME,
    FAMILYNAME,
    EXTERNALMEMBERID,
    PRODUCTMGRID,
    SOURCEID,
    MEMBERSHIPLEVEL,
    PROGRAMSTATUS,
    TEMPORARYMEMBER,
    JOINEDDATE,
    POINTSBALANCE,
    ENROLLMENTCODE,
    COMPANYCODEID,
    EMAILADDRESS
)
AS
    SELECT custInfo.givenname,
           custInfo.familyname,
           m.externalmemberid,
           m.productmgrid,
           m.sourceid,
           membershiplevel,
           m.programstatus,
           0                                    AS temporarymember,
           TO_CHAR (m.joineddate, 'dd/mm/yyyy') joineddate,
           (SELECT COALESCE (
                       SUM (
                           (  (  COALESCE (pointsissued, 0)
                               - COALESCE (pointsreverseissued, 0))
                            - (  COALESCE (pointsredeemed, 0)
                               - COALESCE (pointsreverseredeemed, 0))
                            - (  COALESCE (pointsexpired, 0)
                               - COALESCE (pointsreverseexpired, 0)))),
                       0)
                       balance
              FROM memberpoints
             WHERE     externalmemberid = m.externalmemberid
                   AND productmgrid = m.productmgrid
                   AND cardprodclassid IN (852, 862))
               pointsbalance,
           m.ENROLMENTCODE                      ENROLLMENTCODE,
           (SELECT companycodeid
              FROM cardregistration
             WHERE     externalmemberid = m.externalmemberid
                   AND productmgrid = m.productmgrid)
               COMPANYCODEID,
           custInfo.emailaddress
      FROM MEMBER m, CUSTOMERINFORMATION custInfo
     WHERE     m.productmgrid IN (22181, 22191)
           AND m.externalmemberid LIKE 'R%'
           AND m.personid = custInfo.personid
           AND (m.programstatus = 1 OR m.PROGRAMSTATUS = 3)
           AND (m.sourceid IS NOT NULL AND m.sourceid != 0)
    UNION
    SELECT c.givenname,
           c.familyname,
           c.externalmemberid,
           c.productmgrid,
           c.sourceid,
           0                                    AS membershiplevel,
           c.programstatus,
           1                                    AS temporarymember,
           TO_CHAR (c.joineddate, 'dd/mm/yyyy') joineddate,
           0                                    AS pointsbalance,
           'ONLINE'                             ENROLLMENTCODE,
           c.companycodeid,
           c.emailaddress
      FROM cardregistration c
     WHERE     c.productmgrid IN (22181, 22191)
           AND c.externalmemberid LIKE 'R%'
           AND (c.programstatus = 1 OR c.PROGRAMSTATUS = 3)
           AND (c.sourceid IS NOT NULL AND c.sourceid != 0)
           AND NOT EXISTS
                   (SELECT *
                      FROM MEMBER
                     WHERE     externalmemberid = c.externalmemberid
                           AND productmgrid = c.productmgrid);


drop table temp_nghitemptable2;

create table temp_nghitemptable2 nologging
as
select * from TEMP_MYOWNVIEW;

CREATE INDEX temp_indxtable2 ON temp_nghitemptable2
(productmgrid, externalmemberid)
NOLOGGING;

------------------ MAIN SCRIPT ------------------
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

1,088,661

13,958

13,820

  
16,157 members

1,833

14,324 has no e-card
14,243

14,325

drop table temp_nghitemptable2;

create table temp_nghitemptable2 as
select C.GIVENNAME,C.FAMILYNAME,M.EXTERNALMEMBERID,M.SOURCEID,M.MEMBERSHIPLEVEL,M.JOINEDDATE CREATIONDATE
,NVL((SELECT POINTSBALANCE FROM RYDGESUPDATEDMEMBERVIEW WHERE EXTERNALMEMBERID = M.EXTERNALMEMBERID),0) POINTSBALANCE
,M.ENROLMENTCODE,M.COMPANYCODEID,C.EMAILADDRESS,
cm.packcode, cm.cardid, cm.expirydate
from member m, customerinformation c, cardmember cm
where m.productmgrid in (22181,22191)
  and m.membershiplevel > 0
  and not exists (select * from cardmember c where c.externalmemberid = m.externalmemberid and c.productmgrid = m.productmgrid and c.cardid like '%6299173%')
  and m.personid = c.personid
  and m.externalmemberid = cm.externalmemberid
  and m.productmgrid = cm.productmgrid
  and cm.status = 0
  and cm.expirydate <= sysdate
--order by externalmemberid

drop table temp_nghitemptable1;

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and i.externalmemberid in (select distinct externalmemberid from temp_nghitemptable2)
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50
   and c.status <> 9
   and m.membershiplevel in (1,2)
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;
   
CREATE INDEX temp_nghitemptable1_indx ON temp_nghitemptable1
(EXTERNALMEMBERID, PRODUCTMGRID)
NOLOGGING;

select t.*
, nvl((select count(*)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate),0) stays
, nvl((select sum(value)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate),0) nights
, nvl((select count(*)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2014','dd/mm/yyyy') and transactiondate < to_date('01/01/2015','dd/mm/yyyy') ),0) stays2014
, nvl((select sum(value)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2014','dd/mm/yyyy') and transactiondate < to_date('01/01/2015','dd/mm/yyyy') ),0) nights2014
, nvl((select count(*)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2015','dd/mm/yyyy') and transactiondate < to_date('01/01/2016','dd/mm/yyyy') ),0) stays2015
, nvl((select sum(value)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2015','dd/mm/yyyy') and transactiondate < to_date('01/01/2016','dd/mm/yyyy') ),0) nights2015
, nvl((select count(*)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2016','dd/mm/yyyy') and transactiondate < to_date('01/01/2017','dd/mm/yyyy') ),0) stays2016
, nvl((select sum(value)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2016','dd/mm/yyyy') and transactiondate < to_date('01/01/2017','dd/mm/yyyy') ),0) nights2016
, nvl((select count(*)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2017','dd/mm/yyyy') and transactiondate < to_date('01/01/2018','dd/mm/yyyy') ),0) stays2017
, nvl((select sum(value)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2017','dd/mm/yyyy') and transactiondate < to_date('01/01/2018','dd/mm/yyyy') ),0) nights2017
, nvl((select count(*)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2018','dd/mm/yyyy')),0) stays2018
, nvl((select sum(value)  from  temp_nghitemptable1 where cardprodclassid in (851,861) and externalmemberid = t.externalmemberid and transactiondate >= t.expirydate and transactiondate >= to_date('01/01/2018','dd/mm/yyyy')),0) nights2018
from temp_nghitemptable2 t

select max(expirydate)
from temp_nghitemptable2 t

create table temp_stayslast2year nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.transactiondate >= to_date('01/07/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('01/07/2018','dd/mm/yyyy') 
   and i.issuanceflag = 1;
   
CREATE INDEX temp_temp_stayslast2year_indx ON temp_stayslast2year
(EXTERNALMEMBERID, PRODUCTMGRID)
NOLOGGING; 

drop table temp_nghitemptable1;

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

CREATE INDEX temp_nghitemptable1_indx ON temp_nghitemptable1
(EXTERNALMEMBERID, PRODUCTMGRID)
NOLOGGING; 

with datatable  as
(
select d.*,
(select nvl(count(terminaltransactionid),0) from temp_stayslast2year t where t.externalmemberid = d.externalmemberid and t.productmgrid = d.productmgrid) stays
from temp_nghitemptable1 d
where d.pointsbalance < 20
)
select * from datatable where stays >= 2

1,021,242

drop table temp_nghitemptable3;

create table temp_nghitemptable3 nologging
as 
select d.*,
(select nvl(count(terminaltransactionid),0) from temp_stayslast2year t where t.externalmemberid = d.externalmemberid and t.productmgrid = d.productmgrid) stays
from temp_nghitemptable1 d
where d.pointsbalance < 20

select * from temp_nghitemptable3
where stays > 0

1,021,242
2,529