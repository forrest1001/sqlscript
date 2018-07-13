-- Program enrolment 

-- From old
--select count(*) from addcardrequesthistory 
--where memberid like 'R%'
--   and creationdate >= to_date('01/07/2007','dd/mm/yyyy')
--   and creationdate < to_date('22/09/2016','dd/mm/yyyy')
--   and errorcode = 1;
-------------------------------------------------------------------------------------------------------------   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/07/2016','dd/mm/yyyy')
and createddate < to_date('22/09/2016','dd/mm/yyyy');

-- From KIOSK   
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('01/07/2016','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('01/07/2016','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');
-------------------------------------------------------------------------------------------------------------   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/09/2016','dd/mm/yyyy')
and createddate < to_date('22/09/2016','dd/mm/yyyy');

-- From KIOSK   
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('01/09/2016','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('01/09/2016','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');
-------------------------------------------------------------------------------------------------------------   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('15/09/2016','dd/mm/yyyy')
and createddate < to_date('22/09/2016','dd/mm/yyyy');

-- From KIOSK   
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('15/09/2016','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('15/09/2016','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');
-------------------------------------------------------------------------------------------------------------   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/07/2007','dd/mm/yyyy')
and createddate < to_date('22/09/2016','dd/mm/yyyy');

-- From KIOSK   
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('01/07/2007','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('01/07/2007','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');
--***********************************************************************   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('21/09/2015','dd/mm/yyyy')
and createddate < to_date('22/09/2016','dd/mm/yyyy');

-- From KIOSK   
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('21/09/2015','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('21/09/2015','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');
--***********************************************************************   
-- From web
select count(*) from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('21/03/2015','dd/mm/yyyy')
and createddate < to_date('22/09/2016','dd/mm/yyyy');

-- From KIOSK   
select count(*) from cardfulfilmentrequest c
where pickuptype = 10
and comments like '%FROM KIOSK%'
and productmgrid in (22181,22191)
and creationdate >= to_date('21/03/2015','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');

-- From FTP
select count(*) from cardfulfilmentrequest
where comments like '%FTP%'
and creationdate >= to_date('21/03/2015','dd/mm/yyyy')
and creationdate < to_date('22/09/2016','dd/mm/yyyy');