select cprs.cardsaledate, cprs.saleexpirydate, cprs.redemptionexpirydate, cprs.firstuseexpirydate, v.vouchercode, ci.givenname, ci.familyname, ci.emailaddress, cl2.*,
 (select count(salecode) from vouchersalecode where voucherid = v.voucherid) salecodes
from cardpurchasereportsummary cprs, customerinformation ci, voucher v, salecodecategory sc, categorylevel2 cl2
where cprs.salecodeownerid = 47580 
and cprs.travellerid = ci.personid
and cprs.voucherid > 0
and cprs.voucherid = v.voucherid 
and cprs.salecode = sc.salecode
and sc.categorylevel2id = cl2.categorylevel2id
and cprs.cardid in (select distinct cardid From nonmemberpoints where cardprodclassid in (2108,2109,2106,2107,2102,2103)
and pointsredeemed = 0 and pointsexpired = 0)

select * from cardpurchasereportsummary
 
select *
from customersecurityprincipal cs, customerinformation ci
where cs.customersecurityprincipalid = ci.customersecurityprincipalid
and ci.emailaddress = 'bcmaher@optusnet.com.au'

select distinct cardprodclassid From merchantredemptionview where inventorytype = 400;

select * From nonmemberpoints where cardprodclassid in (2108,2109,2106,2107,2102,2103)
and pointsredeemed = 0 and pointsexpired = 0;