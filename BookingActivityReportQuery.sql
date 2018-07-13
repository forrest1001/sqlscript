with datatable (voucherid, salesmerchantid, salecodeownerid, distributorid, saledate, 
traveldate, redemptiondate, cardid, saleinvoicecost, status, creditnoteid,
quantityredeemed, valueredeemed, quantitycredit, valuecredit, quantityremain, valueremain) as
(
select v.voucherid,
    (case when (vsc.salecodeownerid = vsc.distributorid) then v.salesmerchantid else vsc.distributorid end) salesmerchantid,
    vsc.salecodeownerid, vsc.distributorid, vsc.saledate, v.traveldate, v.redemptiondate, vscc.cardid, vscc.status,
    (case when (vsc.salecodeownerid = vsc.distributorid) then vscc.saleinvoicecost else vscc.pmsaleinvoicecost end) saleinvoicecost,
    (case when (vsc.salecodeownerid = vsc.distributorid) then vscc.creditnoteid else vscc.pmcreditnoteid end) creditnoteid,
    (case when vscc.status = 2 then 1 else 0 end) quantityredeemed,
    (case when vscc.status = 2 then vscc.saleinvoicecost else 0 end) valueredeemed,
    (case when vscc.status = 20 then 1 else 0 end) quantitycredit,
    (case when vscc.status = 20 then vscc.saleinvoicecost else 0 end) valuecredit,
    (case when vscc.status = 0 then 1 else 0 end) quantityremain,
    (case when vscc.status = 0 then vscc.saleinvoicecost else 0 end) valueremain
 from voucher v, vouchersalecode vsc, vouchersalecodecard vscc
where v.voucherid = vsc.voucherid
  and vsc.vouchersalecodeid = vscc.vouchersalecodeid
  and v.status < 49
)
select 
    salesmerchantid,
    retrievedisplayname(salesmerchantid) salesmerchantname,
    count(cardid) quantityissued,
    sum(m.saleinvoicecost) valueissued,
    sum(m.quantityredeemed) quantityredeemed,
    sum(m.valueredeemed) valueredeemed,
    sum(m.quantitycredit) quantitycredit,
    sum(m.valuecredit) valuecredit,
    sum(m.quantityremain) quantityremain,
    sum(m.valueremain) valueremain
from datatable m
where m.distributorid = 47429 
  and m.saledate >= to_date('01/11/2017','dd/mm/yyyy')
  and m.saledate < to_date('09/11/2017','dd/mm/yyyy') 
group by salesmerchantid