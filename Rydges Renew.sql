select m.externalmemberid, m.productmgrid, m.membershiplevel, cm.cardid, cm.expirydate, 
p.givenname, p.familyname, a.street1, a.street2, a.street3, a.citysuburb, a.postcode, a.statecode, a.countrycode,
sum(t1.value) nightstotal, sum(t2.value) nights2016,
count(t1.terminaltransactionid) staystotal, count(t2.terminaltransactionid) staystotal 
from member m, cardmember cm, person p, address a, temp_stayall t1, temp_stay2016 t2
where m.externalmemberid = cm.externalmemberid
and m.productmgrid = cm.productmgrid
and m.personid = p.personid
and p.addressbookid = a.addressbookid
and m.membershiplevel >= 1
and cm.status < 50
and cm.status <> 9
and m.externalmemberid = t1.externalmemberid(+)
and m.productmgrid = t1.productmgrid(+)
and m.externalmemberid = t2.externalmemberid(+)
and m.productmgrid = t2.productmgrid(+)
group by m.externalmemberid, m.productmgrid, m.membershiplevel, cm.cardid, cm.expirydate, 
p.givenname, p.familyname, a.street1, a.street2, a.street3, a.citysuburb, a.postcode, a.statecode, a.countrycode;

-- 16,296

drop table temp_stayall;

create table temp_stayall as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

drop table temp_stay2016;

create table temp_stay2016 as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype <= 60000
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid 
union 
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
from loyaltypntssummarytransaction i, cardmember c, member m 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype <= 60000
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;
   
drop table temp_eligibleall;

create table temp_eligibleall as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;
   
drop table temp_eligible2016;

create table temp_eligible2016 as
select i.terminaltransactionid, i.transactiondate, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype <= 60000
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

drop table temp_stay2016summary;

create table temp_stay2016summary as
select externalmemberid, productmgrid, sum(value) nights, count(terminaltransactionid) stays
from temp_stay2016
group by externalmemberid, productmgrid;

drop table temp_stayallsummary;

create table temp_stayallsummary as
select externalmemberid, productmgrid, sum(value) nights, count(terminaltransactionid) stays
from temp_stayall
group by externalmemberid, productmgrid;

drop table temp_eligibleallsummary;

create table temp_eligibleallsummary as
select externalmemberid, productmgrid, sum(value) nights, count(terminaltransactionid) stays
from temp_eligibleall
group by externalmemberid, productmgrid;

drop table temp_eligible2016summary;

create table temp_eligible2016summary as
select externalmemberid, productmgrid, sum(value) nights, count(terminaltransactionid) stays
from temp_eligible2016
group by externalmemberid, productmgrid;



select m.externalmemberid, m.productmgrid, m.membershiplevel, cm.cardid, cm.expirydate, 
p.givenname, p.familyname, a.street1, a.street2, a.street3, a.citysuburb, a.postcode, a.statecode, a.countrycode,
t3.nights eligiblenightsall, t4.nights eligiblenights2016,
t1.nights nightsall, t2.nights nights2016,
t3.stays eligiblestayssall, t4.stays eligiblestays2016,
t1.stays staysall, t2.stays stays2016 
from member m, cardmember cm, person p, address a, temp_stayallsummary t1, temp_stay2016summary t2, temp_eligibleallsummary t3, temp_eligible2016summary t4
where m.externalmemberid = cm.externalmemberid
and m.productmgrid = cm.productmgrid
and m.personid = p.personid
and p.addressbookid = a.addressbookid
and m.membershiplevel >= 1
and cm.status < 50
and cm.status <> 9
and m.externalmemberid = t1.externalmemberid(+)
and m.productmgrid = t1.productmgrid(+)
and m.externalmemberid = t2.externalmemberid(+)
and m.productmgrid = t2.productmgrid(+)
and m.externalmemberid = t3.externalmemberid(+)
and m.productmgrid = t3.productmgrid(+)
and m.externalmemberid = t4.externalmemberid(+)
and m.productmgrid = t4.productmgrid(+)
