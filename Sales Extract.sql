------- Official query sale
select (nvl((select productmgrgroupid from productmanager where businesspartnerid = s.distributorid),0)) as PM_Group_id, 
s.distributorid PM_ID, 
case 
    when length(retrievecompanyname(distributorid))>=60
    then substr(retrievecompanyname(distributorid),0, 60) || '...' 
    else retrievecompanyname(distributorid) 
end PM_COMPANY_NAME,
salesmerchantid MERCHANT_ID,
case 
    when length(retrievecompanyname(salesmerchantid))>=60
    then substr(retrievecompanyname(salesmerchantid),0, 60) || '...' 
    else retrievecompanyname(salesmerchantid)
end merchant_company_name, 
saleinvoiceid invoice_id, to_char(r.enddate,'yyyymmddhhmiss') invoice_date, 1 as transaction_type, pmcurrency currency, 
to_char(saledate,'yyyymmddhhmiss') sale_date, saleid sale_id, 
case 
    when length(vouchercode)>=50
    then substr(vouchercode,0,50) || '...' 
    else vouchercode
end voucher_id, 
salecode sale_code_id, 
--retrievesalecodename(salecode) salecodename, 
salecodeownerid owner_id,
case
    when creditnoteid > 0 then -1
    else 1
end quantity, 
salecost retail_price, 
--saleinvoicecost,
(salecost-saleinvoicecost) commission
from salecodecardsummary s, report r 
where 
s.saleinvoiceid = r.reportid
and (r.reportid in (556172, 556174, 556175, 556173))
--and r.reportid in (550565, 550570, 550572, 550576, 550577)
order by saledate

-------------------------------------------------------------------------------------------------
------- Official query sale supplier (not to be confused with supplier transactions)
select (nvl((select productmgrgroupid from productmanager where businesspartnerid = s.distributorid),0)) as pm_group_id, 
s.distributorid pm_id, 
case 
    when length(retrievecompanyname(distributorid))>=60
    then substr(retrievecompanyname(distributorid),0, 60) || '...' 
    else retrievecompanyname(distributorid) 
end pm_company_name,
salecodeownerid as merchant_id,
case 
    when length(retrievecompanyname(salecodeownerid))>=60
    then substr(retrievecompanyname(salecodeownerid),0, 60) || '...' 
    else retrievecompanyname(salecodeownerid)
end merchant_company_name, 
pmsaleinvoiceid invoice_id, to_char(r.enddate,'yyyymmddhhmiss') invoice_date, 1 as transaction_type, pmcurrency currency, 
saleid,
case 
    when length(vouchercode)>=50
    then substr(vouchercode,0,50) || '...' 
    else vouchercode
end voucher_id, 
salecode, 
case
    when creditnoteid > 0 then -1
    else 1
end quantity, 
pmsalecost retail_price,
(pmsalecost-pmsaleinvoicecost) commission
--pmsaleinvoicecost
from salecodecardsummary s, report r 
where 
s.pmsaleinvoiceid = r.reportid
--and r.reportid in ( 550814, 550815, 550816, 550817, 550818)
and r.reportid in (556172, 556174, 556175, 556173)
order by saledate

-- OFFICIAL COMBINED SCRIPT FOR DISTRIBUTORS AND MERCHANTS
select (nvl((select productmgrgroupid from productmanager where businesspartnerid = s.distributorid),0)) as PM_Group_id, s.distributorid PM_ID, 
case 
    when length(retrievecompanyname(distributorid))>=60
    then substr(retrievecompanyname(distributorid),0, 60) || '...' 
    else retrievecompanyname(distributorid) 
end PM_COMPANY_NAME,
salesmerchantid MERCHANT_ID,
case 
    when length(retrievecompanyname(salesmerchantid))>=60
    then substr(retrievecompanyname(salesmerchantid),0, 60) || '...' 
    else retrievecompanyname(salesmerchantid)
end merchant_company_name, 
saleinvoiceid invoice_id, to_char(r.enddate,'yyyymmddhhmi') invoice_date, 1 as transaction_type, pmcurrency currency, 
to_char(saledate,'yyyymmddhhmi') sale_date, saleid sale_id, 
case 
    when length(vouchercode)>=50
    then substr(vouchercode,0,50) || '...' 
    else vouchercode
end voucher_id, 
salecode sale_code_id, 
salecodeownerid owner_id,
case
    when creditnoteid > 0 then -1
    else 1
end quantity, 
salecost retail_price, 
(salecost-saleinvoicecost) commission
from salecodecardsummary s, report r 
where 
s.saleinvoiceid = r.reportid
and (r.reportid in (559774,559785,559796,559807,559818) or r.reportid in (select reportid from report where groupreportid in (559774,559785,559796,559807,559818)))
union ------------------------------------------------------
select (nvl((select productmgrgroupid from productmanager where businesspartnerid = s.salecodeownerid),0)) as pm_group_id, s.salecodeownerid pm_id, 
case 
    when length(retrievecompanyname(salecodeownerid))>=60
    then substr(retrievecompanyname(salecodeownerid),0, 60) || '...' 
    else retrievecompanyname(salecodeownerid) 
