-- Total fulfilment Kiosk + first stay
select count(*)
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('01/07/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('22/09/2016','dd/mm/yyyy') 
   and c.packcode in (60,61)
   and (c.comments like '%BOOKING%' or c.comments like '%FROM KIOSK%');
   
-- Total fulfilment Kiosk + first stay
select count(*)
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('01/09/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('22/09/2016','dd/mm/yyyy') 
   and c.packcode in (60,61)
   and (c.comments like '%BOOKING%' or c.comments like '%FROM KIOSK%');
   
-- Total fulfilment Kiosk + first stay CHANGE THIS !!!!!!!!!!!!!!!!!!!!!!!!!!!!
select count(*)
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('15/09/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('22/09/2016','dd/mm/yyyy') 
   and c.packcode in (60,61)
   and (c.comments like '%BOOKING%' or c.comments like '%FROM KIOSK%');

-- Total Gold request (pack 92,93)
select count(*)
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('01/07/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('22/09/2016','dd/mm/yyyy') 
   and c.packcode in (92,93)
   and c.status < 50; -- There are status 52 request, duplicate gold upgrade request

-- Total Gold request (pack 92,93)
select count(*)
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('01/09/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('22/09/2016','dd/mm/yyyy') 
   and c.packcode in (92,93)
   and c.status < 50; -- There are status 52 request, duplicate gold upgrade request

-- Total Platinum request (pack 72,73,102,103)
select count(*)
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('01/07/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('06/10/2016','dd/mm/yyyy') 
   and c.packcode in (72,73,102,103);

-- Total Platinum request (pack 72,73,102,103)
select count(*)
from cardfulfilmentrequest c
where c.fulfilleddate >= to_date('01/10/2016','dd/mm/yyyy') 
   and c.fulfilleddate < to_date('06/10/2016','dd/mm/yyyy') 
   and c.packcode in (72,73,102,103);

select count(*)
from member
where productmgrid in (22181,22191)
and affiliation = 1;

--Count of unique members who have a membership card and have stayed (both eligible & non-eligible nights):
select count(distinct externalmemberid) members
from instantrewsummarytransaction i 
where i.status < 50 
and i.cardprodclassid in (853,863)
and i.suppliertransactiontype < 60000
and i.issuanceflag = 1
and i.transactiondate >= to_date('21/02/2017','dd/mm/yyyy')
and i.transactiondate < to_date('22/02/2018','dd/mm/yyyy');

--Count of unique members who have redeemed points for a reward shop benefit (e.g. members who have redeemed points for a reward shop sale code (as listed) or Free Night product):
select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1)) 
from salecodecardsummary 
where salecode in (40147,40188)
and creditnoteflag = 0
and saledate >= to_date('21/02/2016','dd/mm/yyyy')
and saledate < to_date('22/02/2018','dd/mm/yyyy');

select *
from salecodecardsummary 
where salecode in (40139,40170)
and creditnoteflag = 0
and saledate >= to_date('21/02/2016','dd/mm/yyyy')
and saledate < to_date('22/02/2018','dd/mm/yyyy'); 

select *
from salecodecardsummary 
where salecode in (40162,40493)
and creditnoteflag = 0
and saledate >= to_date('21/02/2016','dd/mm/yyyy')
and saledate < to_date('22/02/2018','dd/mm/yyyy'); 

select *
from salecodecardsummary 
where salecode in (40154,40196)
and creditnoteflag = 0
and saledate >= to_date('21/02/2016','dd/mm/yyyy')
and saledate < to_date('22/02/2018','dd/mm/yyyy');
 

select *
from salecodecardsummary 
where salecode in (40345,40535)
and creditnoteflag = 0
and saledate >= to_date('21/02/2016','dd/mm/yyyy')
and saledate < to_date('22/02/2018','dd/mm/yyyy');


24 months
12 months

to_date('21/02/2016','dd/mm/yyyy')
to_date('21/02/2017','dd/mm/yyyy')
to_date('22/02/2018','dd/mm/yyyy')

--Count of unique members who have a membership card and have stayed (both eligible & non-eligible nights)
select count(*)  
    From 
    (
    select distinct externalmemberid, productmgrid from
    (
        select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
        from instantrewsummarytransaction i, cardmember c, member m
            where i.status < 50 
            and i.cardprodclassid in (851,861)
            and i.transactiondate >= to_date('21/02/2016','dd/mm/yyyy')
            and i.transactiondate < to_date('22/02/2018','dd/mm/yyyy')
            and i.suppliertransactiontype < 60000
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
            and i.transactiondate >= to_date('21/02/2016','dd/mm/yyyy')
            and i.transactiondate < to_date('22/02/2018','dd/mm/yyyy')
            and i.suppliertransactiontype < 60000
            and i.issuanceflag = 1
            and c.externalmemberid = i.externalmemberid 
            and c.productmgrid = i.productmgrid 
            and c.status < 50 
            and c.status <> 9
            and c.externalmemberid = m.externalmemberid
            and c.productmgrid = m.productmgrid
        )
    );