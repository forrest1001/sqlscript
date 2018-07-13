select cardid, s.*, sc.name from cardpurchasereportsummary cp, salecodeproduct s, salecode sc where 
cardid in 
(
903500000000001009,903500000000001006,903500000000001008,903500000000001028,903500000000001029,
903500000000001030,903500000000001011,903500000000001012,903500000000001014,903500000000001015,
903500000000001013,903500000000001031,903500000000001032,903500000000001033,903500000000001034,
903500000000001022,903600399760000521,903500000000001023,903500000000001024,903500000000001025,
903500000000001026,903500000000001027,903500000000001050,903500000000001051,903500000000001037,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000527,
903600399760000526,903500000000001038,903500000000001039,903500000000001040,903500000000001041,
903500000000001042,903600399760000520,903600392240720017,903600392210720025,903600392240720033,
903600399760000513,903600399760000514,903600399760000515,903500000000001046,903500000000001047,
903500000000001045,903500000000001048,903500000000001049,903500000000001059,903500000000001060,
903500000000001061,903500000000001062,903500000000001057,903500000000001058,903500000000001066,
903500000000001067,903500000000001068,903500000000001069,903500000000001070,903500000000001020,
903500000000001054,903500000000001055,903500000000001056,903500000000001063,903500000000001064,
903500000000001065,903600399760000516,903600399760000517,903500000000001071,903500000000001072,
903500000000001073)
and cp.salecode = s.salecode
and s.initialvalue > 0
and cp.salecode = sc.salecode;

select * from passsummarytransaction   
where cardid in 
(
903500000000001009,903500000000001006,903500000000001008,903500000000001028,903500000000001029,
903500000000001030,903500000000001011,903500000000001012,903500000000001014,903500000000001015,
903500000000001013,903500000000001031,903500000000001032,903500000000001033,903500000000001034,
903500000000001022,903600399760000521,903500000000001023,903500000000001024,903500000000001025,
903500000000001026,903500000000001027,903500000000001050,903500000000001051,903500000000001037,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000527,
903600399760000526,903500000000001038,903500000000001039,903500000000001040,903500000000001041,
903500000000001042,903600399760000520,903600392240720017,903600392210720025,903600392240720033,
903600399760000513,903600399760000514,903600399760000515,903500000000001046,903500000000001047,
903500000000001045,903500000000001048,903500000000001049,903500000000001059,903500000000001060,
903500000000001061,903500000000001062,903500000000001057,903500000000001058,903500000000001066,
903500000000001067,903500000000001068,903500000000001069,903500000000001070,903500000000001020,
903500000000001054,903500000000001055,903500000000001056,903500000000001063,903500000000001064,
903500000000001065,903600399760000516,903600399760000517,903500000000001071,903500000000001072,
903500000000001073)

select * from passsummarytransaction 
where cardid in 
(
903500000000001009,903500000000001006,903500000000001008,903500000000001028,903500000000001029,
903500000000001030,903500000000001011,903500000000001012,903500000000001014,903500000000001015,
903500000000001013,903500000000001031,903500000000001032,903500000000001033,903500000000001034,
903500000000001022,903600399760000521,903500000000001023,903500000000001024,903500000000001025,
903500000000001026,903500000000001027,903500000000001050,903500000000001051,903500000000001037,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000527,
903600399760000526,903500000000001038,903500000000001039,903500000000001040,903500000000001041,
903500000000001042,903600399760000520,903600392240720017,903600392210720025,903600392240720033,
903600399760000513,903600399760000514,903600399760000515,903500000000001046,903500000000001047,
903500000000001045,903500000000001048,903500000000001049,903500000000001059,903500000000001060,
903500000000001061,903500000000001062,903500000000001057,903500000000001058,903500000000001066,
903500000000001067,903500000000001068,903500000000001069,903500000000001070,903500000000001020,
903500000000001054,903500000000001055,903500000000001056,903500000000001063,903500000000001064,
903500000000001065,903600399760000516,903600399760000517,903500000000001071,903500000000001072,
903500000000001073) and partofcardsale = 1


