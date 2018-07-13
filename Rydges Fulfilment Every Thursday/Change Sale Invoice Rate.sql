select * from voucher where vouchercode = 'GYG05327569';

select vsc.salecode, vsc.salesmerchantid, mscr.cardsalerate, mscr.distributorid
from merchantsalecoderate mscr, vouchersalecode vsc 
where mscr.merchantid = vsc.salesmerchantid
and mscr.salecode = vsc.salecode 
and vsc.voucherid in (select voucherid from voucher where vouchercode in (
'GYG05327569',
'GYG05393728',
'GYG05418826',
'GYG05736335'))

rate

select * from vouchersalecode 
where voucherid = (select voucherid from voucher where vouchercode = 'GYG05327569')