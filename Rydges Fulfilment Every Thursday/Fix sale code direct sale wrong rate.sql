drop table tempwrongdirectsalerate;

create table tempwrongdirectsalerate as
select s.* from salecodedirectsale s, merchantsalecoderate r
where
s.salecode = r.salecode and
s.salesmerchantid  = r.merchantid and 
s.saleinvoicerate <> r.cardsalerate and
s.distributorid = r.distributorid and
s.salesmerchantid in (47986,47990) and
s.salecode in (12344,12351) and 
s.saleinvoiceid in (520875,520874) and
r.status < 50 and 
s.saleinvoicestatus < 3;


-- Change sale invoice rate only, does not affect sale code price
-- ALERT : DOUBLE CHECK IF DISTRIBUTORID = SALECODEOWNERID
update salecodedirectsale s
set saleinvoicerate = (select cardsalerate from merchantsalecoderate where merchantid = s.salesmerchantid and distributorid = s.distributorid and salecode = s.salecode),
    pmsaleinvoicerate = (select cardsalerate from merchantsalecoderate where merchantid = s.salesmerchantid and distributorid = s.distributorid and salecode = s.salecode)
where salecodedirectsaleid in (select salecodedirectsaleid from tempwrongdirectsalerate);

update salecodedirectsale
set saleinvoicecost = salecost - (salecost * saleinvoicerate / 100),
    saleinvoicetax = saletax - (saletax * saleinvoicerate / 100),
    pmsaleinvoicecost = salecost - (salecost * saleinvoicerate / 100),
    pmsaleinvoicetax = saletax - (saletax * saleinvoicerate / 100) 
where salecodedirectsaleid in (select salecodedirectsaleid from tempwrongdirectsalerate);

update cardpurchasereportsummary s
set saleinvoicerate = (select cardsalerate from merchantsalecoderate where merchantid = s.operatorid and distributorid = s.distributorid and salecode = s.salecode),
    pmsaleinvoicerate = (select cardsalerate from merchantsalecoderate where merchantid = s.operatorid and distributorid = s.distributorid and salecode = s.salecode)
where saleid in (select saleid from tempwrongdirectsalerate);

update cardpurchasereportsummary
set saleinvoicecost = salecost - (salecost * saleinvoicerate / 100),
    saleinvoicetax = saletax - (saletax * saleinvoicerate / 100),
    pmsaleinvoicecost = salecost - (salecost * saleinvoicerate / 100),
    pmsaleinvoicetax = saletax - (saletax * saleinvoicerate / 100)
where saleid in (select saleid from tempwrongdirectsalerate);

select * from salecodedirectsale
where salecodedirectsaleid in (select salecodedirectsaleid from tempwrongdirectsalerate); 

select * from cardpurchasereportsummary
where saleid in (select saleid from tempwrongdirectsalerate)
 

