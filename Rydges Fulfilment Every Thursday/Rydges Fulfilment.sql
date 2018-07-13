drop table temp_nghitemptable2;

create table temp_nghitemptable2 nologging
as
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'KIOSK' as SOURCEOFFICEID,  
C.PACKCODE, c.pickupcode as SOURCE,  
c.pickupcode as hotelcode , retrieveexternalid(c.pickupoperatorid) as fulfilment,
(select companycodeid from cardregistration where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid and status < 50) companycodeid,
(select enrolmentcode from member where externalmemberid = c.externalmemberid) enrolmentcode
from cardfulfilmentrequest c
where 
C.FULFILLEDDATE >= to_date('28/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('05/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments like 'FROM KIOSK%'
union 
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'BOOKING' as SOURCEOFFICEID, 
 C.PACKCODE, 
 'BOOKING ' || c.pickupcode || '/' || R.RESERVATIONNUMBER as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment,
(select companycodeid from cardregistration where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid and status < 50) companycodeid,
(select enrolmentcode from member where externalmemberid = c.externalmemberid) enrolmentcode
from cardfulfilmentrequest c, rydgesbooking r
where 
C.FULFILLEDDATE >= to_date('28/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('05/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments like 'BOOKING%' and
substr(c.comments, 9) = R.RYDGESBOOKINGID(+)
union
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'SORSE' as SOURCEOFFICEID, 
c.packcode, c.comments as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment,
(select companycodeid from cardregistration where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid and status < 50) companycodeid,
(select enrolmentcode from member where externalmemberid = c.externalmemberid) enrolmentcode 
from cardfulfilmentrequest c
where 
C.FULFILLEDDATE >= to_date('28/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('05/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments not like 'BOOKING%' and
c.comments not like 'FROM KIOSK%'
union
 select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'SORSE' as SOURCEOFFICEID, 
c.packcode, 'No Comments' as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment,
(select companycodeid from cardregistration where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid and status < 50) companycodeid, 
(select enrolmentcode from member where externalmemberid = c.externalmemberid) enrolmentcode
from cardfulfilmentrequest c
where 
C.FULFILLEDDATE >= to_date('28/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('05/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments is null
order by issueddate;

select * from temp_nghitemptable2
order by issueddate;

select distinct sourceofficeid from temp_nghitemptable2;

select * from 
(
select hotelcode, sourceofficeid, cardid 
from temp_nghitemptable2
order by hotelcode
)
pivot
(
count(cardid) for sourceofficeid in ('BOOKING', 'KIOSK', 'SORSE')
)
order by hotelcode;
