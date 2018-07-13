create or replace view temp_nghitempview as 
with memberdata as
(
select externalmemberid, creationdate, enrolmentcode  from member
where creationdate >= to_date('05/07/2018','dd/mm/yyyy')
and creationdate < to_date('12/07/2018','dd/mm/yyyy') 
union
select externalmemberid, createddate creationdate, sourceofficeid enrollmentcode from cardregistration c
where createddate >= to_date('05/07/2018','dd/mm/yyyy')
and createddate < to_date('12/07/2018','dd/mm/yyyy')
and not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid)
)
select m.*,
(select count(cardid) from cardmember where externalmemberid = m.externalmemberid and cardid like '%6299%%') digitalcard
from memberdata m;

select enrolmentcode, count(externalmemberid) members, sum(digitalcard) digitalcards
from temp_nghitempview
group by enrolmentcode

select * from cardmember where externalmemberid = 'R2192177'

select * from cardregistration

select * from member where externalmemberid = 'R2742956'

select * from cardregistration where externalmemberid = 'R2742956'

select * from member where externalmemberid in (
'R1424895',
'R2105663',
'R2130249',
'R2133242',
'R2141198',
'R2141598',
'R2143245'
)  