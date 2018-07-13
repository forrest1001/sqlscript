create or replace view temp_nghitempview as 

select retrievepersonname(personid) name, externalmemberid, membershiplevel, creationdate,
(select sum(((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired))) balance from memberpoints 
where externalmemberid = m.externalmemberid 
and productmgrid = m.productmgrid 
and cardprodclassid in (852,862)) pointsbalance,
(select substr(comments, 12, (length(comments)-9)) from CARDFULFILMENTREQUEST where externalmemberid = m.externalmemberid 
and productmgrid = m.productmgrid and packcode in (60,61) and rownum=1 and comments like '%FROM KIOSK%' ) ENROLMENTCODE,
(select companycodeid from cardregistration where externalmemberid = m.externalmemberid 
and productmgrid = m.productmgrid) COMPANYCODEID
from member m
where productmgrid in (22181,22191);


select *
 from (
select /*+ first_rows(25) */
  name, externalmemberid, membershiplevel, creationdate, pointsbalance,
  row_number() 
  over (order by externalmemberid)rn
 from (
 select retrievepersonname(personid) name, externalmemberid, membershiplevel, creationdate,
(select sum(((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired))) balance 
from memberpoints 
where externalmemberid = m.externalmemberid 
and productmgrid = m.productmgrid 
and cardprodclassid in (852,862)) pointsbalance
from member m
where productmgrid in (22181,22191) 
 ) )
where rn between :n and :m 
order by rn; 

