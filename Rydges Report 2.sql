select m.externalmemberid, m.productmgrid, m.membershiplevel, m.creationdate, m.anniversarydate, cfr.comments, tms.transactiondate laststay,
(select sum(balance) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (852,862)) balance852862,
(select sum(pointsexpired) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (852,862)) expired852862,
(select sum(issuancecount) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861,895,900)) stay851861895900,
(select sum(pointsissued) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861,895,900)) night851861895900,
(select sum(issuancecount) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (853,863)) stay863863,
(select sum(pointsissued) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (853,863)) night863863,
(select sum(issuancecount) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) stay851861,
(select sum(pointsissued) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) night851861,
(select sum(issuancecount) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (895,900)) stay895900,
(select sum(pointsissued) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (895,900)) night895900,
(select sum(pointsissued) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (901,902)) value901902,
(select sum(pointsissued) from temp_memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (903,904)) value903904
from member m, temp_firstfulfimentrequest cfr, temp_memberlaststay tms
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and m.externalmemberid = cfr.externalmemberid(+)
and m.productmgrid = cfr.productmgrid(+)
and m.externalmemberid = tms.externalmemberid(+)
and m.productmgrid = tms.productmgrid(+)
order by externalmemberid, creationdate
;

drop table temp_firstfulfimentrequest;

create table temp_firstfulfimentrequest as
select c.*
from cardfulfilmentrequest c, (select externalmemberid, productmgrid, min(cardfulfilmentrequestid) cardfulfilmentrequestid from cardfulfilmentrequest
where productmgrid in (22181,22191)
and status < 50
group by externalmemberid, productmgrid) f
where c.cardfulfilmentrequestid = f.cardfulfilmentrequestid;

-- 961,337
drop table temp_memberstay;

create table temp_memberstay as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
union
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.value, i.cardprodclassid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1;
   
create table temp_memberlaststay as
select *
from temp_memberstay
where terminaltransactionid in ( select min(terminaltransactionid) keep (dense_rank first order by transactiondate desc)
from temp_memberstay
group by externalmemberid );

create index temp_indx1 on temp_memberlaststay (productmgrid, externalmemberid);

drop table temp_memberpoints;

create table temp_memberpoints as
select externalmemberid, productmgrid, cardprodclassid, sum(pointsissued - pointsreverseissued) pointsissued,
sum(pointsredeemed - pointsreverseredeemed) pointsredeemed,
sum(pointsexpired - pointsreverseexpired) pointsexpired,
sum(pointsissued - pointsreverseissued) - sum(pointsredeemed - pointsreverseredeemed) - sum(pointsexpired - pointsreverseexpired) balance,
sum(usagecount) usagecount,
sum(issuancecount) issuancecount,
sum(redemptioncount) redemptioncount
from memberpoints
where cardprodclassid in (852,862,851,861,853,863,895,900, 901,902,903,904)
and externalmemberid like 'R%'
group by externalmemberid, productmgrid, cardprodclassid;

create index temp_indx2 on temp_memberpoints (productmgrid, externalmemberid);

select * from temp_memberpoints
order by  externalmemberid