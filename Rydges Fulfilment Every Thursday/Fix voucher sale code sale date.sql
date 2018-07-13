drop table temp_nghitemptable15; 

create table temp_nghitemptable15 as
select vsc.vouchersalecodeid, vsc.saledate saledateno, v.saledate saledateyes, v.vouchercode, v.voucherid, v.entryid
from vouchersalecode vsc, voucher v
where v.voucherid = vsc.voucherid
and trim(vsc.saledate) != trim(v.saledate)
order by v.saledate desc

select * from temp_nghitemptable15


update vouchersalecode vsc
set saledate = (select saledateyes from temp_nghitemptable15 where vouchersalecodeid = vsc.vouchersalecodeid)
where vsc.vouchersalecodeid in (select vouchersalecodeid from temp_nghitemptable15)