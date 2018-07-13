create or replace view tempmember as
select p.givenname, p.familyname, m.externalmemberid, m.sourceid, membershiplevel,  
to_char(creationdate,'dd/mm/yyyy') creationdate,
(select sum(((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired))) balance from memberpoints 
where externalmemberid = m.externalmemberid 
and productmgrid = m.productmgrid 
and cardprodclassid in (852,862)) pointsbalance,
(select substr(comments, 12, (length(comments)-9)) from CARDFULFILMENTREQUEST where externalmemberid = m.externalmemberid 
and productmgrid = m.productmgrid and packcode in (60,61) and rownum=1 and comments like '%FROM KIOSK%' ) ENROLMENTCODE,
(select companycodeid from cardregistration where externalmemberid = m.externalmemberid 
and productmgrid = m.productmgrid) COMPANYCODEID,
ab.emailaddress
from member m, person p, addressbook ab
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and m.personid = p.personid 
and p.addressbookid = ab.addressbookid


select givenname, familyname, externalmemberid, sourceid, membershiplevel, creationdate, nvl(pointsbalance, 0) pointsbalance, enrolmentcode, companycodeid, emailaddress
from tempmember

985,062