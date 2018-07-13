drop table temp_cardmemberunique;

create table temp_cardmemberunique as
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

create index indx_temp_cardmemberunique on temp_cardmemberunique(externalmemberid, productmgrid);

select m.externalmemberid, p.familyname, p.givenname, m.creationdate, a.street1, a.street2, a.citysuburb, a.statecode, a.postcode, a.countrycode
from member m, temp_cardmemberunique cm, person p, address a, addressbook ab
where m.externalmemberid = cm.externalmemberid
and m.productmgrid = cm.productmgrid
and m.productmgrid in (22181,22191)
and cm.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and cm.externalmemberid like 'R%'
and m.personid = p.personid
and p.addressbookid = a.addressbookid
and p.addressbookid = ab.addressbookid;

-- 946,804

select * 
from member m 
where m.productmgrid in (22181,22191) 
  and m.externalmemberid like 'R%';

-- 982,604

select m.externalmemberid, p.familyname, p.givenname, m.creationdate, a.street1, a.street2, a.citysuburb, a.statecode, a.postcode, a.countrycode
from member m, person p, address a, addressbook ab
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and m.personid = p.personid
and p.addressbookid = a.addressbookid
and p.addressbookid = ab.addressbookid;

-- 982,603

select * from member m 
where m.productmgrid in (22181,22191)
and m.externalmemberid like 'R%'
and not exists (select * from person where personid = m.personid)

-- Member without person R1190382

select * from person where personid = 1779474;

drop table temp_rydgesmember_rpg;

create table temp_rydgesmember_rpg
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

select * from temp_rydgesmember_rpg; 

-- 1,245,993
-- 622,995 File 1
-- 622,998 File 2

drop table temp_rydgesmember;

create table temp_rydgesmember as
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

create index indx_temp_rydgesmember on temp_rydgesmember(externalmemberid, productmgrid);

-- check for duplication in 2 programs
select externalmemberid, count(productmgrid) from temp_rydgesmember
group by externalmemberid;

drop table temp_rydgesmember_svs;

create table temp_rydgesmember_svs as
select t1.*, t2.status
from temp_rydgesmember t1, temp_cardmemberunique t2
where t1.externalmemberid = t2.externalmemberid(+)
and t1.productmgrid = t2.productmgrid(+);

select distinct externalmemberid from temp_rydgesmember_rpg; -- 1,245,993

select distinct externalmemberid from temp_rydgesmember_svs -- 983,163 Removed R2105998 from 22191

-- 1,245,670

drop table temp_rpgsvscombine;

create table temp_rpgsvscombine as
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
from temp_rydgesmember_rpg t1, temp_rydgesmember_svs t2
where t1.externalmemberid = t2.externalmemberid(+);

-- Only update members which exists in member table
drop table temp_tobeupdatemember;
 
create table temp_tobeupdatemember as
select t.externalmemberid, t.sourceid, t.familyname, t.givenname, t.joineddate, t.street1, t.street2, t.citysuburb, t.statecode, t.postcode, t.countrycode, t.emailaddress, t.statustext, 
decode(t.statustext, 'Active', 1,'Inactive',2,'Expired',3) status,
m.personid, p.addressbookid
from temp_rpgsvscombine t, member m, person p
where t.memberstatus_svs = 1
and t.externalmemberid = m.externalmemberid
and m.personid = p.personid;

-- 944,186

create index indx_temp_tobeupdatemember on temp_tobeupdatemember(externalmemberid);


select * from temp_tobeupdatemember;

-- backup tables
create table temp_person as select * from person;

create table temp_address as select * from address;

create table temp_addressbook as select * from addressbook;

MERGE INTO person t1
USING
(
-- For more complicated queries you can use WITH clause here
SELECT * FROM temp_tobeupdatemember t where exists (select personid from person where personid = t.personid)
)t2
ON(t1.personid = t2.personid)
WHEN MATCHED THEN UPDATE SET
t1.familyname = t2.familyname,
t1.givenname = t2.givenname;

drop table temp_tobeupdatenonmember;

create table temp_tobeupdatenonmember as
select t.externalmemberid, t.sourceid, t.familyname, t.givenname, t.joineddate, t.street1, t.street2, t.citysuburb, t.statecode, t.postcode, t.countrycode, t.emailaddress, t.statustext, 
decode(t.statustext, 'Active', 1,'Inactive',2,'Expired',3) status 
from temp_rpgsvscombine t
where not exists (select * from member where externalmemberid = t.externalmemberid);

select * from temp_tobeupdatenonmember;

select * from cardregistration


-- 301,075

-- 944,358

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
and p.addressbookid = ab.addressbookid;


------------------------------------------------------------------------------------
---- 21/06/2017

drop table temp_rydgesmember_dup;

create table temp_rydgesmember_dup
(
  familyname varchar2(300 byte),
  givenname varchar2(300 byte),
  externalmemberid varchar2(60 byte),
  sourceid integer,
  membershiplevel integer,
  creationdate date,
  pointsbalance integer,
  enrolmentcode varchar2(100 byte),
  companyid varchar2(100 byte),
  emailaddress varchar2(300 byte),
  count integer
) nologging;

select * from temp_rydgesmember_dup

select t.familyname,t.givenname,t.externalmemberid,t.sourceid,t.membershiplevel,t.creationdate,
t.pointsbalance,t.enrolmentcode,t.companyid,t.emailaddress,
(select programstatus from member where externalmemberid = t.externalmemberid) programstatus1,
(select programstatus from cardregistration where externalmemberid = t.externalmemberid) programstatus2
from temp_rydgesmember_dup t