193674 -> 

194784 becomes 193674 
 
-----------------------------------------------------------------------
update voucher set voucherid = voucherid * 10000000
where voucherid = 193674;

update vouchersalecode set voucherid = voucherid * 10000000
where voucherid = 193674;

update vouchersalecodecard set voucherid = voucherid * 10000000
where voucherid = 193674;

-----------------------------------------------------------------------
update voucher set voucherid = 193674
where voucherid = 194784;

update vouchersalecode set voucherid = 193674
where voucherid = 194784;

update vouchersalecodecard set voucherid = 193674
where voucherid = 194784;


