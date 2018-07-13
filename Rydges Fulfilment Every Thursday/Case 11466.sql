drop table temp_nghitemptable1; 
create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/02/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/02/2018','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('01/02/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/02/2018','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

select to_char(transactiondate, 'YYYYMM') month, count(distinct externalmemberid) membersstayed 
from temp_nghitemptable1
group by to_char(transactiondate, 'YYYYMM');

with datatable as(
select externalmemberid, max(transactiondate) laststay
from temp_nghitemptable1
group by externalmemberid)
select to_char(laststay, 'YYYYMM') laststaymonth, count(distinct externalmemberid)
from datatable
group by to_char(laststay, 'YYYYMM')


-- Another way
with datatablemain as
(
select externalmemberid, to_char(laststay, 'YYYYMM') laststaymonth
from (select externalmemberid, max(transactiondate) laststay
from temp_nghitemptable1
group by externalmemberid)
)
select laststaymonth, count(distinct externalmemberid) members
from datatablemain
group by laststaymonth
order by laststaymonth


drop table temp_nghitemptable2;
create table temp_nghitemptable2 as
select t.*, m.membershiplevel
from temp_nghitemptable1 t, member m
where t.externalmemberid = m.externalmemberid
and t.productmgrid = m.productmgrid;
--696,163

select to_char(transactiondate, 'YYYYMM') month, membershiplevel, count(distinct externalmemberid) membersstayed 
from temp_nghitemptable2
group by to_char(transactiondate, 'YYYYMM'), membershiplevel
order by to_char(transactiondate, 'YYYYMM'), membershiplevel;

with datatable as(
select externalmemberid, membershiplevel, max(transactiondate) laststay
from temp_nghitemptable2
group by externalmemberid, membershiplevel)
select to_char(laststay, 'YYYYMM') laststaymonth, membershiplevel, count(distinct externalmemberid)
from datatable
group by to_char(laststay, 'YYYYMM'), membershiplevel

select externalmemberid, membershiplevel, max(transactiondate) laststay
from temp_nghitemptable2
group by externalmemberid, membershiplevel
order by externalmemberid