drop table temp_nghitemptable2

create table temp_nghitemptable2
as
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.CREATIONDATE as creationdate, c.FULFILLEDDATE, 'KIOSK' as SOURCEOFFICEID,  
C.PACKCODE, c.pickupcode as SOURCE,  
c.pickupcode as hotelcode , retrieveexternalid(c.pickupoperatorid) as fulfilment
from cardfulfilmentrequest c
where 
C.CREATIONDATE >= to_date('01/08/2014','dd/mm/yyyy') and
--c.CREATIONDATE < to_date('31/07/2014','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments like 'FROM KIOSK%'
union 
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.CREATIONDATE as creationdate, c.FULFILLEDDATE, 'BOOKING' as SOURCEOFFICEID, 
 C.PACKCODE, 
 'BOOKING ' || c.pickupcode || '/' || R.RESERVATIONNUMBER as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment
from cardfulfilmentrequest c, rydgesbooking r
where 
C.CREATIONDATE >= to_date('01/08/2014','dd/mm/yyyy') and
--c.CREATIONDATE < to_date('31/07/2014','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments like 'BOOKING%' and
substr(c.comments, 9) = R.RYDGESBOOKINGID(+)
union
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.CREATIONDATE as creationdate, c.FULFILLEDDATE, 'SORSE' as SOURCEOFFICEID, 
c.packcode,
 c.comments as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment
from cardfulfilmentrequest c
where 
C.CREATIONDATE >= to_date('01/08/2014','dd/mm/yyyy') and
--c.CREATIONDATE < to_date('31/07/2014','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments not like 'BOOKING%' and
c.comments not like 'FROM KIOSK%'
union
 select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.CREATIONDATE as creationdate, c.FULFILLEDDATE, 'SORSE' as SOURCEOFFICEID, 
c.packcode, 'No Comments' as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment 
from cardfulfilmentrequest c
where 
C.CREATIONDATE >= to_date('01/08/2014','dd/mm/yyyy') and
--c.CREATIONDATE < to_date('31/07/2014','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments is null
order by creationdate;

select * from temp_nghitemptable2
order by creationdate

select distinct sourceofficeid from temp_nghitemptable2

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
order by hotelcode
