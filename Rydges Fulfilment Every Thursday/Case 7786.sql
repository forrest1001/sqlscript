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
   and c.productmgrid = m.productmgrid
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
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

select m.externalmemberid, m.productmgrid, m.membershiplevel, c.cardid, c.expirydate, ci.givenname, ci.familyname, ci.addressline1,
ci.addressline2, ci.addressline3, ci.citysuburb, ci.postcode, ci.state, ci.country,
(select sum(value) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) eligiblenights,
(select nvl(sum(value),0) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861) and transactiondate >= to_date('01/01/2017','dd/mm/yyyy') ) eligiblenights2017,
(select sum(value) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861,895,900)) allnights,
(select nvl(sum(value),0) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861,895,900) and transactiondate >= to_date('01/01/2017','dd/mm/yyyy') ) allnights2017,
(select count(terminaltransactionid) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) eligiblestays,
(select nvl(count(terminaltransactionid),0) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861) and transactiondate >= to_date('01/01/2017','dd/mm/yyyy') ) eligiblestays2017,
(select count(terminaltransactionid) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861,895,900)) allstays,
(select nvl(count(terminaltransactionid),0) from temp_nghitemptable1 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861,895,900) and transactiondate >= to_date('01/01/2017','dd/mm/yyyy') ) allstays2017
from cardmember c, member m, customerinformation ci
where c.status < 50
   and c.status <> 9
   and m.membershiplevel in (1,2)
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
   and m.personid = ci.personid;
   
select * from customerinformation
   
-- 17,573