select s.salecode, s.name, sp.salecodepriceid, sp.cardcost, sp.cardcosttax  
from salecode s, salecodeprice sp
where s.productmgrid = 49369
and s.status < 50
and s.salecode = sp.salecode
and s.productmgrid = sp.distributorid

select a.businesspartnerid, retrievedisplayname(a.businesspartnerid) merchantname,
mr.merchantrateid, mr.cardprodclassid, retrievecardprodclassname(mr.cardprodclassid) productname, mr.issuanceflag, mr.benefit, mr.retailprice, mr.flatprice,
msr.merchantspecialrateid, msr.price, msr.merchantofferid, retrievemerchantoffername(msr.merchantofferid) offername 
from attraction a, merchantproductmgr mp, merchantrate mr, merchantspecialrate msr
where a.businesspartnerid = mp.merchantid
and mp.productmgrid = 49369
and a.businesspartnerid = mr.merchantid(+)
and mr.merchantrateid = msr.merchantrateid(+)
order by a.businesspartnerid, cardprodclassid


