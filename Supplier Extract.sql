select i.productmgrid as pm_group_id,
i.productmgrid as pm_id, 
retrievecompanyname(i.productmgrid) PM_Company_Name,
i.operatorid as merchant_id,
retrievecompanyname(i.operatorid) Merchant_Company_Name,
i.reportId as Invoice_Id,
to_char(decode(r.status, 2, approveddate, generateddate),'yyyyMMddhhmi') Invoice_Date,
decode(r.status, 2, approveddate, generateddate) invoice_date_2,
1 as transaction_Type,
i.currency,
i.saleid sale_id,
i.cardProdClassId product_id,
decode(i.suppliertransactiontype,61000, -i.Value, i.Value) quantity,
i.unitinvoicecost unit_price
from instantrewsummarytransaction i , report r 
where i.reportid > 0
and i.partofcardsale = 0
--and i.issuanceflag = 0
--and i.productmgrid = 25232
and i.reportid = r.reportid
and r.reporttype = 'merchant/invoice'
and r.reportid in (556695, 556702, 556701, 556717, 556736, 556735)
union all
select i.productmgrid as productmgrgroupid,
i.productmgrid, 
retrievecompanyname(i.productmgrid) PMCompanyName,
i.operatorid as merchantid,
retrievecompanyname(i.operatorid) MerchantCompanyName,
i.reportId as InvoiceId,
to_char(decode(r.status, 2, approveddate, generateddate),'yyyyMMddhhmi') InvoiceDate, 
--decode(r.status, 2, approveddate, generateddate) InvoiceDate,
decode(r.status, 2, approveddate, generateddate) invoice_date_2,
1 as transactionType,
i.currency,
i.saleid,
i.cardProdClassId,
decode(i.suppliertransactiontype,61000, -i.Value, i.Value) quantity,
i.unitinvoicecost unit_price
from passsummarytransaction i , report r 
where i.reportid > 0
and i.partofcardsale = 0
--and i.issuanceflag = 0
--and i.productmgrid = 25232
and i.reportid = r.reportid
and r.reporttype = 'merchant/invoice'
and r.reportid in (556695, 556702, 556701, 556717, 556736, 556735)


-- SALE SUPPLIER
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
pmsaleinvoiceid invoice_id, to_char(r.enddate,'yyyymmddhhmi') invoice_date, 1 as transaction_type, pmcurrency currency, 
saleid,
--case 
--    when length(vouchercode)>=50
--    then substr(vouchercode,0,50) || '...' 
--    else vouchercode
--end voucher_id, 
salecode, 
case
    when creditnoteid > 0 then -1
    else 1
end quantity, 
--pmsalecost retail_price,
pmsaleinvoicecost unit_price
--(pmsalecost-pmsaleinvoicecost) commission
--pmsaleinvoicecost
from salecodecardsummary s, report r 
where 
s.pmsaleinvoiceid = r.reportid
--and r.reportid in ( 550814, 550815, 550816, 550817, 550818)
and (r.reportid in (559685, 559684) or r.reportid in (select reportid from report where groupreportid in (559685, 559684)))
--and r.reportid = 559765
order by saledate


select * from report where reportid in (559774,559785,559796,559807,559818)

select * from report where groupreportid in (559774,559785,559796,559807,559818)


select * from salecodecardsummary where pmsaleinvoiceid in (559774,559785,559796,559807,559818)