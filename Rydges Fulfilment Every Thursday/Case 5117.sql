select *
from cardregistration
where productmgrid in (22181,22191)
order by createddate 


select *
from 
(
select externalmemberid, min(creationdate) firstcarddate
from cardmember
where productmgrid in (22181,22191)
and externalmemberid like 'R%'
group by externalmemberid
)
where firstcarddate < to_date('01/07/2017','dd/mm/yyyy') 


01/07/2013 - 404,085
01/07/2014 - 492,281
01/07/2015 - 646,455
01/07/2016 - 797,584
01/07/2016 - 967,567

drop table temp_nghitemptable1;

create table temp_nghitemptable1 nologging as
select i.terminaltransactionid, i.externalmemberid, i.transactiondate, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.transactiondate >= to_date('01/07/2012','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.externalmemberid, i.transactiondate, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.transactiondate >= to_date('01/07/2012','dd/mm/yyyy')
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

select count(distinct externalmemberid) from temp_nghitemptable1
where transactiondate >= to_date('01/07/2016','dd/mm/yyyy')
  and transactiondate < to_date('01/07/2017','dd/mm/yyyy') 


01 July 2012 - 30 June 2013 : 95376
01 July 2013 - 30 June 2014 : 111167
01 July 2014 - 30 June 2015 : 153339
01 July 2015 - 30 June 2016 : 164900
01 July 2016 - 30 June 2017 : 183738



select count(*) 
from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/07/2016','dd/mm/yyyy')
and createddate < to_date('01/07/2017','dd/mm/yyyy')
order by createddate;

-- from web
01 July 2012 - 30 June 2013 = 113178 
01 July 2013 - 30 June 2014 = 97411
01 July 2014 - 30 June 2015 = 114637
01 July 2015 - 30 June 2016 = 97855
01 July 2016 - 30 June 2017 = 119249

-- From KIOSK
select count(*) 
from cardfulfilmentrequest c
where pickuptype = 10
  and comments like '%FROM KIOSK%'
  and productmgrid in (22181,22191)
  and creationdate >= to_date('01/07/2016','dd/mm/yyyy')
  and creationdate < to_date('01/07/2017','dd/mm/yyyy');
  
01 July 2012 - 30 June 2013 = 22,754
01 July 2013 - 30 June 2014 = 32,023
01 July 2014 - 30 June 2015 = 95,611
01 July 2015 - 30 June 2016 = 101,232
01 July 2016 - 30 June 2017 = 106,856

-- From FTP
-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
  and creationdate >= to_date('01/07/2016','dd/mm/yyyy')
  and creationdate < to_date('01/07/2017','dd/mm/yyyy');

01 July 2012 - 30 June 2013 = 157
01 July 2013 - 30 June 2014 = 251
01 July 2014 - 30 June 2015 = 284
01 July 2015 - 30 June 2016 = 359
01 July 2016 - 30 June 2017 = 501