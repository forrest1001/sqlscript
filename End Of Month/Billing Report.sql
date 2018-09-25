select retrievedisplayname(productmgrid) productmanager, retrievedisplayname(operatorid) operator, 
       cardprodclassid product, retrievecardprodclassname(cardprodclassid) name, 
       decode(issuanceflag, 1, 'Add', 0, 'Deduct') type, 
       sum(value) totalvalue, sum(totalinvoicecost) totalcost, currency
from couponsummarytransaction c, report r   
where r.startdate >= to_date('01/08/2018','dd/mm/yyyy')
  and r.enddate < to_date('01/09/2018','dd/mm/yyyy')
  and c.status < 50
  and c.reportid = r.reportid
group by operatorid, cardprodclassid, issuanceflag, currency, productmgrid
union
select retrievedisplayname(productmgrid) productmanager, retrievedisplayname(operatorid) operator, 
       cardprodclassid product, retrievecardprodclassname(cardprodclassid) name, 
       decode(issuanceflag, 1, 'Add', 0, 'Deduct') type, 
       sum(value) totalvalue, sum(totalinvoicecost) totalcost, currency
from instantrewsummarytransaction c, report r   
where r.startdate >= to_date('01/08/2018','dd/mm/yyyy')
  and r.enddate < to_date('01/09/2018','dd/mm/yyyy')
  and c.status < 50
  and c.reportid = r.reportid
group by operatorid, cardprodclassid, issuanceflag, currency, productmgrid