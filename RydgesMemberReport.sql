
--  Member stays (eligible nights) for period of time
drop table temp_nghitemptable1;

create table temp_nghitemptable1 as
select i.operatorid, i.externalmemberid, m.personid, i.productmgrid, max(i.value) value, i.cardprodclassid, trunc(i.transactiondate) transactiondate
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
group by i.operatorid, i.externalmemberid, m.personid, i.productmgrid, i.cardprodclassid, transactiondate; 

--  Member stays (eligible+noneligible nights) before the period of time
drop table temp_nghitemptable2;

create table temp_nghitemptable2 as
select i.terminaltransactionid, i.externalmemberid, m.personid, i.productmgrid, m.membershiplevel, i.value, i.cardprodclassid, trunc(i.transactiondate) transactiondate
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.externalmemberid, m.personid, i.productmgrid, m.membershiplevel, i.loyaltyactualvalue value, i.cardprodclassid, trunc(i.transactiondate) transactiondate
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;
   
-- Spend value for period of time 
drop table temp_nghitemptable3;

create table temp_nghitemptable3 as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, i.loyaltyactualvalue value, i.cardprodclassid, trunc(i.transactiondate) transactiondate
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (901,903)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

CREATE INDEX nghitempindx3 ON temp_nghitemptable3
(externalmemberid, productmgrid, transactiondate);

-- Member stay during time period & have not stayed before i.e. first stay
drop table temp_nghitemptable5;

create table temp_nghitemptable5 as
select externalmemberid, personid, productmgrid, min(transactiondate) firstdate 
from temp_nghitemptable1 t1
where not exists (select * from temp_nghitemptable2 where externalmemberid = t1.externalmemberid and productmgrid = t1.productmgrid)
group by externalmemberid, personid, productmgrid;


-- 
drop table temp_nghitemptable6;

create table temp_nghitemptable6 as
select t1.*
from temp_nghitemptable5 t5, temp_nghitemptable1 t1
where t5.externalmemberid = t1.externalmemberid
and t5.personid = t1.personid
and t5.productmgrid = t1.productmgrid
and t5.firstdate = t1.transactiondate;

CREATE INDEX nghitempindx6 ON temp_nghitemptable6
(externalmemberid, personid, productmgrid, transactiondate);

select distinct t6.externalmemberid, retrievepersonname(t6.personid) name, t6.productmgrid, t6.cardprodclassid, t6.value, t6.transactiondate,
(select sum(value) from temp_nghitemptable3 where externalmemberid = t6.externalmemberid and productmgrid = t6.productmgrid and transactiondate = t6.transactiondate) spend
from temp_nghitemptable6 t6
order by externalmemberid;

-- Spend and Night since first stay
drop table temp_nghitemptable7;

create table temp_nghitemptable7 as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid
   and exists (select * from temp_nghitemptable6 where externalmemberid = i.externalmemberid and productmgrid = i.productmgrid) 
union 
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900,901,903)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid
   and exists (select * from temp_nghitemptable6 where externalmemberid = i.externalmemberid and productmgrid = i.productmgrid);
   
CREATE INDEX nghitempindx7 ON temp_nghitemptable7
(externalmemberid, productmgrid, cardprodclassid);

   
select distinct t6.externalmemberid, retrievepersonname(t6.personid) name, t6.productmgrid, t6.cardprodclassid, t6.value, t6.transactiondate, retrieveexternalid(t6.operatorid) hotelcode,
(select sum(value) from temp_nghitemptable3 where externalmemberid = t6.externalmemberid and productmgrid = t6.productmgrid and transactiondate = t6.transactiondate) spend,
(select sum(value) from temp_nghitemptable7 where externalmemberid = t6.externalmemberid and productmgrid = t6.productmgrid and cardprodclassid in (851,861)) totaleligiblenights,
(select sum(value) from temp_nghitemptable7 where externalmemberid = t6.externalmemberid and productmgrid = t6.productmgrid and cardprodclassid in (895,900)) totalnoneligiblenights,
(select sum(value) from temp_nghitemptable7 where externalmemberid = t6.externalmemberid and productmgrid = t6.productmgrid and cardprodclassid in (901,903)) spend
from temp_nghitemptable6 t6
order by externalmemberid;