-------------------------------------------------------------------------------------------------------
----- Only fix 46 card
----- 28 cards used
----- 18 cards not used
select distinct cardid from passsummarytransaction where cardid in 
(903500000000001006,903500000000001008,903500000000001009,903500000000001011,903500000000001012,
903500000000001013,903500000000001014,903500000000001015,903500000000001020,903500000000001022,
903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,
903500000000001028,903500000000001029,903500000000001030,903500000000001031,903500000000001032,
903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,
903500000000001040,903500000000001041,903500000000001042,903500000000001045,903500000000001046,
903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,
903600392210720025,903600392240720017,903600392240720033,903600399760000520,903600399760000521,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000526,
903600399760000527)
and partofcardsale = 0

46 cards
28 cards used

select * from passsummarytransaction 
where cardid in (903500000000001006,903500000000001008,903500000000001009,903500000000001011,903500000000001012,
903500000000001013,903500000000001014,903500000000001015,903500000000001020,903500000000001022,
903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,
903500000000001028,903500000000001029,903500000000001030,903500000000001031,903500000000001032,
903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,
903500000000001040,903500000000001041,903500000000001042,903500000000001045,903500000000001046,
903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,
903600392210720025,903600392240720017,903600392240720033,903600399760000520,903600399760000521,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000526,
903600399760000527) 
and cardid not in 
(903500000000001011,903500000000001012,903500000000001023,903500000000001024,903500000000001025,
903500000000001026,903500000000001027,903500000000001028,903500000000001029,903500000000001030,
903500000000001031,903500000000001032,903500000000001033,903500000000001034,903500000000001037,
903500000000001038,903500000000001039,903500000000001040,903500000000001041,903500000000001042,
903500000000001045,903500000000001046,903500000000001047,903500000000001048,903500000000001049,
903500000000001050,903500000000001051,903600399760000521)


----------------------------------
-- not used
select s.cardid, v.saledate, v.redemptionmerchantid, p.cardprodclassid, p.initialvalue, p.producttype, '' as salereferencecode
from vouchersalecodecard s , voucher v, salecodeproduct p  
where s.cardid in (903500000000001006,903500000000001008,903500000000001009,903500000000001013,903500000000001014,
903500000000001015,903500000000001020,903500000000001022,903600392210720025,903600392240720017,
903600392240720033,903600399760000520,903600399760000522,903600399760000523,903600399760000524,
903600399760000525,903600399760000526,903600399760000527)
and s.salecode = p.salecode
and s.voucherid = v.voucherid
and p.initialvalue > 0
order by p.producttype

delete nonmemberpoints 
where cardid in (903500000000001006,903500000000001008,903500000000001009,903500000000001013,903500000000001014,
903500000000001015,903500000000001020,903500000000001022,903600392210720025,903600392240720017,
903600392240720033,903600399760000520,903600399760000522,903600399760000523,903600399760000524,
903600399760000525,903600399760000526,903600399760000527)

----------------------------------
-- used 28
select cardid || ','
from passsummarytransaction 
where cardid in (903500000000001006,903500000000001008,903500000000001009,903500000000001011,903500000000001012,
903500000000001013,903500000000001014,903500000000001015,903500000000001020,903500000000001022,
903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,
903500000000001028,903500000000001029,903500000000001030,903500000000001031,903500000000001032,
903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,
903500000000001040,903500000000001041,903500000000001042,903500000000001045,903500000000001046,
903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,
903600392210720025,903600392240720017,903600392240720033,903600399760000520,903600399760000521,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000526,
903600399760000527) and partofcardsale = 1

-- 55 redemption transaction, 1669 & 1668

select * from cardpurchasereportsummary where cardid = 903500000000001025

select * from 

update nonmemberpoints 
set expirydate = expirydate - 365, hardexpirydate = hardexpirydate - 365
where cardid in (
903500000000001006,903500000000001008,903500000000001009,903500000000001011,903500000000001012,
903500000000001013,903500000000001014,903500000000001015,903500000000001020,903500000000001022,
903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,
903500000000001028,903500000000001029,903500000000001030,903500000000001031,903500000000001032,
903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,
903500000000001040,903500000000001041,903500000000001042,903500000000001045,903500000000001046,
903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,
903600392210720025,903600392240720017,903600392240720033,903600399760000520,903600399760000521,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000526,
903600399760000527)
and pointsissued = pointsredeemed


