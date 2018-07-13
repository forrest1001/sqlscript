--  Total Member Count (including temp members) --------------------------------

select year, count(distinct externalmemberid) members from
(
select to_char(creationdate, 'YYYY') year, externalmemberid
from member
where productmgrid in (22181,22191)
  and externalmemberid like 'R%'
)
group by year
order by year;

select year, count(distinct externalmemberid) members from
(
select to_char(createddate, 'YYYY') year, externalmemberid
from cardregistration c
where productmgrid in (22181,22191)
  and not exists (select * from member where externalmemberid = c.externalmemberid)
)
group by year
order by year;

-- Total Count of Unique Members who stayed (851, 861, 895 & 900)

select year, count(distinct externalmemberid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, terminaltransactionid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
union 
select to_char(transactiondate, 'YYYY') year, externalmemberid, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Number of Stays -------------------------------------------------------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, terminaltransactionid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Number of Nights ------------------------------------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i
where i.status < 50 
   and i.cardprodclassid in (851,861)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (895,900)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Revenue ---------------------------------------------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (901,903)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (902,904)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Count of Unique Members who used F&B (891, 896, 892, 897, 894, 899, 893 & 898)

select * from cardprodclassview where cardprodclassid in (891,896,892,897,894,899,893,898)

select year, count(distinct externalmemberid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (891,896,892,897,894,899,893,898)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Count of Cash/Credit transactions (Loyalty Products 891 & 896)

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (891,896)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Cash/Credit transactions (Loyalty Products 891 & 896) --------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (891,896)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Count of Room Charge transactions (Loyalty Products 892 & 897) --------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (892,897)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Room Charge transactions (Loyalty Products 892 & 897) --------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (892,897)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Count of Bill Amount transactions (Loyalty Products 894 & 899) --------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (894,899)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Bill Amount transactions (Loyalty Products 894 & 899) --------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (894,899)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Count of Covers transactions (Loyalty Products 893 & 898) -------------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (893,898)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Covers transactions (Loyalty Products 893 & 898) --------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from loyaltypntssummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (893,898)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Count of Unique Members who redeemed a reward (e.g. redeemed points for one of the following products/sale codes)

select year, count(distinct externalmemberid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (852,862)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
)
group by year
order by year;

-- Total Count of Free Night Vouchers issuance transactions (853 & 863) --------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Free Night Vouchers issued (853 & 863) -----------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Free Night Vouchers redeemed (853 & 863) ---------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (853,863)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
)
group by year
order by year;

-- Total Count of Breakfast Voucher issuance transactions (860 & 870) ----------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (860,870)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Breakfast Vouchers issued (860 & 870) ------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (860,870)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Breakfast Vouchers redeemed (860 & 870) ----------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (860,870)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
)
group by year
order by year;

-- Total Count of Drink Voucher issuance transactions (859 & 869) --------------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (859,869)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Drink Vouchers issued (859 & 869) ----------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (859,869)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

-- Total Value of Drink Vouchers redeemed (859 & 869) --------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (859,869)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
)
group by year
order by year;

--  Total Count of Meal Voucher issuance transactions (856 & 866) --------------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (856,866)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

--  Total Value of Meal Vouchers issued (856 & 866) ----------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (856,866)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

--  Total Value of Meal Vouchers redeemed (856 & 866) --------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (856,866)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
)
group by year
order by year;

--  Total Count of Wine Voucher issuance transactions (855 & 865) --------------

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (855,865)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

--  Total Value of Wine Vouchers issued (855 & 865) ----------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (855,865)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 1
)
group by year
order by year;

--  Total Value of Wine Vouchers redeemed (855 & 865) --------------------------

select year, sum(value) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (855,865)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
)
group by year
order by year;

--  Total Count of $50 Gift Card issuance transactions (Sale Code 40345 & 40535) 

select year, count(distinct voucherid) members from
(
select to_char(saledate, 'YYYY') year, vouchersalecodeid, voucherid 
from vouchersalecode 
where salecode in (40345,40535)
  and status in (0,2)
)
group by year
order by year;

--  Total Count of Welcome Drink Voucher redemption transactions (854 & 864) ---

select year, count(terminaltransactionid) members from
(
select to_char(transactiondate, 'YYYY') year, externalmemberid, value, terminaltransactionid
from instantrewsummarytransaction i 
where i.status < 50 
   and i.cardprodclassid in (854,864)
   and i.suppliertransactiontype < 60000
   and i.issuanceflag = 0
)
group by year
order by year;

