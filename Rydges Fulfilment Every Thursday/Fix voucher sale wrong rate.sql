drop table tempwrongvoucherrate;

create table tempwrongvoucherrate as
select s.* from vouchersalecode s, merchantsalecoderate r
where
s.salecode = r.salecode and
S.salesmerchantid  = R.MERCHANTID and 
s.saleinvoicerate <> R.CARDSALERATE and
s.distributorid = r.distributorid and
s.salesmerchantid in (47986,47990) and
s.salecode in (12344,12351) and 
s.saleinvoiceid in (520875,520874) and
r.status < 50
and s.saleinvoicestatus < 3;

-- Change sale invoice rate only, does not affect sale code price
-- ALERT : DOUBLE CHECK IF DISTRIBUTORID = SALECODEOWNERID
update vouchersalecode s 
set saleinvoicerate = (select cardsalerate from merchantsalecoderate r where s.salecode = r.salecode and s.salesmerchantid = r.merchantid and r.distributorid = s.distributorid and r.status < 50),
    pmsaleinvoicerate = (select cardsalerate from merchantsalecoderate r where s.salecode = r.salecode and s.salesmerchantid = r.merchantid and r.distributorid = s.distributorid and r.status < 50)
where exists (select * from tempwrongvoucherrate where s.vouchersalecodeid = vouchersalecodeid);

update vouchersalecodecard s 
set saleinvoicerate = (select saleinvoicerate from vouchersalecode r where s.vouchersalecodeid = r.vouchersalecodeid and s.distributorid = r.distributorid),
    pmsaleinvoicerate = (select saleinvoicerate from vouchersalecode r where s.vouchersalecodeid = r.vouchersalecodeid and s.distributorid = r.distributorid)
where exists (select * from tempwrongvoucherrate where s.vouchersalecodeid = vouchersalecodeid);

update vouchersalecode s 
set s.saleinvoicecost = (s.salecost - ((s.salecost*s.saleinvoicerate)/100)),
    s.saleinvoicetax = (s.saletax - ((s.saletax*s.saleinvoicerate)/100)),
    s.pmsaleinvoicecost = (s.pmsalecost - ((s.pmsalecost*s.pmsaleinvoicerate)/100)),
    s.pmsaleinvoicetax = (s.pmsaletax - ((s.pmsaletax*s.pmsaleinvoicerate)/100))
where exists (select * from tempwrongvoucherrate where s.vouchersalecodeid = vouchersalecodeid);

update vouchersalecodecard s 
set s.saleinvoicecost = (s.salecost - ((s.salecost*s.saleinvoicerate)/100)),
    s.saleinvoicetax = (s.saletax - ((s.saletax*s.saleinvoicerate)/100)),
    s.pmsaleinvoicecost = (s.pmsalecost - ((s.pmsalecost*s.pmsaleinvoicerate)/100)),
    s.pmsaleinvoicetax = (s.pmsaletax - ((s.pmsaletax*s.pmsaleinvoicerate)/100))
where exists (select * from tempwrongvoucherrate where s.vouchersalecodeid = vouchersalecodeid);

select * from vouchersalecode s
where exists (select * from tempwrongvoucherrate where s.vouchersalecodeid = vouchersalecodeid);

select * from voucher where voucherid = 183654