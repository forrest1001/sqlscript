select distinct externalmemberid
from cardfulfilmentrequest where packcode in (60,61)
and fulfilleddate >= to_date('15/03/2017','dd/mm/yyyy') 

-- 30,395

select distinct externalmemberid from cardmember
where packcode in (60,61)
and creationdate >= to_date('15/03/2017','dd/mm/yyyy')

-- 30,395

create table temp_nghitemptable1 as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('15/03/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('01/05/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and i.ratecode in ('SALE04','SALE04M','SAL04MT')
union 
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('15/03/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('01/05/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and i.ratecode in ('SALE04','SALE04M','SAL04MT');

select * from temp_nghitemptable1

select c.externalmemberid, p.givenname, p.familyname
from cardfulfilmentrequest c, member m, person p 
where c.packcode in (60,61)
and c.fulfilleddate >= to_date('15/03/2017','dd/mm/yyyy')
and exists (select * from temp_nghitemptable1 where externalmemberid = c.externalmemberid)
and c.externalmemberid = m.externalmemberid
and m.personid = p.personid 

-- 1,678

select c.externalmemberid, p.givenname, p.familyname
from member c, person p
where c.startdate >= to_date('15/03/2017','dd/mm/yyyy')
and exists (select * from temp_nghitemptable1 where externalmemberid = c.externalmemberid)
and c.personid = p.personid

-- 1,366 
