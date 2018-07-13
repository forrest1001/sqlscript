with datatable as(
select GIVENNAME, FAMILYNAME, EXTERNALMEMBERID, SOURCEID, MEMBERSHIPLEVEL,
joineddate as JOINEDDATE, nvl(POINTSBALANCE, 0) pointsbalance, nvl(enrolmentcode, 'ONLINE') AS ENROLMENTCODE, COMPANYCODEID, EMAILADDRESS, programstatus
from temp_nghitemptable12
WHERE REGEXP_LIKE (emailaddress, '[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}')
and sourceid > 0
and programstatus in (1,3)
and cardstatus not in (5,9)
and sourceid not in (
select sourceid from (select count(distinct externalmemberid) countmembers, sourceid
from temp_nghitemptable12
where sourceid > 0
and programstatus in (1,3)
group by sourceid
having count(distinct externalmemberid) > 1
))
)
select
membershiplevel, 
case 
    when pointsbalance = 0 then '0'
    when (pointsbalance > 0 and pointsbalance < 10) then '1-9'
    when (pointsbalance >= 10 and pointsbalance < 20) then '10-19'
    when (pointsbalance >= 20 and pointsbalance < 50) then '20-49'
    when (pointsbalance >= 50 and pointsbalance < 100) then '50-99'
    when (pointsbalance >= 100 and pointsbalance < 200) then '100-199'
    when (pointsbalance >= 200 and pointsbalance < 500) then '200-499'
    else '500'
end as pointrange,
count(externalmemberid) members
from datatable
group by membershiplevel,
case 
    when pointsbalance = 0 then '0'
    when (pointsbalance > 0 and pointsbalance < 10) then '1-9'
    when (pointsbalance >= 10 and pointsbalance < 20) then '10-19'
    when (pointsbalance >= 20 and pointsbalance < 50) then '20-49'
    when (pointsbalance >= 50 and pointsbalance < 100) then '50-99'
    when (pointsbalance >= 100 and pointsbalance < 200) then '100-199'
    when (pointsbalance >= 200 and pointsbalance < 500) then '200-499'
    else '500'
end



with datatable as(
select GIVENNAME, FAMILYNAME, EXTERNALMEMBERID, SOURCEID, MEMBERSHIPLEVEL,
joineddate as JOINEDDATE, nvl(POINTSBALANCE, 0) pointsbalance, nvl(enrolmentcode, 'ONLINE') AS ENROLMENTCODE, COMPANYCODEID, EMAILADDRESS, programstatus
from temp_nghitemptable12
WHERE REGEXP_LIKE (emailaddress, '[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}')
and sourceid > 0
and programstatus in (1,3)
and cardstatus not in (5,9)
and sourceid not in (
select sourceid from (select count(distinct externalmemberid) countmembers, sourceid
from temp_nghitemptable12
where sourceid > 0
and programstatus in (1,3)
group by sourceid
having count(distinct externalmemberid) > 1
))
)
select membershiplevel, count(externalmemberid)
from datatable
where pointsbalance >= 100
and pointsbalance < 200
group by membershiplevel
