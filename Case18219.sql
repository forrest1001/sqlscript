select * from salecodeproduct
where salecode in 
(13664,13755,13672,13763,13698,
13789,18499,18507,13680,13771,
18515,18523,13706,13797);

select salecode, count(*)
from salecodecardsummary 
where salecode in 
(13664,13755,13672,13763,13698,
13789,18499,18507,13680,13771,
18515,18523,13706,13797)
group by salecode;

with datatable as
(
select salecode, 
(select count (terminaltransactionid) from instantrewsummarytransaction where saleid = s.saleid and status < 50 and partofcardsale = 0 and issuanceflag = 0) instantrew,
(select count (terminaltransactionid) from passsummarytransaction where saleid = s.saleid and status < 50 and partofcardsale = 0 and issuanceflag = 0) pass
from SALECODECARDSUMMARY s
where salecode in 
(13664,13755,13672,13763,13698,
13789,18499,18507,13680,13771,
18515,18523,13706,13797)
)
select salecode, sum(instantrew) instant, sum(pass) pass
from datatable
group by salecode;

select distinct SupplierTransactionType

select count(*)
from passsummarytransaction
where status < 50
and partofcardsale = 0
and issuanceflag = 0
and saleid in (select distinct saleid from salecodecardsummary where salecode = 13698);

select count(*)
from instantrewsummarytransaction
where status < 50
and partofcardsale = 0
and issuanceflag = 0
and saleid in (select distinct saleid from salecodecardsummary where salecode = 18515);