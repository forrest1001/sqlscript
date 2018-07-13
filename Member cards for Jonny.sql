select m.externalmemberid, m.productmgrid, m.joineddate, 
cm.cardid, cm.status, cm.creationdate, cm.modifieddate, cm.packcode, cm.cardpkgclassid,
(select sum((pointsissued-pointsreverseissued) - (pointsredeemed - pointsreverseredeemed) - (pointsexpired - pointsreverseexpired)) from memberpoints
where cardprodclassid in (852,862) and externalmemberid = m.externalmemberid and productmgrid = m.productmgrid) balance
from member m, cardmember cm
where m.productmgrid in (22181,22191)
and m.externalmemberid = cm.externalmemberid
and m.productmgrid = cm.productmgrid
and m.externalmemberid like 'R%'
order by m.externalmemberid