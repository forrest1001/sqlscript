-- 1 Total number of kiosk enrolments by hotel code
   
select pickupcode, count(cardfulfilmentrequestid) requests from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('01/01/2015','dd/mm/yyyy')
and creationdate < to_date('01/01/2016','dd/mm/yyyy')
and status < 50
group by pickupcode;

select pickupcode, count(cardfulfilmentrequestid) requests from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('01/01/2016','dd/mm/yyyy')
and creationdate < to_date('01/01/2017','dd/mm/yyyy')
and status < 50
group by pickupcode;

-- 2 Total number of web enrolments

select sourceofficeid as pickupcode, count(cardregistrationid) registrations from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/01/2015','dd/mm/yyyy')
and createddate < to_date('01/01/2016','dd/mm/yyyy')
group by sourceofficeid;

select sourceofficeid as pickupcode, count(cardregistrationid) registrations from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/01/2016','dd/mm/yyyy')
and createddate < to_date('01/01/2017','dd/mm/yyyy')
group by sourceofficeid;

-- 3 Total number of Free Nights (853  863) redeemed by hotel code
select b.externalid hotelcode, sum(i.value) freenights 
from instantrewsummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.transactiondate >= to_date('01/01/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
   and i.operatorid = b.businesspartnerid
group by b.externalid;

select b.externalid hotelcode, sum(i.value) freenights 
from instantrewsummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
   and i.operatorid = b.businesspartnerid
group by b.externalid;

-- 4 Total value and count of FB Total Bill Amount (894  899) recorded by hotel code (this is the total before discount is applied)
select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (894,899)
   and i.transactiondate >= to_date('01/01/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (894,899)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

-- 5 Total value and count of FB Cash/Credit (891  896) recorded by hotel code (this is the total paid by Cash or Credit after the discount)
select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (891,896)
   and i.transactiondate >= to_date('01/01/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (891,896)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

-- 6 Total value and count of FB Room Charge (892 897) recorded by hotel code (this is the total charged to the room after the discount)
select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (892,897)
   and i.transactiondate >= to_date('01/01/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (892,897)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

-- 7 Total value and count of FB Covers (893 898) recorded by hotel code 
select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (893,898)
   and i.transactiondate >= to_date('01/01/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

select b.externalid hotelcode, i.productmgrid, i.currency, count(i.terminaltransactionid) counts, sum(i.value) amount
from loyaltypntssummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (893,898)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.operatorid = b.businesspartnerid
group by b.externalid, i.productmgrid, i.currency;

-- 8 Total number of Free Drinks (854 864) redeemed by hotel code
select b.externalid hotelcode, sum(i.value) freedrinks 
from instantrewsummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (854,864)
   and i.transactiondate >= to_date('01/01/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2016','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
   and i.operatorid = b.businesspartnerid
   group by b.externalid;

select b.externalid hotelcode, sum(i.value) freedrinks 
from instantrewsummarytransaction i, businesspartner b
where i.status < 50 
   and i.cardprodclassid in (854,864)
   and i.transactiondate >= to_date('01/01/2016','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
   and i.operatorid = b.businesspartnerid
group by b.externalid;

-- 9 Total count of members enrolled per hotel (i.e. hotel code or web) since program launch
-- From web
select sourceofficeid pickupcode, count(distinct externalmemberid) membercounts from cardregistration
where productmgrid in (22181,22191)
group by sourceofficeid;

-- From KIOSK - FTP   
select c.pickupcode, count(distinct externalmemberid) membercounts
from cardfulfilmentrequest c
where (c.pickuptype = 10 or c.pickuptype = 20)
and (c.comments like '%FROM KIOSK%' or c.comments like '%FTP%') 
and c.productmgrid in (22181,22191)
and c.status < 50
group by c.pickupcode;

-- From old
select pickupcode, count(distinct memberid) membercounts
from ADDCARDREQUESTHISTORY
where errorcode = 1
group by pickupcode;

-- 10 Total count of members who have had an eligible stay (851  861) in last 2 years by hotel code split into Gold, Platinum and Black
select b.externalid hotelcode, m.membershiplevel, count(distinct i.externalmemberid) membercount
from instantrewsummarytransaction i, businesspartner b, member m
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1   
   and i.transactiondate >= to_date('01/01/2015','dd/mm/yyyy')
   and i.transactiondate < to_date('01/01/2017','dd/mm/yyyy')
   and i.operatorid = b.businesspartnerid
   and i.externalmemberid = m.externalmemberid
group by b.externalid, m.membershiplevel;

-- 11 Total count of members who are Gold, total count of members who are Platinum and total count of members who are Black
select m.membershiplevel, count(distinct m.externalmemberid) members
from cardmember c, member m
where c.productmgrid in (22181,22191) 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid
group by m.membershiplevel;

-- 12 Count of members who have a points (852  862) balance split into the following bands/ranges
drop table temp_nghitemptable1;

create table temp_nghitemptable1 as
select m.externalmemberid, m.productmgrid, sum((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired)) balance
from memberpoints m, cardmember c
where m.cardprodclassid in (852,862)
  and m.externalmemberid = c.externalmemberid
   and c.status < 50 
   and c.status <> 9
   and c.productmgrid in (22181,22191)
group by m.externalmemberid, m.productmgrid;

select balance, count(distinct externalmemberid) membercounts
from temp_nghitemptable1
group by balance;

-- 13 Count of members who have stayed (851, 861, 895, 900) a certain number of nights (please report on both nights and stays) split into the following bands/ranges
drop table temp_nghitemptable2;

create table temp_nghitemptable2 as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
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
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
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
   
drop table temp_nghitemptable3;

create table temp_nghitemptable3 as
select externalmemberid, count(terminaltransactionid) stays, sum(value) nights 
from temp_nghitemptable2
group by externalmemberid;

select stays, count(distinct externalmemberid) membercounts 
from temp_nghitemptable3
group by stays;

select nights, count(distinct externalmemberid) membercounts 
from temp_nghitemptable3
group by nights;

select distinct m.externalmemberid, m.productmgrid
from cardmember c, member m
where c.status < 50 
  and c.status <> 9
  and c.externalmemberid = m.externalmemberid
  and c.productmgrid = m.productmgrid
  and not exists (select * from temp_nghitemptable2 where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid);

--14 Total count of members who have earned points (852 , 862) but have never redeemed points
drop table temp_pointissue;

create table temp_pointissue as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (852,862)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

drop table temp_pointredeem;

create table temp_pointredeem as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (852,862)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;
   
select *
from temp_pointissue i
where not exists (select * from temp_pointredeem where externalmemberid = i.externalmemberid and productmgrid = i.productmgrid);

-- 15 Total count of members that have redeemed points for a FB reward (i.e. Wine Voucher (855  865), Meal Voucher (856  866), Breakfast Voucher (860  870), Drink Voucher (859  869))
select count(distinct i.externalmemberid)
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (855,865,856,866,860,870,859,869)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 1
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;
   
-- 16 Total count of members that have redeemed a Free Night (853  863) but not a FB reward (855, 865, 856, 866, 860, 870, 859, 869)
drop table temp_redeemfreenight;

create table temp_redeemfreenight as 
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

drop table temp_redeemfb;

create table temp_redeemfb as
select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
from instantrewsummarytransaction i, cardmember c, member m
where i.status < 50 
   and i.cardprodclassid in (855,865,856,866,860,870,859,869)
   and i.suppliertransactiontype <= 60000
   and i.issuanceflag = 0
   and c.externalmemberid = i.externalmemberid 
   and c.productmgrid = i.productmgrid 
   and c.status < 50 
   and c.status <> 9
   and c.externalmemberid = m.externalmemberid
   and c.productmgrid = m.productmgrid;

select count(distinct externalmemberid) from temp_redeemfreenight n
where not exists (select * from temp_redeemfb where externalmemberid = n.externalmemberid and productmgrid = n.productmgrid);

-- 17 Total count of members that have redeemed both a Free Night and a FB reward (853, 863, 855, 865, 856, 866, 860, 870, 859, 869)
select count(distinct externalmemberid) from temp_redeemfreenight n
where exists (select * from temp_redeemfb where externalmemberid = n.externalmemberid and productmgrid = n.productmgrid);
