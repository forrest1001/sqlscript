drop table temp_nghitemptable1;
create table temp_nghitemptable1 nologging
as
select distinct externalmemberid, productmgrid
from instantrewsummarytransaction  
where suppliertransactiontype < 60000
  and productmgrid in (22181,22191)
  and transactiondate >= to_date('01/06/2017','dd/mm/yyyy')
  and transactiondate < to_date('01/07/2018','dd/mm/yyyy')
  and status < 50
union
select distinct externalmemberid, productmgrid
from loyaltypntssummarytransaction 
where suppliertransactiontype < 60000
  and productmgrid in (22181,22191)
  and transactiondate >= to_date('01/06/2017','dd/mm/yyyy')
  and transactiondate < to_date('01/07/2018','dd/mm/yyyy')
  and status < 50
union
select distinct externalmemberid, productmgrid
from couponsummarytransaction  
where suppliertransactiontype < 60000
  and productmgrid in (22181,22191)
  and transactiondate >= to_date('01/06/2017','dd/mm/yyyy')
  and transactiondate < to_date('01/07/2018','dd/mm/yyyy')
  and status < 50
union
select distinct externalmemberid, productmgrid
from passsummarytransaction  
where suppliertransactiontype < 60000
  and productmgrid in (22181,22191)
  and transactiondate >= to_date('01/06/2017','dd/mm/yyyy')
  and transactiondate < to_date('01/07/2018','dd/mm/yyyy')
  and status < 50;
  
select m.externalmemberid, m.productmgrid, m.anniversarydate
from member m, cardmember c, temp_nghitemptable1 t
where m.externalmemberid = c.externalmemberid
  and m.productmgrid = c.productmgrid
  and m.productmgrid in (22181,22191,20454,23142,24627)
  and m.externalmemberid = t.externalmemberid
  and m.productmgrid = t.productmgrid
  and m.anniversarydate < to_date('01/06/2018','dd/mm/yyyy')
  and to_char(m.anniversarydate, 'MM') = '06'
  and c.status = 0
order by productmgrid