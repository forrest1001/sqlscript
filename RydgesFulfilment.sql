select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'KIOSK' as SOURCEOFFICEID,  
C.PACKCODE, c.pickupcode as SOURCE,  
c.pickupcode as hotelcode , retrieveexternalid(c.pickupoperatorid) as fulfilment
from cardfulfilmentrequest c
where 
C.FULFILLEDDATE >= to_date('01/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('01/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments like 'FROM KIOSK%'
union 
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'BOOKING' as SOURCEOFFICEID, 
 C.PACKCODE, 
 'BOOKING ' || c.pickupcode || '/' || R.RESERVATIONNUMBER as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment
from cardfulfilmentrequest c, rydgesbooking r
where 
C.FULFILLEDDATE >= to_date('01/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('01/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments like 'BOOKING%' and
substr(c.comments, 9) = R.RYDGESBOOKINGID(+)
union
select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'SORSE' as SOURCEOFFICEID, 
c.packcode,
 c.comments as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment
from cardfulfilmentrequest c
where 
C.FULFILLEDDATE >= to_date('01/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('01/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments not like 'BOOKING%' and
c.comments not like 'FROM KIOSK%'
union
 select c.PRODUCTMGRID, c.EXTERNALMEMBERID as memberid, formatcardid(c.cardid) as cardid, c.TITLE, c.GIVENNAME, c.FAMILYNAME, c.FULFILLEDDATE as issueddate, 'SORSE' as SOURCEOFFICEID, 
c.packcode, 'No Comments' as SOURCE, c.pickupcode as hotelcode, retrieveexternalid(c.pickupoperatorid) as fulfilment 
from cardfulfilmentrequest c
where 
C.FULFILLEDDATE >= to_date('01/06/2018','dd/mm/yyyy') and
c.FULFILLEDDATE < to_date('01/07/2018','dd/mm/yyyy') and
C.PRODUCTMGRID in (22181, 22191) and
c.comments is null
order by issueddate