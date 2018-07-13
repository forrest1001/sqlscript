drop table temp_cardmemberunique2;

create table temp_cardmemberunique2 as
select cardid,cardpkgclassid,comments,creationdate,expirydate,externalmemberid,hardexpirydate,memberid,modifieddate,
packcode,previouscardid,productmgrid,salecode,saleid,status
from 
(
select cardid,cardpkgclassid,comments,creationdate,expirydate,externalmemberid,hardexpirydate,memberid,modifieddate,
packcode,previouscardid,productmgrid,salecode,saleid,status,
max(creationdate) over (partition by externalmemberid) max_creationdate
from cardmember
where productmgrid in (22181,22191)
  and externalmemberid like 'R%'
)
where creationdate = max_creationdate;

create index indx_temp_cardmemberunique2 on temp_cardmemberunique2(externalmemberid, productmgrid);

drop table temp_rydgesmember_rpg2;

create table temp_rydgesmember_rpg2
(
  externalmemberid varchar2(60 byte),
  sourceid integer,
  familyname varchar2(300 byte),
  givenname varchar2(300 byte),  
  joineddate date,
  street1 varchar2(600 byte),
  street2 varchar2(600 byte),
  citysuburb varchar2(600 byte),
  statecode varchar2(600 byte),
  postcode varchar2(60 byte),
  countrycode varchar2(50 byte),
  emailaddress varchar2(300 byte),
  statustext varchar2(100 byte),
  status number
);

select * from temp_rydgesmember_rpg2;

-- Remove duplicate members
delete temp_rydgesmember_rpg2
where externalmemberid in (select externalmemberid from (
select externalmemberid, count(sourceid) 
from temp_rydgesmember_rpg2
group by externalmemberid
having count(sourceid) > 1)) 

drop table temp_rydgesmember2;

create table temp_rydgesmember2 as
select 1 as memberstatus, m.externalmemberid, m.productmgrid, p.familyname, p.givenname, m.creationdate, a.street1, a.street2, a.citysuburb, a.statecode, a.postcode, a.countrycode, ab.emailaddress
from member m, person p, address a, addressbook ab
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and m.personid = p.personid
and p.addressbookid = a.addressbookid
and p.addressbookid = ab.addressbookid
union
select 2 as memberstatus, c.externalmemberid, c.productmgrid, c.familyname, c.givenname, 
c.modifieddate creationdate, c.addressline1 street1, c.addressline2 street2, c.citysuburb, c.state, c.postcode, c.country, c.emailaddress
from cardregistration c
where c.productmgrid in (22181,22191)
  and not exists (select * from member where externalmemberid = c.externalmemberid);

create index indx_temp_rydgesmember2 on temp_rydgesmember2(externalmemberid, productmgrid);

-- check for duplication in 2 programs
select externalmemberid, count(productmgrid) from temp_rydgesmember2
group by externalmemberid;

drop table temp_rydgesmember_svs2;

create table temp_rydgesmember_svs2 as
select t1.*, t2.status
from temp_rydgesmember2 t1, temp_cardmemberunique2 t2
where t1.externalmemberid = t2.externalmemberid(+)
and t1.productmgrid = t2.productmgrid(+);

select distinct externalmemberid from temp_rydgesmember_rpg2; -- 1,245,993

select distinct externalmemberid from temp_rydgesmember_svs2 -- 983,163 Removed R2105998 from 22191

-- 1,245,670

drop table temp_rpgsvscombine2;

create table temp_rpgsvscombine2 as
select
t1.externalmemberid,t1.sourceid,
t1.familyname,t1.givenname,
t1.joineddate,t1.street1,t1.street2,
t1.citysuburb,t1.statecode,t1.postcode,t1.countrycode,
t1.emailaddress, t1.statustext, t1.status,
t2.memberstatus memberstatus_svs,
t2.externalmemberid externalmemberid_svs,
t2.familyname familyname_svs,t2.givenname givenname_svs,
t2.creationdate creationdate_svs,t2.street1 street1_svs,t2.street2 street2_svs,
t2.citysuburb citysuburb_svs,t2.statecode statecode_svs,t2.postcode postcode_svs,t2.countrycode countrycode_svs,
t2.emailaddress emailaddress_svs, t2.status status_svs
from temp_rydgesmember_rpg2 t1, temp_rydgesmember_svs2 t2
where t1.externalmemberid = t2.externalmemberid(+);

