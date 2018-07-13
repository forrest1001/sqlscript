create or replace view temp_cardusage as
select s.cardid, i.terminaltransactionid, i.transactiondate, i.operatorid, retrievedisplayname(i.operatorid) operatorname, i.totalinvoicecost, i.totalinvoicetax, i.suppliertransactiontype, i.issuanceflag,
  0 as producttype
from salecodecardsummary s, passsummarytransaction i
where s.salecodeownerid = 47580
 and s.cardid = i.cardid
 and i.status < 50
 and (i.suppliertransactiontype  < 79900 or i.suppliertransactiontype > 79999)
union 
select s.cardid, i.terminaltransactionid, i.transactiondate, i.operatorid, retrievedisplayname(i.operatorid) operatorname, i.totalinvoicecost, i.totalinvoicetax, i.suppliertransactiontype, i.issuanceflag,
  3 as producttype
from salecodecardsummary s, instantrewsummarytransaction i
where s.salecodeownerid = 47580
 and s.cardid = i.cardid
 and i.status < 50
 and (i.suppliertransactiontype  < 79900 or i.suppliertransactiontype > 79999)


--create or replace view nghi_tempsaleview as
select s.cardid, s.issueddate, s.salesmerchantid, s.vouchercode, s.salecode, retrievesalecodename(s.salecode) salecodename, s.salecost, s.saleinvoicecost, s.status,
i.*
from salecodecardsummary s, temp_cardusage i
where s.salecodeownerid = 47580
 and s.cardid = i.cardid(+)
order by s.cardid

select * from passsummarytransaction where cardid = 903600399770003693

41,410 