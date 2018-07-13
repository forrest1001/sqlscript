select * from member m where
productmgrid in (22181,22191)
and externalmemberid like 'R%'
--and not exists (select * from customerinformation where personid = m.personid)

--1,043,772

select m.externalmemberid, m.membershiplevel, m.joineddate joineddate, 
c.title, c.givenname, c.familyname, c.addressline1, c.addressline2, c.addressline3, c.emailaddress, c.mobilephone, c.homephone,
(select sum((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired)) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (852,862)) bal852862,
(select sum(redemptioncount) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (852,862)) redemption852862,
(select sum(issuancecount) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) count851861,
(select sum(issuancecount) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (895,900)) count895900,
(select sum(pointsissued - pointsreverseissued) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) sum851861,
(select sum(pointsissued - pointsreverseissued) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (895,900)) sum895900
from member m, customerinformation c
where m.productmgrid in (22181,22191)
and m.personid = c.personid
and m.externalmemberid like 'R%'
union all
select c.externalmemberid, -1 as membershiplevel, c.createddate joineddate, 
c.title, c.givenname, c.familyname, c.addressline1, c.addressline2, c.addressline3, c.emailaddress, c.mobilenumber mobilephone, c.homephonenumber homephone,
0 as bal852862,
0 as redemption852862,
0 as count851861,
0 as count895900,
0 as sum851861,
0 as sum895900
from cardregistration c
where c.productmgrid in (22181,22191) 
and not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid)




--1,035,480

1,037,001

-- Break down to smaller files

select m.externalmemberid, m.membershiplevel, m.joineddate joineddate, 
c.title, c.givenname, c.familyname, c.addressline1, c.addressline2, c.addressline3, c.emailaddress, c.mobilephone, c.homephone,
(select sum((pointsissued - pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired)) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (852,862)) bal852862,
(select sum(redemptioncount) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (852,862)) redemption852862,
(select sum(issuancecount) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) count851861,
(select sum(issuancecount) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (895,900)) count895900,
(select sum(pointsissued - pointsreverseissued) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (851,861)) sum851861,
(select sum(pointsissued - pointsreverseissued) from memberpoints where externalmemberid = m.externalmemberid and productmgrid = m.productmgrid and cardprodclassid in (895,900)) sum895900
from member m, customerinformation c
where m.productmgrid in (22181,22191)
and m.personid = c.personid
and m.externalmemberid like 'R%'
and m.membershiplevel = 2





select c.externalmemberid, -1 as membershiplevel, c.createddate joineddate, 
c.title, c.givenname, c.familyname, c.addressline1, c.addressline2, c.addressline3, c.emailaddress, c.mobilenumber mobilephone, c.homephonenumber homephone,
0 as bal852862,
0 as redemption852862,
0 as count851861,
0 as count895900,
0 as sum851861,
0 as sum895900
from cardregistration c
where c.productmgrid in (22181,22191) 
and not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid)