-- Only update members which exists in member table
drop table temp_tobeupdatemember2;
 
create table temp_tobeupdatemember2 as
select t.externalmemberid, t.sourceid, t.familyname, t.givenname, t.joineddate, t.street1, t.street2, t.citysuburb, t.statecode, t.postcode, t.countrycode, t.emailaddress, t.statustext, 
decode(t.statustext, 'Active', 1,'Inactive',2,'Expired',3) status,
m.personid, p.addressbookid
from temp_rpgsvscombine2 t, member m, person p
where t.memberstatus_svs = 1
and t.externalmemberid = m.externalmemberid
and m.personid = p.personid;

-- 37,907

create index indx_temp_tobeupdatemember2 on temp_tobeupdatemember2(externalmemberid);


select * from temp_tobeupdatemember2;

-- backup tables
create table temp_person as select * from person;

create table temp_address as select * from address;

create table temp_addressbook as select * from addressbook;

--------------------------------------------------------------------------------
MERGE INTO person t1
USING
(
-- For more complicated queries you can use WITH clause here
SELECT * FROM temp_tobeupdatemember2 t where exists (select personid from person where personid = t.personid)
)t2
ON(t1.personid = t2.personid)
WHEN MATCHED THEN UPDATE SET
t1.familyname = t2.familyname,
t1.givenname = t2.givenname;
--------------------------------------------------------------------------------
MERGE INTO addressbook t1
USING
(
-- For more complicated queries you can use WITH clause here
SELECT * FROM temp_tobeupdatemember2 t 
)t2
ON(t1.addressbookid = t2.addressbookid)
WHEN MATCHED THEN UPDATE SET
t1.emailaddress = t2.emailaddress
;
--------------------------------------------------------------------------------
MERGE INTO address t1
USING
(
-- For more complicated queries you can use WITH clause here
SELECT * FROM temp_tobeupdatemember2 t 
)t2
ON(t1.addressbookid = t2.addressbookid)
WHEN MATCHED THEN UPDATE SET
t1.street1 = t2.street1,
t1.street2 = t2.street2,
t1.citysuburb = t2.citysuburb,
t1.statecode = t2.statecode,
t1.postcode = t2.postcode,
t1.countrycode = t2.countrycode
;
--------------------------------------------------------------------------------
MERGE INTO member t1
USING
(
-- For more complicated queries you can use WITH clause here
SELECT * FROM temp_tobeupdatemember2 t
)t2
ON(t1.externalmemberid = t2.externalmemberid)
WHEN MATCHED THEN UPDATE SET
t1.startdate = t2.joineddate,
t1.sourceid = t2.sourceid,
t1.programstatus = t2.status;

create or replace view tempmember2 as
select p.givenname, p.familyname, m.externalmemberid, m.sourceid, membershiplevel,  
to_char(m.startdate,'dd/mm/yyyy') joineddate,
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
union
select c.givenname, c.familyname, c.externalmemberid, c.sourceid, 0 as membershiplevel,  
to_char(c.joineddate,'dd/mm/yyyy') joineddate,
0 as pointsbalance,
(select substr(comments, 12, (length(comments)-9)) from CARDFULFILMENTREQUEST where externalmemberid = c.externalmemberid 
and productmgrid = c.productmgrid and packcode in (60,61) and rownum=1 and comments like '%FROM KIOSK%' ) ENROLMENTCODE,
c.companycodeid,
c.emailaddress
from cardregistration c
where c.productmgrid in (22181,22191)
and c.externalmemberid like 'R%'
and not exists (select * from member where externalmemberid = c.externalmemberid and productmgrid = c.productmgrid);
