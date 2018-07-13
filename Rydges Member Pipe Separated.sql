create or replace view tempmember2 as
select p.givenname, p.familyname, m.externalmemberid, m.sourceid, membershiplevel, m.programstatus, 0 as temporarymember, 
to_char(m.joineddate,'dd/mm/yyyy') joineddate,
(select sum(((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired))) balance from memberpoints
where externalmemberid = m.externalmemberid
and productmgrid = m.productmgrid
and cardprodclassid in (852,862)) pointsbalance,
(select substr(comments, 12, (length(comments)-9)) from CARDFULFILMENTREQUEST where externalmemberid = m.externalmemberid
and productmgrid = m.productmgrid and packcode in (60,61) and rownum=1 and comments like '%FROM KIOSK%' and status < 50) ENROLMENTCODE,
(select companycodeid from cardregistration where externalmemberid = m.externalmemberid
and productmgrid = m.productmgrid) COMPANYCODEID,
ab.emailaddress
from member m, person p, addressbook ab
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and m.personid = p.personid
and p.addressbookid = ab.addressbookid
union
select c.givenname, c.familyname, c.externalmemberid, c.sourceid, 0 as membershiplevel, c.programstatus, 1 as temporarymember,
to_char(c.joineddate,'dd/mm/yyyy') joineddate,
0 as pointsbalance,
(select substr(comments, 12, (length(comments)-9)) from CARDFULFILMENTREQUEST where externalmemberid = c.externalmemberid
and productmgrid = c.productmgrid and packcode in (60,61) and rownum=1 and comments like '%FROM KIOSK%' and status < 50) ENROLMENTCODE,
c.companycodeid,
c.emailaddress
from cardregistration c
where c.productmgrid in (22181,22191)
and c.externalmemberid like 'R%'
and not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid);
 
select GIVENNAME, FAMILYNAME, EXTERNALMEMBERID, SOURCEID, MEMBERSHIPLEVEL,
joineddate as CREATIONDATE, POINTSBALANCE, '' AS ENROLMENTCODE, COMPANYCODEID, EMAILADDRESS, programstatus, cardstatus, expirydate
from temp_nghitemptable12
WHERE REGEXP_LIKE (emailaddress, '[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}')
and sourceid > 0
and programstatus = 1
and cardstatus not in (5,9)
and sourceid not in (
select sourceid from (select count(distinct externalmemberid) countmembers, sourceid
from temp_nghitemptable12
where sourceid > 0
and programstatus = 1
group by sourceid
having count(distinct externalmemberid) > 1
))

drop table temp_nghitemptable12;

create table temp_nghitemptable12 nologging as
select * from tempmember2

--------------------------------------NEW QUERY WITH CARD STATUS --------------------------------
create or replace view tempmember2 as
select p.givenname, p.familyname, m.externalmemberid, m.sourceid, membershiplevel, m.programstatus, 0 as temporarymember, 
to_char(m.joineddate,'dd/mm/yyyy') joineddate,
(select sum(((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired))) balance from memberpoints
where externalmemberid = m.externalmemberid
and productmgrid = m.productmgrid
and cardprodclassid in (852,862)) pointsbalance,
(select substr(comments, 12, (length(comments)-9)) from CARDFULFILMENTREQUEST where externalmemberid = m.externalmemberid
and productmgrid = m.productmgrid and packcode in (60,61) and rownum=1 and comments like '%FROM KIOSK%' and status < 50) ENROLMENTCODE,
(select companycodeid from cardregistration where externalmemberid = m.externalmemberid
and productmgrid = m.productmgrid) COMPANYCODEID,
p.emailaddress,
cm.status as cardstatus, cm.expirydate as expirydate
from member m, cardmember cm, customerinformation p
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and m.personid = p.personid
and m.externalmemberid = cm.externalmemberid
and m.productmgrid = cm.productmgrid
and cm.status < 50
union
select c.givenname, c.familyname, c.externalmemberid, c.sourceid, 0 as membershiplevel, c.programstatus, 1 as temporarymember,
to_char(c.joineddate,'dd/mm/yyyy') joineddate,
0 as pointsbalance,
(select substr(comments, 12, (length(comments)-9)) from CARDFULFILMENTREQUEST where externalmemberid = c.externalmemberid
and productmgrid = c.productmgrid and packcode in (60,61) and rownum=1 and comments like '%FROM KIOSK%' and status < 50) ENROLMENTCODE,
c.companycodeid,
c.emailaddress, -1 as cardstatus, null as expirydate
from cardregistration c
where c.productmgrid in (22181,22191)
and c.externalmemberid like 'R%'
and not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid);

------------- Official query
select GIVENNAME, FAMILYNAME, EXTERNALMEMBERID, SOURCEID, MEMBERSHIPLEVEL,
joineddate as JOINEDDATE, POINTSBALANCE, nvl(enrolmentcode, 'ONLINE') AS ENROLMENTCODE, COMPANYCODEID, EMAILADDRESS, programstatus
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
 
------------- Special request include status 3
select GIVENNAME, FAMILYNAME, EXTERNALMEMBERID, SOURCEID, MEMBERSHIPLEVEL,
joineddate as CREATIONDATE, POINTSBALANCE, '' AS ENROLMENTCODE, COMPANYCODEID, EMAILADDRESS, programstatus
from temp_nghitemptable12
WHERE REGEXP_LIKE (emailaddress, '[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}')
and sourceid > 0
and programstatus in (3)
and cardstatus not in (5,9)
and sourceid not in (
select sourceid from (select count(distinct externalmemberid) countmembers, sourceid
from temp_nghitemptable12
where sourceid > 0
and programstatus in (3)
group by sourceid
having count(distinct externalmemberid) > 1
))


 