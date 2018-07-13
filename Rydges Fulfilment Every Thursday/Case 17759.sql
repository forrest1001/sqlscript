drop table temp_nghitemptable1;

-- List all stays of members
create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,852)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and transactiondate >= to_date('01/01/2014','dd/mm/yyyy')
   and transactiondate < to_date('01/07/2018','dd/mm/yyyy') 
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (901)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and transactiondate >= to_date('01/01/2014','dd/mm/yyyy')
   and transactiondate < to_date('01/07/2018','dd/mm/yyyy');
   
CREATE INDEX temp_nghitemptable1_indx ON temp_nghitemptable1
(EXTERNALMEMBERID, PRODUCTMGRID)
NOLOGGING;



select * from cardprodclassview
where cardprodclassid in (852,851,901)


select to_char(transactiondate, 'YYYYMM') month, sum(value) sum852
from temp_nghitemptable1
where cardprodclassid = 852
group by to_char(transactiondate, 'YYYYMM')
order by to_char(transactiondate, 'YYYYMM');

select to_char(transactiondate, 'YYYYMM') month, sum(value) sum851
from temp_nghitemptable1
where cardprodclassid = 851
group by to_char(transactiondate, 'YYYYMM')
order by to_char(transactiondate, 'YYYYMM');

select to_char(transactiondate, 'YYYYMM') month, count(terminaltransactionid) count851
from temp_nghitemptable1
where cardprodclassid = 851
group by to_char(transactiondate, 'YYYYMM')
order by to_char(transactiondate, 'YYYYMM');

select to_char(transactiondate, 'YYYYMM') month, sum(value) sum901
from temp_nghitemptable1
where cardprodclassid = 901
group by to_char(transactiondate, 'YYYYMM')
order by to_char(transactiondate, 'YYYYMM');