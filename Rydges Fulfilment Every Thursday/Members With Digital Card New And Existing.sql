with memberwithdigitalcard
as
(
select distinct externalmemberid 
from cardmember 
where cardid like '6299%'
and creationdate < to_date('28/06/2018','dd/mm/yyyy') 
group by externalmemberid
),
membernondigitalcard as
(
select externalmemberid, (select count(cardid) from cardmember where externalmemberid = m.externalmemberid and cardid not like '6299%') nondigitalcards
from memberwithdigitalcard m
)
select * from membernondigitalcard where nondigitalcards <> 0

