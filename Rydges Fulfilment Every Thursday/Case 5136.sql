drop table temp_nghitemptable1; 

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.transactiondate, i.operatorid, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861,853,863)
   and i.transactiondate >= to_date('16/09/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('24/09/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union 
select i.terminaltransactionid, i.transactiondate, i.operatorid,  i.externalmemberid, i.productmgrid,i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('16/09/2017','dd/mm/yyyy')
   and i.transactiondate < to_date('24/09/2017','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1;

select * from temp_nghitemptable1 
where transactiondate >= to_date('16/09/2017','dd/mm/yyyy')
  and transactiondate < to_date('17/09/2017','dd/mm/yyyy')
  and operatorid =  48074
  
select * from temp_nghitemptable1 
where transactiondate >= to_date('23/09/2017','dd/mm/yyyy')
  and transactiondate < to_date('24/09/2017','dd/mm/yyyy')
  and operatorid =  48074
  
select * from cardfulfilmentrequest where pickupoperatorid = 48074
and fulfilleddate >= to_date('16/09/2017','dd/mm/yyyy')
and fulfilleddate < to_date('17/09/2017','dd/mm/yyyy')
and comments not like '%KIOSK%'

select * from cardfulfilmentrequest where pickupoperatorid = 48074
and fulfilleddate >= to_date('23/09/2017','dd/mm/yyyy')
and fulfilleddate < to_date('24/09/2017','dd/mm/yyyy')
and comments not like '%KIOSK%'


select t1.*, c.comments 
from temp_nghitemptable1 t1, cardfulfilmentrequest c 
where t1.transactiondate >= to_date('16/09/2017','dd/mm/yyyy')
  and t1.transactiondate < to_date('17/09/2017','dd/mm/yyyy')
  and t1.operatorid =  48074
  and t1.externalmemberid = c.externalmemberid(+)
  and c.packcode in (60,61)
  and c.pickupoperatorid <> 48074

select t1.*, c.comments 
from temp_nghitemptable1 t1, cardfulfilmentrequest c 
where t1.transactiondate >= to_date('23/09/2017','dd/mm/yyyy')
  and t1.transactiondate < to_date('24/09/2017','dd/mm/yyyy')
  and t1.operatorid =  48074
  and t1.externalmemberid = c.externalmemberid(+)
  and c.packcode in (60,61)
  and c.pickupoperatorid <> 48074

select t1.* 
from temp_nghitemptable1 t1 
where t1.transactiondate >= to_date('16/09/2017','dd/mm/yyyy')
  and t1.transactiondate < to_date('17/09/2017','dd/mm/yyyy')
  and t1.operatorid =  48074
  and not exists (select * from cardfulfilmentrequest where externalmemberid = t1.externalmemberid)
  
  
  
drop table temp_nghitemptable2; 

create table temp_nghitemptable2 nologging as
select i.terminaltransactionid, i.transactiondate, i.operatorid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861,853,863)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid
   and i.operatorid = 48074 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.transactiondate, i.operatorid,  i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and i.operatorid = 48074
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;


select * from temp_nghitemptable2

select * from temp_nghitemptable1 t1 
where transactiondate >= to_date('16/09/2017','dd/mm/yyyy')
  and transactiondate < to_date('17/09/2017','dd/mm/yyyy')
  and operatorid =  48074
  and exists (select * from temp_nghitemptable2 t2 where externalmemberid = t1.externalmemberid and t2.transactiondate < to_date('16/09/2017','dd/mm/yyyy')) 
  
select * from temp_nghitemptable1 t1 
where transactiondate >= to_date('23/09/2017','dd/mm/yyyy')
  and transactiondate < to_date('24/09/2017','dd/mm/yyyy')
  and operatorid =  48074
  and exists (select * from temp_nghitemptable2 t2 where externalmemberid = t1.externalmemberid and t2.transactiondate < to_date('23/09/2017','dd/mm/yyyy')) 