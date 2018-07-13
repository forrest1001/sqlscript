SELECT d.cardid AS cardid,d.salecode AS salecode,NULL AS vouchercode,
d.saledate AS saledate,
retrievesalecodename (d.salecode) AS salecodename,
retrievepersonname (d.buyerid) AS personname,
cu.addressline1,cu.addressline2,cu.addressline3,cu.postcode, cu.state, cu.country,cu.emailaddress,
retrievedisplayname (d.salesmerchantid) AS salesmerchantname, d.saleinvoicedate,
d.CREDITNOTEFLAG
FROM salecodedirectsale d, customerinformation cu
WHERE d.status < 50
and d.salecodeownerid = 47580
and d.buyerid = cu.personid
UNION ALL
SELECT c.cardid AS cardid,c.salecode AS salecode,v.vouchercode AS vouchercode,
s.saledate AS saledate,
retrievesalecodename (s.salecode) AS salecodename,
retrievepersonname (c.buyerid) AS personname,
cu.addressline1,cu.addressline2,cu.addressline3,cu.postcode, cu.state, cu.country,cu.emailaddress,
retrievedisplayname (s.salesmerchantid) AS salesmerchantname, s.datetoinvoice,
c.CREDITNOTEFLAG
FROM vouchersalecodecard c, vouchersalecode s, voucher v, customerinformation cu
WHERE c.vouchersalecodeid = s.vouchersalecodeid
AND c.voucherid = v.voucherid
AND v.datetoinvoice IS NOT NULL
AND v.status < 50
and s.salecodeownerid = 47580
and c.buyerid = cu.personid


select * from vouchersalecodecard