--web
SELECT externalmemberid, title, givenname, familyname, emailaddress, createddate as joineddate, 'WEB' as type
FROM CARDREGISTRATION
WHERE PRODUCTMGRID IN (22181,22191)
AND CREATEDDATE >= to_date('16/09/2017','dd/mm/yyyy') 
AND CREATEDDATE < to_date('17/11/2017','dd/mm/yyyy')
UNION
-- Kiosk
SELECT externalmemberid, title, givenname, familyname, emailaddress, creationdate as joineddate, 'KIOSK' as type
FROM CARDFULFILMENTREQUEST C
WHERE PICKUPTYPE = 10
AND COMMENTS LIKE '%FROM KIOSK%'
AND PRODUCTMGRID IN (22181,22191)
AND CREATIONDATE >= to_date('16/09/2017','dd/mm/yyyy') 
AND CREATIONDATE < to_date('17/11/2017','dd/mm/yyyy')
UNION
-- FTP    
SELECT externalmemberid, title, givenname, familyname, emailaddress, creationdate as joineddate, 'FTP' as type
FROM CARDFULFILMENTREQUEST
WHERE COMMENTS LIKE '%FTP%'
AND CREATIONDATE >= to_date('16/09/2017','dd/mm/yyyy') 
AND CREATIONDATE < to_date('17/11/2017','dd/mm/yyyy');

--16,912
--17,185
--43

--34140
--34,140

--------------------------------------------------------------------------------
drop table temp_nghitemptable1;

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('16/11/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('17/11/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('16/11/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('17/11/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1

select * from temp_nghitemptable1

with temptable (externalmemberid, productmgrid, laststay) 
as (
select externalmemberid, productmgrid, max(transactiondate) as laststay
 from temp_nghitemptable1
where transactiondate >= to_date('16/11/2016','dd/mm/yyyy')
  and transactiondate < to_date('17/11/2017','dd/mm/yyyy') 
group by externalmemberid, productmgrid
)
select t.*, c.title, c.givenname, c.familyname, c.emailaddress
 from temptable t, member m, customerinformation c
where t.externalmemberid = m.externalmemberid
  and t.productmgrid = m.productmgrid
  and m.personid = c.personid;

-- 177,168

with temptable (externalmemberid, productmgrid, laststay) 
as (
select externalmemberid, productmgrid, max(transactiondate) as laststay
 from temp_nghitemptable1
where transactiondate >= to_date('16/11/2015','dd/mm/yyyy')
  and transactiondate < to_date('17/11/2017','dd/mm/yyyy') 
group by externalmemberid, productmgrid
)
select t.*, c.title, c.givenname, c.familyname, c.emailaddress
 from temptable t, member m, customerinformation c
where t.externalmemberid = m.externalmemberid
  and t.productmgrid = m.productmgrid
  and m.personid = c.personid;

-- 302,282