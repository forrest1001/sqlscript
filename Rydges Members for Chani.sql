-- members with cards
select m.productmgrid, count(m.externalmemberid)
from member m
where m.externalmemberid like 'R%'
group by m.productmgrid;

-- non-active members
select c.productmgrid, count(distinct externalmemberid) 
from cardregistration c
where not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid)
and c.productmgrid in (22181,22191) 
group by c.productmgrid;

-- Total number of members with active card 
select m.productmgrid, count(m.externalmemberid)
from cardmember c, member m
where c.productmgrid in (22181,22191) 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid
   and c.externalmemberid like 'R%'
group by m.productmgrid;

drop table temp_memberstay;

create table temp_memberstay nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
--   and i.transactiondate >= to_date('01/08/2016','dd/mm/yyyy')
--   and i.transactiondate < to_date('01/08/2017','dd/mm/yyyy')
union
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
--   and i.transactiondate >= to_date('01/08/2016','dd/mm/yyyy')
--   and i.transactiondate < to_date('01/08/2017','dd/mm/yyyy')
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
--   and i.transactiondate >= to_date('01/08/2016','dd/mm/yyyy')
--   and i.transactiondate < to_date('01/08/2017','dd/mm/yyyy');

-- Total member stayed from <> to <> (count of distinct members) - ALL
select productmgrid, count(distinct externalmemberid), sum(value) from temp_memberstay
group by productmgrid;

-- Total member stayed from <> to <> (count of distinct members) - ELIGIBLE NIGHTS ONLY
select productmgrid, count(distinct externalmemberid), sum(value) from temp_memberstay
where cardprodclassid in (851,861) 
group by productmgrid;

-- Total member stayed from <> to <> (count of distinct members) - NON-ELIGIBLE NIGHTS + FREE NIGHTS
select productmgrid, count(distinct externalmemberid), sum(value) from temp_memberstay
where cardprodclassid in (853,863,895,900)
group by productmgrid;



-- Total members redeemed points from <> to <> (count of distinct members)
select i.productmgrid, count(distinct i.externalmemberid), sum(value)
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (852,862)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
--   and i.transactiondate >= to_date('01/08/2016','dd/mm/yyyy')
--   and i.transactiondate < to_date('01/08/2017','dd/mm/yyyy')
group by productmgrid;


drop table temp_memberearned;

create table temp_memberearned nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (852,862)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

-- Total member earn from <> to <> (count of distinct members)
select productmgrid, count(distinct externalmemberid), sum(value) from temp_memberearned
group by productmgrid;