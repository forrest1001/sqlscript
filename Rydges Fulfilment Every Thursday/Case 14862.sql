select country, count(externalmemberid) 
from 
(
select m.externalmemberid, m.membershiplevel, c.state, c.country
from member m, customerinformation c
where m.productmgrid in (22181,22191)
and m.personid = c.personid
and m.externalmemberid like 'R%'
union all
select c.externalmemberid, -1 as membershiplevel, c.state, c.country
from cardregistration c
where c.productmgrid in (22181,22191) 
and not exists (select * from member where externalmemberid = c.externalmemberid)
)
where country in ('GB','UK','US','USA')
group by country

1,574,000