select * from nonmemberpoints 
where cardid in (
903500000000001006,903500000000001008,903500000000001009,903500000000001011,903500000000001012,903500000000001013,903500000000001014,903500000000001015,903500000000001020,903500000000001022,
903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,903500000000001028,903500000000001029,903500000000001030,903500000000001031,903500000000001032,
903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,903500000000001040,903500000000001041,903500000000001042,903500000000001045,903500000000001046,
903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,903600392210720025,903600392240720017,903600392240720033,903600399760000520,903600399760000521,
903600399760000522,903600399760000523,903600399760000524,903600399760000525,903600399760000526,903600399760000527)


select s.cardid, v.saledate, v.redemptionmerchantid, p.cardprodclassid, p.initialvalue, p.producttype, '' as salereferencecode
from vouchersalecodecard s , voucher v, salecodeproduct p  
where s.cardid in (
903500000000001011,903500000000001012,903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,903500000000001028,903500000000001029,903500000000001030,
903500000000001031,903500000000001032,903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,903500000000001040,903500000000001041,903500000000001042,
903500000000001045,903500000000001046,903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,903600399760000521)
and p.initialvalue > 0
and v.voucherid = s.voucherid
and s.salecode = p.salecode;

update passsummarytransaction
set status = 99, comments = comments || '. Nghi deleted to fix wrong product settings from Heather.' 
where cardid in 
(
903500000000001011,903500000000001012,903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,903500000000001028,903500000000001029,903500000000001030,
903500000000001031,903500000000001032,903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,903500000000001040,903500000000001041,903500000000001042,
903500000000001045,903500000000001046,903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,903600399760000521
)
and partofcardsale = 0;

select TERMINALTRANSACTIONID, CARDID, TRANSACTIONDATE, SAMID, SEQUENCENUMBER, 
TERMINALTRANSACTIONNUMBER, CARDTRANSACTIONNUMBER, REFERENCECODE, 
decode(cardprodclassid, 1668, 1670, 1669, 1671) AS CARDPRODCLASSID, 
OPERATORID, COMMENTS, LOADTYPE, STATUS, 3 as PRODUCTTYPE, CREATIONDATE, 
SUMMARYDATE, PRODUCTMGRID, DAYOFWEEK, HOUROFDAY, REPORTID, 
CHARGECATEGORYID, 
0 AS PROMOTIONID, RUNNINGTOTAL, 
TAXRATE, MEMBEROWNERID, MEMBERID, MANUALOPERATORPERSONID, MODIFIEDDATE, DELETEDDATE, MODIFIEDBYPERSONID, 
    DELETEDBYPERSONID, MODIFICATIONCOMMENTS, DELETIONCOMMENTS, TYPE, TRANSACTIONGROUPID, 
    EXTERNALMEMBERID, null as CLEARED, ACTIVITYCODEID, ACTIVITYCODE, SOURCETYPE, 
    TRANSACTIONGENERATORID, SOURCETRANSACTIONID, CARDLOADED, PARTOFCARDSALE, ISSUANCEFLAG, 
    CURRENCY, TOTALINVOICECOST, TOTALINVOICETAX, TOTALRETAILCOST, TOTALRETAILTAX, 
    UNITINVOICECOST, UNITINVOICETAX, UNITRETAILCOST, UNITRETAILTAX, REVERSEVALUE, 
    REVERSETRANSACTIONID, POINTSCHECK, VALUE, RATECODE, RATETYPE, 
    COMPANYEXTERNALMEMBERID, COMPANYMEMBERID, RATENAME, RATELABEL, SUPPLIERTRANSACTIONTYPE, 
    MERCHANTRATEID, MERCHANTSPECIALRATEID, MERCHANTOFFERID, SALEID, DEVICEID, 
    SOURCEIP, POINTSEXPIRYDATE
from passsummarytransaction 
where cardid in 
(
903500000000001011,903500000000001012,903500000000001023,903500000000001024,903500000000001025,903500000000001026,903500000000001027,903500000000001028,903500000000001029,903500000000001030,
903500000000001031,903500000000001032,903500000000001033,903500000000001034,903500000000001037,903500000000001038,903500000000001039,903500000000001040,903500000000001041,903500000000001042,
903500000000001045,903500000000001046,903500000000001047,903500000000001048,903500000000001049,903500000000001050,903500000000001051,903600399760000521
)
and partofcardsale = 0;

-- 74 transactions

instantrewsummarytransaction 

select * from cardprodclassview where cardprodclassid in (1668,1669,1671,1670)

1668 - 1670
1669 - 1671

1671
1670