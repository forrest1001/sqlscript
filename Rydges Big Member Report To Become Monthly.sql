drop table temp_nghitemptable11; 

create table temp_nghitemptable11 nologging as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, i.value, i.cardprodclassid, retrievecardprodclassname(i.cardprodclassid) productname, i.issuanceflag,
i.operatorid, b.displayname, RETRIEVECATEGORYLEVEL1NAME(i.operatorid) categorylevel1
from instantrewsummarytransaction i, member m, businesspartner b
where i.status < 50 
  and i.cardprodclassid in (select cardprodclassid from cardprodclassview where ownerid in (22181,22191))
  and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
  and i.transactiondate < to_date('01/01/2018','dd/mm/yyyy')
  and i.suppliertransactiontype < 60000
  and m.externalmemberid = i.externalmemberid 
  and m.productmgrid = i.productmgrid
  and i.operatorid = b.businesspartnerid  
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, i.loyaltyactualvalue value, i.cardprodclassid, retrievecardprodclassname(i.cardprodclassid) productname, i.issuanceflag,
i.operatorid, b.displayname, RETRIEVECATEGORYLEVEL1NAME(i.operatorid) categorylevel1
from loyaltypntssummarytransaction i, member m, businesspartner b 
where i.status < 50 
  and i.cardprodclassid in (select cardprodclassid from cardprodclassview where ownerid in (22181,22191))
  and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
  and i.transactiondate < to_date('01/01/2018','dd/mm/yyyy')
  and i.suppliertransactiontype < 60000
  and m.externalmemberid = i.externalmemberid 
  and m.productmgrid = i.productmgrid
  and i.operatorid = b.businesspartnerid 
;

select * from temp_nghitemptable11
where transactiondate < to_date('01/01/2017','dd/mm/yyyy');

select productname, cardprodclassid, issuanceflag, sum(value) from temp_nghitemptable11
where transactiondate >= to_date('01/01/2017','dd/mm/yyyy')
and cardprodclassid in (851,861,852,862)
group by productname, cardprodclassid, issuanceflag 

 

select m.externalmemberid, m.productmgrid, 
cm.cardid, cm.status, cm.creationdate, cm.modifieddate, cm.packcode, cm.cardpkgclassid,
(select sum((pointsissued-pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired)) from memberpoints
where cardprodclassid in (852,862) and externalmemberid = m.externalmemberid and productmgrid = m.productmgrid) balance
from member m, cardmember cm
where m.productmgrid in (22181,22191)
and m.externalmemberid = cm.externalmemberid
and m.productmgrid = cm.productmgrid
and m.externalmemberid like 'R%'
order by m.externalmemberid



with datatable as (
select externalmemberid, cardprodclassid, sum((pointsissued-pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired)) balance 
from memberpoints
where cardprodclassid in (852,862)
group by externalmemberid, cardprodclassid)
select externalmemberid, count(distinct cardprodclassid)
from datatable
group by externalmemberid