end pm_company_name,
distributorid as merchant_id,
case 
    when length(retrievecompanyname(distributorid))>=60
    then substr(retrievecompanyname(salecodeownerid),0, 60) || '...' 
    else retrievecompanyname(distributorid)
end merchant_company_name, 
pmsaleinvoiceid invoice_id, to_char(r.enddate,'yyyymmddhhmi') invoice_date, 1 as transaction_type, pmcurrency currency, 
to_char(saledate,'yyyymmddhhmi') sale_date, saleid sale_id,
case 
    when length(vouchercode)>=50
    then substr(vouchercode,0,50) || '...' 
    else vouchercode
end voucher_id, 
salecode sale_code_id, 
salecodeownerid owner_id,
case
    when creditnoteid > 0 then -1
    else 1
end quantity, 
pmsalecost retail_price,
(pmsalecost-pmsaleinvoicecost) commission
from salecodecardsummary s, report r 
where 
s.pmsaleinvoiceid = r.reportid
and (r.reportid in (559774,559785,559796,559807,559818) or r.reportid in (select reportid from report where groupreportid in (559774,559785,559796,559807,559818)))
order by sale_date


-------------------------------------------------------------------------------------------------
-- Supplier Extract PM Group

select 50394 as productmgrgroupid, 
distributorid, 
case 
    when length(retrievecompanyname(distributorid))>=60
    then substr(retrievecompanyname(distributorid),0, 60) || '...' 
    else retrievecompanyname(distributorid) 
end programmanagercompanyname,
salesmerchantid,
case 
    when length(retrievecompanyname(salesmerchantid))>=60
    then substr(retrievecompanyname(salesmerchantid),0, 60) || '...' 
    else retrievecompanyname(salesmerchantid)
end merchantcompanyname, 
pmsaleinvoiceid, saleinvoicedate,
1 as transactiontype, currency, saledate, saleid, 
case 
    when length(vouchercode)>=50
    then substr(vouchercode,0,50) || '...' 
    else vouchercode
end vouchercode, 
salecode, salecodeownerid, 
saleinvoicecost unit_price
from salecodecardsummary s, report r 
where 
-- salecodeownerid = 25137
--and saleinvoicedate >= to_date('01/07/2017','dd/mm/yyyy')
--and saleinvoicedate < to_date('01/08/2017','dd/mm/yyyy') 
--and saleinvoiceid > 0
s.pmsaleinvoiceid = r.reportid
--and (r.groupreportid in (559686) or r.reportid in (select reportid from report where groupreportid in (559686)))
and r.reportid in (select reportid from report where groupreportid in (559686))
order by saledate


select * from report where reportid in (559685, 559684)

select * from report where groupreportid = 545253

select * from salecodedirectsale where saleinvoiceid in (545251,545252)

select * from salecodecardsummary where pmsaleinvoiceid in (select reportid from report where groupreportid in (559686))


-------------------

select -- get productmgrgroupid of distributor, if available
(nvl((select productmgrgroupid from productmanager where businesspartnerid = s.distributorid),0)) as productmgrgroupid, 
s.distributorid, 
case 
    when length(retrievecompanyname(distributorid))>=60
    then substr(retrievecompanyname(distributorid),0, 60) || '...' 
    else retrievecompanyname(distributorid) 
end programmanagercompanyname,
salesmerchantid,
case 
    when length(retrievecompanyname(salesmerchantid))>=60
    then substr(retrievecompanyname(salesmerchantid),0, 60) || '...' 
    else retrievecompanyname(salesmerchantid)
end merchantcompanyname, 
saleinvoiceid, 
to_char(r.enddate,'yyyymmddhhmiss') saleinvoicedate,
1 as transactiontype, 
pmcurrency, 
to_char(saledate,'yyyymmddhhmiss') saledate, saleid, 
case 
    when length(vouchercode)>=50
    then substr(vouchercode,0,50) || '...' 
    else vouchercode
end vouchercode, 
salecode, salecodeownerid,
1 as quantity, 
pmsalecost,
(pmsalecost-pmsaleinvoicecost) commissionamount
from salecodecardsummary s, report r 
where 
-- salecodeownerid = 25137
--and saleinvoicedate >= to_date('01/07/2017','dd/mm/yyyy')
--and saleinvoicedate < to_date('01/08/2017','dd/mm/yyyy') 
--and saleinvoiceid > 0
s.saleinvoiceid = r.reportid
--and r.groupreportid in ( 550814, 550815, 550816, 550817, 550818)
and r.reportid in ( 550814, 550815, 550816, 550817, 550818)
--and r.reportid in (550565, 550570, 550572, 550576, 550577)
order by saledate

select * from report where groupreportid in (550814, 550815, 550816, 550817, 550818)


select * from report where reportid in (550814, 550815, 550816, 550817, 550818)

select * from productmanager where productmgrgroupid = 50097