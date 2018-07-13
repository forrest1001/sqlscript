select mp.productmgrid, retrievedisplayname(mp.productmgrid) programname, a.businesspartnerid, b.displayname, wa.webattractionid, wa.webid, wa.displayname webattractionname
from attraction a, businesspartner b, merchantproductmgr mp, webattractionmerchant wam, webattraction wa
where a.businesspartnerid = mp.merchantid
  and mp.productmgrid not in (0,20455,1011,1523,20454,20641,21653,22181,22191,23664,23665,23669,23732,24265,24627,25074,46503,21711,21761,21821,22270,23165,23166,23191,23589,46481,44115, 23142)
  and a.businesspartnerid = b.businesspartnerid
  and b.suppliercapability = 1
  and a.businesspartnerid = wam.merchantid(+)
  and wam.webattractionid = wa.webattractionid(+)
order by mp.productmgrid

select mp.productmgrid, retrievedisplayname(mp.productmgrid) programname, a.businesspartnerid, b.displayname, b.taxrate, b.taxphrase, 
mr.cardprodclassid, retrievecardprodclassname(mr.cardprodclassid) productname,
msr.merchantofferid, retrievemerchantoffername(msr.merchantofferid) offername, msr.price
from attraction a, businesspartner b, merchantproductmgr mp, merchantrate mr, merchantspecialrate msr
where a.businesspartnerid = mp.merchantid
  and mp.productmgrid not in (0,20455,1011,1523,20454,20641,21653,22181,22191,23664,23665,23669,23732,24265,24627,25074,46503,21711,21761,21821,22270,23165,23166,23191,23589,46481,44115, 23142)
  and a.businesspartnerid = b.businesspartnerid
  and b.suppliercapability = 1
  and a.businesspartnerid = mr.merchantid(+)
  and mr.merchantrateid = msr.merchantrateid(+)
order by mp.productmgrid

1,289
8,165
9,824


select * from merchantspecialrate