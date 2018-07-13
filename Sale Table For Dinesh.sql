select salesmerchantid, salecodeownerid, distributorid, salecode, saleinvoicecost, pmsaleinvoicecost, saleinvoicedate, saledate

select to_char(saledate, 'YYYYMM') month, salesmerchantid, retrievedisplayname(salesmerchantid) salesmerchantname, 
salecodeownerid, distributorid, retrievedisplayname(distributorid) distributorname,  sum(saleinvoicecost) saleinvoicecost, sum(pmsaleinvoicecost) pmsaleinvoicecost
from salecodecardsummary
where salesmerchantid in 
(24778,25234,25303,25320,46350,
46588,46592,46594,46629,46726,
46826,46839,46963,47014,47095,
47635,47690,47692,47823,48020,
48114,48394,48811,24758,48508)
and saleinvoicedate is not null
and saledate > to_date('01/10/2016','dd/mm/yyyy') 
group by to_char(saledate, 'YYYYMM'), salesmerchantid, salecodeownerid, distributorid