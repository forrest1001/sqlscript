select * from cardpurchasereportsummary where cardid = 903600399610009936


select * from vouchersalecodecard where bookingid = 3008370011

select count(*) from vouchersalecodecard where saleid = 0;
select count(*) from vouchersalecodecard where profileid = 0 and cardid > 0;
select count(*) from cardpurchasereportsummary where profileid = 0;
select count(*) from salecodedirectsale where profileid = 0;

select * from vouchersalecodecard where cardid in (select cardid from cardpurchasereportsummary where profileid = 0);

select * from voucher where voucherid in (select voucherid from vouchersalecodecard where saleid = 0)

--295533	KLK3343413609
--295873	IVC16915
--296613	IVC17026
--299982	7321228606701
--299985	7321229935673
--300837	7322477901917
--301907	ATS412171W

select * from cardpurchasereportsummary where saleid = 0

update vouchersalecodecard set saleid = saleid.nextval
where saleid = 0

select * from vouchersalecodecard where cardid = 629917700013958029

update cardpurchasereportsummary set saleid = 2157389 where cardid = 629917700013958029



select * from vouchersalecodecard where profileid = 0 and cardid > 0;

select profileid from cardpurchasereportsummary where saleid in (2157389,
2157391,
2157392,
2157393,
2157394)

update vouchersalecodecard
set profileid = profileid.nextval 
where profileid = 0 and cardid > 0;

update cardpurchasereportsummary c set profileid = (select profileid from vouchersalecodecard where saleid = c.saleid)
where saleid in (2157389,2157391,2157392,2157393,2157394);

select * from cardpurchasereportsummary 
where saleid in (2157389,2157391,2157392,2157393,2157394);
