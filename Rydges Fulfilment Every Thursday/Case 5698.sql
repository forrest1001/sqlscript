drop table temp_nghitemptable1; 

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.operatorid, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861,853,863)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union 
select i.terminaltransactionid, i.transactiondate, i.operatorid,  i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

select distinct externalmemberid from temp_nghitemptable1
where operatorid in (25471,25468,48069,47063,25465,46948,47066);
