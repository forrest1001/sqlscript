select * 
from rydgesaccom 
where externalmemberid = 'R2642927'

Reservation #: R2642927/46341957  Eligible Nights: 3

-- Points given twice
select * from instantrewsummarytransaction where sourcetransactionid = 2325899

select * from instantrewsummarytransaction where sourcetransactionid in (
select rydgesaccomid
from rydgesaccom 
where status = 36)

select * from loyaltypntssummarytransaction where externalmemberid = 'R2642927'

select * from loyaltypntssummarytransaction where sourcetransactionid in (
select rydgesaccomid
from rydgesaccom 
where status = 36)

select * from rydgesaccom where transactiongroupid = 1985834


select *
from rydgesaccom 
where status = 36


select comments, cardprodclassid, count(terminaltransactionid) from instantrewsummarytransaction i 
where i.status < 50
and i.cardprodclassid in (851,852)
and i.sourcetransactionid in (select rydgesaccomid from rydgesaccom)
and i.suppliertransactiontype = 50102
group by comments, cardprodclassid
having count(terminaltransactionid) > 1


select * from instantrewsummarytransaction where comments in 
('Reservation #: R1477302/32372131  Eligible Nights: 2',
'Reservation #: R1489245/31540369  Eligible Nights: 1',
'Reservation #: R1487530/31698487  Eligible Nights: 2',
'Reservation #: R1487530/31698487  Eligible Nights: 2',
'Reservation #: R1484670/31654130  Eligible Nights: 1',
'Reservation #: R1484670/31655300  Eligible Nights: 1',
'Reservation #: R2654884/46471739  Eligible Nights: 3',
'Reservation #: R1484670/31655300  Eligible Nights: 1',
'Reservation #: R1482455/31622166  Eligible Nights: 2',
'Reservation #: R1464716/32296778  Eligible Nights: 3',
'Reservation #: R1519972/32027486  Eligible Nights: 2',
'Reservation #: R1480216/31651663  Eligible Nights: 1',
'Reservation #: R1489245/31540369  Eligible Nights: 1',
'Reservation #: R1482767/31627095  Eligible Nights: 1',
'Reservation #: R2664343/46579115  Eligible Nights: 1',
'Reservation #: R1477302/32372131  Eligible Nights: 2',
'Reservation #: R1464716/32296778  Eligible Nights: 3',
'Reservation #: R1480216/31651663  Eligible Nights: 1',
'Reservation #: R1482455/31622166  Eligible Nights: 2',
'Reservation #: R1482767/31627095  Eligible Nights: 1',
'Reservation #: R2664343/46579115  Eligible Nights: 1',
'Reservation #: R1519972/32027486  Eligible Nights: 2',
'Reservation #: R1484670/31654130  Eligible Nights: 1',
'Reservation #: R2642927/46341957  Eligible Nights: 3',
'Reservation #: R2642927/46341957  Eligible Nights: 3',
'Reservation #: R2654884/46471739  Eligible Nights: 3')
order by comments, cardid