-- Star 1 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table temp_nghitemptable1;

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
--   and i.transactiondate >= to_date('24/06/2015','dd/mm/yyyy')
--   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('24/06/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

select distinct externalmemberid, productmgrid from temp_nghitemptable1;

-- Star 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table temp_nghitemptable1;

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('22/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('22/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid; 

select distinct externalmemberid, productmgrid from temp_nghitemptable1;

--select membershiplevel, productmgrid, count(distinct externalmemberid), sum(value) 
select count(distinct externalmemberid), sum(value)
from temp_nghitemptable1
--group by membershiplevel, productmgrid
order by productmgrid, membershiplevel;

-- DOUBLE CHECK Star 2 
select sum(i.value)
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('22/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and exists (select * from cardmember c where c.externalmemberid = i.externalmemberid and c.productmgrid = i.productmgrid and c.status < 50 and c.status <> 9);
   
--   334342
   
select sum(i.loyaltyactualvalue)
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('22/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and exists (select * from cardmember c where c.externalmemberid = i.externalmemberid and c.productmgrid = i.productmgrid and c.status < 50 and c.status <> 9);
   
--   299605
--   633947   
   
-- Star 3 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table temp_nghitemptable1;

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('23/06/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('23/06/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

select distinct externalmemberid, productmgrid from temp_nghitemptable1;

--select membershiplevel, productmgrid, count(distinct externalmemberid), sum(value)
select count(distinct externalmemberid), sum(value) 
from temp_nghitemptable1
--group by membershiplevel, productmgrid
order by productmgrid, membershiplevel;

-- DOUBLE CHECK Star 3
select sum(i.value)
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('23/06/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and exists (select * from cardmember c where c.externalmemberid = i.externalmemberid and c.productmgrid = i.productmgrid and c.status < 50 and c.status <> 9);
   
--   615427
   
select sum(i.loyaltyactualvalue)
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('23/06/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and exists (select * from cardmember c where c.externalmemberid = i.externalmemberid and c.productmgrid = i.productmgrid and c.status < 50 and c.status <> 9);
   
--   588720   
--   1204147
   
-- Star 4 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table temp_nghitemptable2;

create table temp_nghitemptable2 nologging as
select  distinct externalmemberid, productmgrid 
from instantrewsummarytransaction i 
where i.status < 50 
and i.cardprodclassid in (851,861)
and i.transactiondate >= to_date('22/06/2016','dd/mm/yyyy')
and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
and i.suppliertransactiontype < 60000
and i.issuanceflag = 1
union
select  distinct externalmemberid, productmgrid 
from loyaltypntssummarytransaction i 
where i.status < 50 
and i.cardprodclassid in (895,900)
and i.transactiondate >= to_date('22/06/2016','dd/mm/yyyy')
and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
and i.suppliertransactiontype < 60000
and i.issuanceflag = 1;

select distinct externalmemberid, productmgrid
from cardmember c
where c.productmgrid in (22181,22191)
  and c.status < 50 and c.status <> 9
  and c.externalmemberid like 'R%'
  and not exists (select * from temp_nghitemptable2 t where t.externalmemberid = c.externalmemberid and t.productmgrid = c.productmgrid);
   
-- Star 5 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table temp_nghitemptable2;

create table temp_nghitemptable2 nologging as
select  distinct externalmemberid, productmgrid 
from instantrewsummarytransaction i 
where i.status < 50 
and i.cardprodclassid in (851,861)
and i.transactiondate >= to_date('23/06/2015','dd/mm/yyyy')
and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
and i.suppliertransactiontype < 60000
and i.issuanceflag = 1
union
select  distinct externalmemberid, productmgrid 
from loyaltypntssummarytransaction i 
where i.status < 50 
and i.cardprodclassid in (895,900)
and i.transactiondate >= to_date('23/06/2015','dd/mm/yyyy')
and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
and i.suppliertransactiontype < 60000
and i.issuanceflag = 1;

select distinct externalmemberid, productmgrid
from cardmember c
where c.productmgrid in (22181,22191)
  and c.status < 50 and c.status <> 9
  and c.externalmemberid like 'R%'
  and not exists (select * from temp_nghitemptable2 t where t.externalmemberid = c.externalmemberid and t.productmgrid = c.productmgrid);

-- Star 6 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select distinct externalmemberid, productmgrid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/07/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union
select distinct externalmemberid, productmgrid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('01/07/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

--      Eligible room nights
select sum(value)
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/07/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;
   
--      Non eligible nights
select sum(loyaltyactualvalue)
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('01/07/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

-- Star 7 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select distinct externalmemberid, productmgrid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/07/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union
select distinct externalmemberid, productmgrid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('01/07/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

--      Eligible room nights
select sum(value)
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/07/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;
   
--      Non eligible nights
select sum(loyaltyactualvalue)
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('01/07/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;
   
-- Star 8 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select distinct externalmemberid, productmgrid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('15/06/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union
select distinct externalmemberid, productmgrid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('15/06/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

--      Eligible room nights
select sum(value)
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('15/06/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;
   
--      Non eligible nights
select sum(loyaltyactualvalue)
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('15/06/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('22/06/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;
   
-- Star 9 ----------------------------------------------------------------------------------------------------------------------------------------------------------------
select distinct externalmemberid, productmgrid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('16/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.sourcetype not in (2,4,9,15)
   and i.issuanceflag = 1
union
select distinct externalmemberid, productmgrid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('16/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.sourcetype not in (2,4,9,15)
   and i.issuanceflag = 1;

--      Eligible room nights
select sum(value)
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('16/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.sourcetype not in (2,4,9,15)
   and i.issuanceflag = 1;
   
--      Non eligible nights
select sum(loyaltyactualvalue)
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('16/06/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('23/06/2016','dd/mm/yyyy')
   and i.sourcetype not in (2,4,9,15)
   and i.issuanceflag = 1;
   
-- Star 10 ---------------------------------------------------------------------------------------------------------------------------------------------------------------   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('16/06/2016','dd/mm/yyyy')
and createddate < to_date('23/06/2016','dd/mm/yyyy');
   
-- From KIOSK
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('16/06/2016','dd/mm/yyyy')
and creationdate < to_date('23/06/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('16/06/2016','dd/mm/yyyy')
and creationdate < to_date('23/06/2016','dd/mm/yyyy');

-- Star 11 ---------------------------------------------------------------------------------------------------------------------------------------------------------------   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('30/06/2015','dd/mm/yyyy')
and createddate < to_date('23/06/2016','dd/mm/yyyy');
   
-- From KIOSK
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('30/06/2015','dd/mm/yyyy')
and creationdate < to_date('23/06/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('30/06/2015','dd/mm/yyyy')
and creationdate < to_date('23/06/2016','dd/mm/yyyy');

-- Star 12 ---------------------------------------------------------------------------------------------------------------------------------------------------------------
select *
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('16/06/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('23/06/2016','dd/mm/yyyy') 
   and c.packcode in (60,61);

-- Star 13 ---------------------------------------------------------------------------------------------------------------------------------------------------------------
select *
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('30/06/2015','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('23/06/2016','dd/mm/yyyy') 
   and c.packcode in (60,61);

-- Star 14 ---------------------------------------------------------------------------------------------------------------------------------------------------------------
drop table temp_nghitemptable2;

create table temp_nghitemptable2 nologging as
select  distinct externalmemberid, productmgrid 
from instantrewsummarytransaction i 
where i.status < 50 
and i.cardprodclassid in (851,861)
and i.suppliertransactiontype < 60000
and i.issuanceflag = 1
union
select  distinct externalmemberid, productmgrid 
from loyaltypntssummarytransaction i 
where i.status < 50 
and i.cardprodclassid in (895,900)
and i.suppliertransactiontype < 60000
and i.issuanceflag = 1;

select * 
from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('06/08/2014','dd/mm/yyyy')
and creationdate < to_date('13/08/2015','dd/mm/yyyy')
and not exists (select * from temp_nghitemptable2 t where t.externalmemberid = c.externalmemberid and t.productmgrid = c.productmgrid);

-- Star 15 ---------------------------------------------------------------------------------------------------------------------------------------------------------------
select *
from member
where productmgrid in (22181,22191)
and affiliation = 1