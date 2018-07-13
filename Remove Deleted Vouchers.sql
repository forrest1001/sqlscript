create table a_voucher as
select *
from voucher where status > 55;

create table a_vouchersalecode as
select *
from vouchersalecode where status > 55;

create table a_vouchersalecodecard as
select *
from vouchersalecodecard where status > 55;

delete voucher where status > 55;
delete vouchersalecode where status > 55;
delete vouchersalecodecard where status > 55;