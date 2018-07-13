drop table temp_nghitemptable1;

create table temp_nghitemptable1 as
select v.vouchercode, v.voucherid, vs.saleexpirydate saleexpirydate1, vscc.cardid, vscc.saleexpirydate saleexpirydate2, sed.firstusedays, vs.salecode, retrievesalecodename(vs.salecode) salecodename,
(select firstusedays from salecodeexpirydefinition where salecode = vs.salecode and status = 0) actualdays,
(select salecodeexpirydefinitionid from salecodeexpirydefinition where salecode = vs.salecode and status = 0) actualid
from voucher v, vouchersalecode vs, vouchersalecodecard vscc, salecodeexpirydefinition sed where 
v.vouchercode in 
('10548581',
'KLK0000247819',
'KLK4876778617',
'KLK1896663207',
'KLK0559866953',
'KLK1128591877',
'KLK3250066483',
'IVCHK66',
'KLK5882465521',
'KLK9383630988',
'KLK7374916569',
'KLK5842531235',
'KLK3271586228',
'KLK7718244037',
'KLK0464983728',
'KLK3656123432',
'KLK8937605418',
'KLK9777641716',
'KLK5936711303',
'KLK7871857284',
'KLK7586122296',
'KLK8749136365',
'KLK1427486232',
'KLK0992395872',
'10571809',
'KLK0734022067',
'KLK8383235559',
'KLK8272925855',
'KLK3795419469',
'KLK2536849989',
'KLK5456736324',
'KLK1639985811',
'KLK5834923374',
'KLK8225206345',
'KLK8031459481',
'KLK2701609374',
'cl190618',
'KLK7916098320',
'KLK0299551540',
'KLK5690361699')
and v.voucherid = vs.voucherid
and vs.vouchersalecodeid = vscc.vouchersalecodeid
and vscc.salecodeexpirydefinitionid = sed.salecodeexpirydefinitionid

drop table temp_nghitemptable2;
create table temp_nghitemptable2 as 
select t.*, c.firstdateuse, c.firstuseexpirydate, c.firstusenoofdaysexpiry, c.salecodeexpirydefinitionid,
trunc(c.firstdateuse + t.actualdays) newfirstuseexpirydate, t.actualdays newfirstusenoofdaysexpiry
from temp_nghitemptable1 t, cardpurchasereportsummary c
where t.cardid = c.cardid;

select * from temp_nghitemptable2

update cardpurchasereportsummary c
set salecodeexpirydefinitionid = (select actualid from temp_nghitemptable2 where cardid = c.cardid),
firstuseexpirydate = (select newfirstuseexpirydate from temp_nghitemptable2 where cardid = c.cardid),
firstusenoofdaysexpiry = (select newfirstusenoofdaysexpiry from temp_nghitemptable2 where cardid = c.cardid),
comments = 'Nghi updated first use expiry date, case 16762'
where cardid in (select cardid from temp_nghitemptable2);

update vouchersalecodecard v
set salecodeexpirydefinitionid = (select actualid from temp_nghitemptable2 where cardid = v.cardid)
where v.cardid in (select cardid from temp_nghitemptable2);  

update vouchersalecode v
set salecodeexpirydefinitionid = (select distinct salecodeexpirydefinitionid from vouchersalecodecard where vouchersalecodeid = v.vouchersalecodeid)
where v.vouchersalecodeid in (select distinct vouchersalecodeid from vouchersalecodecard where cardid in (select cardid from temp_nghitemptable2));

-- for voucher that's not redeemed yet
select * from vouchersalecodecard
where voucherid in (select distinct voucherid from temp_nghitemptable1 where cardid = 0)

update vouchersalecodecard v
set salecodeexpirydefinitionid = (select distinct actualid from temp_nghitemptable1 where voucherid = v.voucherid and salecode = v.salecode)
where v.voucherid in (select distinct voucherid from temp_nghitemptable1 where cardid = 0);  

update vouchersalecode v
set salecodeexpirydefinitionid = (select distinct salecodeexpirydefinitionid from vouchersalecodecard where vouchersalecodeid = v.vouchersalecodeid)
where v.voucherid in (select distinct voucherid from temp_nghitemptable1 where cardid = 0);

-- testing
select c.cardid, c.salecode, retrievesalecodename(c.salecode) salecodename, c.firstdateuse, c.firstuseexpirydate, c.firstusenoofdaysexpiry, s.*
from cardpurchasereportsummary c, salecodeexpirydefinition s
where c.salecode = s.salecode
and s.status = 0
and c.cardid in (select cardid from temp_nghitemptable2)

select vs.voucherid, vs.salecode, retrievesalecodename(vs.salecode) salecodename, vsc.salecodeexpirydefinitionid,
(select firstusedays from salecodeexpirydefinition where salecode = vs.salecode and status = 0) actualdays,
(select salecodeexpirydefinitionid from salecodeexpirydefinition where salecode = vs.salecode and status = 0) actualid
from vouchersalecode vs, vouchersalecodecard vsc
where vs.voucherid in (select distinct voucherid from temp_nghitemptable1 where cardid = 0)
and vs.vouchersalecodeid = vsc.vouchersalecodeid
