select msr.productmgrid, retrievedisplayname(msr.productmgrid) productmgrname,
mo.merchantid, b.displayname, b.taxphrase, b.taxrate, 
mo.name, mo.skuid, 
msr.cardprodclassid, retrievecardprodclassname(msr.cardprodclassid) productname, msr.price netprice
from merchantoffer mo, businesspartner b, merchantspecialrate msr
where mo.merchantid = b.businesspartnerid
and mo.merchantofferid = msr.merchantofferid(+)
order by mo.merchantid, mo.skuid


select s.productmgrid, retrievedisplayname(s.productmgrid) productmgrname,
s.salecode, s.name, sp.cardcost, sp.cardcostcurrency, sp.cardcosttax,
c1.name cat1name, c1.description cat1description, c2.name cat2name, c2.description cat2description, c3.name cat3name, c3.description cat3description, c4.name cat4name, c4.description cat4description,
sed.purchasemonths, sed.purchasedays, sed.activationmonths, sed.activationdays, sed.firstusemonths, sed.firstusedays,
sed.traveldatemonths, sed.traveldatedays, sed.noactivitymonths, sed.noactivitydays,
mo.name merchantoffername, mo.skuid, 
msr.cardprodclassid, retrievecardprodclassname(msr.cardprodclassid) productname, msr.price netprice
from salecode s, salecodeprice sp, salecodeexpirydefinition sed, salecodecategory sc, categorylevel1 c1, categorylevel2 c2, categorylevel3 c3, categorylevel4 c4,
merchantoffer mo, merchantspecialrate msr
where s.status < 50
and s.salecodetype = 3
and s.salecode = sp.salecode
and s.productmgrid = sp.distributorid
and s.salecode = sed.salecode
and sed.status < 50
and s.salecode = sc.salecode
and sc.status < 50
and sc.categorylevel1id = c1.categorylevel1id(+)
and sc.categorylevel2id = c2.categorylevel2id(+)
and sc.categorylevel3id = c3.categorylevel3id(+)
and sc.categorylevel4id = c4.categorylevel4id(+)
and s.merchantofferid = mo.merchantofferid
and mo.merchantofferid = msr.merchantofferid(+)
order by s.productmgrid, s.salecode


select s.productmgrid, retrievedisplayname(s.productmgrid) productmgrname,
s.salecode, s.name, sp.cardcost, sp.cardcostcurrency, sp.cardcosttax,
c1.name cat1name, c1.description cat1description, c2.name cat2name, c2.description cat2description, c3.name cat3name, c3.description cat3description, c4.name cat4name, c4.description cat4description,
sed.purchasemonths, sed.purchasedays, sed.activationmonths, sed.activationdays, sed.firstusemonths, sed.firstusedays,
sed.traveldatemonths, sed.traveldatedays, sed.noactivitymonths, sed.noactivitydays
from salecode s, salecodeprice sp, salecodeexpirydefinition sed, salecodecategory sc, categorylevel1 c1, categorylevel2 c2, categorylevel3 c3, categorylevel4 c4
where s.status < 50
and s.salecodetype != 3
and s.salecode = sp.salecode
and s.productmgrid = sp.distributorid
and s.salecode = sed.salecode
and sed.status < 50
and s.salecode = sc.salecode
and sc.status < 50
and sc.categorylevel1id = c1.categorylevel1id(+)
and sc.categorylevel2id = c2.categorylevel2id(+)
and sc.categorylevel3id = c3.categorylevel3id(+)
and sc.categorylevel4id = c4.categorylevel4id(+)
order by s.productmgrid, s.salecode

select * from salecode where salecodetype != 3