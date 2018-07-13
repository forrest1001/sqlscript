set define off; 

CREATE OR REPLACE PROCEDURE FIRSTONE(pStartDate IN DATE, pEndDate IN DATE) IS
WEB NUMBER;
KIOSK NUMBER;
FTP NUMBER;
BEGIN
    
    SELECT count(*)
    INTO WEB 
    FROM CARDREGISTRATION
    WHERE PRODUCTMGRID IN (22181,22191)
    AND CREATEDDATE >= pStartDate
    AND CREATEDDATE < pEndDate;
    
    dbms_output.put_line('    a. From web ' || to_char(WEB, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    SELECT count(*)
    INTO KIOSK 
    FROM CARDFULFILMENTREQUEST C
    WHERE PICKUPTYPE = 10
    AND COMMENTS LIKE '%FROM KIOSK%'
    AND PRODUCTMGRID IN (22181,22191)
    AND CREATIONDATE >= pStartDate
    AND CREATIONDATE < pEndDate;
    dbms_output.put_line('    b. From KIOSK ' || to_char(KIOSK, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    SELECT count(*)
    INTO FTP
    FROM CARDFULFILMENTREQUEST
    WHERE COMMENTS LIKE '%FTP%'
    AND CREATIONDATE >= pStartDate
    AND CREATIONDATE < pEndDate;
    dbms_output.put_line('    c. From FTP ' || to_char(FTP, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
 
EXCEPTION 
  when no_data_found then dbms_output.put_line('No data found exception');
  when too_many_rows then dbms_output.put_line('Too many rows exception');     
END;
/

CREATE OR REPLACE PROCEDURE FIRSTNEW(pToday IN DATE) IS
    StartOfToday Date;
    EndOfYesterday Date;
    Last12Month Date;
    Last24Month Date;
    TempNumber Number;
BEGIN
    StartOfToday := trunc(pToday);
    EndOfYesterday := to_date(to_char((pToday-1), 'DD-MM-YYYY') || ' 23:59:59', 'DD-MM-YYYY HH24:MI:SS');
    Last12Month := trunc(add_months(EndOfYesterday, -12));
    Last24Month := trunc(add_months(EndOfYesterday, -24));
    
    select count(*) into TempNumber 
    From 
    (
    select distinct externalmemberid, productmgrid from
    (
        select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
        from instantrewsummarytransaction i, cardmember c, member m
            where i.status < 50 
            and i.cardprodclassid in (851,861)
            and i.transactiondate >= Last24Month
            and i.transactiondate < StartOfToday
            and i.suppliertransactiontype < 60000
            and i.issuanceflag = 1
            and c.externalmemberid = i.externalmemberid 
            and c.productmgrid = i.productmgrid 
            and c.status < 50 
            and c.status <> 9
            and c.externalmemberid = m.externalmemberid
            and c.productmgrid = m.productmgrid 
        union 
            select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
            from loyaltypntssummarytransaction i, cardmember c, member m 
            where i.status < 50 
            and i.cardprodclassid in (895,900)
            and i.transactiondate >= Last24Month
            and i.transactiondate < StartOfToday
            and i.suppliertransactiontype < 60000
            and i.issuanceflag = 1
            and c.externalmemberid = i.externalmemberid 
            and c.productmgrid = i.productmgrid 
            and c.status < 50 
            and c.status <> 9
            and c.externalmemberid = m.externalmemberid
            and c.productmgrid = m.productmgrid
        )
    );
    dbms_output.put_line('Count of unique members who have a membership card and have stayed (both eligible & non-eligible nights):');
    dbms_output.put_line('    1. During the period ' || to_char(Last24Month,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."')) ;
    
    select count(*) into TempNumber 
    From 
    (
    select distinct externalmemberid, productmgrid from
    (
        select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
        from instantrewsummarytransaction i, cardmember c, member m
            where i.status < 50 
            and i.cardprodclassid in (851,861)
            and i.transactiondate >= Last12Month
            and i.transactiondate < StartOfToday
            and i.suppliertransactiontype < 60000
            and i.issuanceflag = 1
            and c.externalmemberid = i.externalmemberid 
            and c.productmgrid = i.productmgrid 
            and c.status < 50 
            and c.status <> 9
            and c.externalmemberid = m.externalmemberid
            and c.productmgrid = m.productmgrid 
        union 
            select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.loyaltyactualvalue value, i.cardprodclassid
            from loyaltypntssummarytransaction i, cardmember c, member m 
            where i.status < 50 
            and i.cardprodclassid in (895,900)
            and i.transactiondate >= Last12Month
            and i.transactiondate < StartOfToday
            and i.suppliertransactiontype < 60000
            and i.issuanceflag = 1
            and c.externalmemberid = i.externalmemberid 
            and c.productmgrid = i.productmgrid 
            and c.status < 50 
            and c.status <> 9
            and c.externalmemberid = m.externalmemberid
            and c.productmgrid = m.productmgrid
        )
    );
    dbms_output.put_line('    2. During the period ' || to_char(Last12Month,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
EXCEPTION 
  when no_data_found then dbms_output.put_line('No data found exception');
  when too_many_rows then dbms_output.put_line('Too many rows exception');     
END;
/

CREATE OR REPLACE PROCEDURE SECONDNEW(pToday IN DATE) IS
    StartOfToday Date;
    EndOfYesterday Date;
    Last12Month Date;
    Last24Month Date;
    TempNumber Number;
BEGIN
    StartOfToday := trunc(pToday);
    EndOfYesterday := to_date(to_char((pToday-1), 'DD-MM-YYYY') || ' 23:59:59', 'DD-MM-YYYY HH24:MI:SS');
    Last12Month := trunc(add_months(EndOfYesterday, -12));
    Last24Month := trunc(add_months(EndOfYesterday, -24));
    
    dbms_output.put_line('Count of unique members who have redeemed points for a reward shop benefit (e.g. members who have redeemed points for a reward shop sale code (as listed) or Free Night product):');
    dbms_output.put_line('    1. During the period ' || to_char(Last24Month,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ':');
    
    select count(distinct externalmemberid)
    into TempNumber
    from instantrewsummarytransaction i 
    where i.status < 50 
      and i.cardprodclassid in (853,863)
      and i.suppliertransactiontype < 60000
      and i.issuanceflag = 1
      and i.transactiondate >= Last24Month
      and i.transactiondate < StartOfToday;
    dbms_output.put_line('        a. PGR – Free Night (Products 853 & 863) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40147,40188)
      and creditnoteflag = 0
      and saledate >= Last24Month
      and saledate < StartOfToday;
    dbms_output.put_line('        b. PGR - Breakfast Voucher Reward (Sale Codes 40147 & 40188) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40139,40170)
      and creditnoteflag = 0
      and saledate >= Last24Month
      and saledate < StartOfToday;
    dbms_output.put_line('        c. PGR - Drink Voucher Reward (Sale Codes 40139 & 40170) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));  
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40162,40493)
      and creditnoteflag = 0
      and saledate >= Last24Month
      and saledate < StartOfToday;
    dbms_output.put_line('        d. PGR - Meal Voucher Reward (Sale Codes 40162 & 40493) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40154,40196)
      and creditnoteflag = 0
      and saledate >= Last24Month
      and saledate < StartOfToday;
    dbms_output.put_line('        e. PGR - Wine Voucher Reward (Sale Codes 40154 & 40196) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40345,40535)
      and creditnoteflag = 0
      and saledate >= Last24Month
      and saledate < StartOfToday;
    dbms_output.put_line('        f. Rydges - Giftcard $50 (Sale Codes 40345 & 40535) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    ----------------------------------------------------------------------------
    
    dbms_output.put_line(' ');
    dbms_output.put_line('    2. During the period ' || to_char(Last12Month,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ':');
    
    select count(distinct externalmemberid)
    into TempNumber
    from instantrewsummarytransaction i 
    where i.status < 50 
      and i.cardprodclassid in (853,863)
      and i.suppliertransactiontype < 60000
      and i.issuanceflag = 1
      and i.transactiondate >= Last12Month
      and i.transactiondate < StartOfToday;
    dbms_output.put_line('        a. PGR – Free Night (Products 853 & 863) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40147,40188)
      and creditnoteflag = 0
      and saledate >= Last12Month
      and saledate < StartOfToday;
    dbms_output.put_line('        b. PGR - Breakfast Voucher Reward (Sale Codes 40147 & 40188) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40139,40170)
      and creditnoteflag = 0
      and saledate >= Last12Month
      and saledate < StartOfToday;
    dbms_output.put_line('        c. PGR - Drink Voucher Reward (Sale Codes 40139 & 40170) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));  
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40162,40493)
      and creditnoteflag = 0
      and saledate >= Last12Month
      and saledate < StartOfToday;
    dbms_output.put_line('        d. PGR - Meal Voucher Reward (Sale Codes 40162 & 40493) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40154,40196)
      and creditnoteflag = 0
      and saledate >= Last12Month
      and saledate < StartOfToday;
    dbms_output.put_line('        e. PGR - Wine Voucher Reward (Sale Codes 40154 & 40196) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    select count(distinct substr(vouchercode, 0, INSTR(vouchercode, '_') - 1))
    into TempNumber
    from salecodecardsummary 
    where salecode in (40345,40535)
      and creditnoteflag = 0
      and saledate >= Last12Month
      and saledate < StartOfToday;
    dbms_output.put_line('        f. Rydges - Giftcard $50 (Sale Codes 40345 & 40535) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
EXCEPTION 
  when no_data_found then dbms_output.put_line('No data found exception');
  when too_many_rows then dbms_output.put_line('Too many rows exception');     
END;
/


CREATE OR REPLACE PROCEDURE THIRDNEW(pToday IN DATE) IS
    StartOfToday Date;
    TempNumber Number;
BEGIN
    StartOfToday := trunc(pToday);
   
    select count(distinct externalmemberid)
    into TempNumber
    from cardmember where cardid like '6299%' and creationdate < StartOfToday;
    dbms_output.put_line(' ');
    dbms_output.put_line('Total Number of Members with a Digital Card ' || TempNumber);
    
    with memberwithdigitalcard
    as
    (
    select distinct externalmemberid from cardmember where cardid like '6299%' and creationdate < StartOfToday group by externalmemberid
    ),
    membernondigitalcard as
    (
    select externalmemberid, (select count(cardid) from cardmember where externalmemberid = m.externalmemberid and cardid not like '6299%') nondigitalcards from memberwithdigitalcard m
    )
    select count(*)
    into TempNumber
    from membernondigitalcard where nondigitalcards = 0;
    dbms_output.put_line('    Newly Joined Members ' || TempNumber);
    
    with memberwithdigitalcard
    as
    (
    select distinct externalmemberid from cardmember where cardid like '6299%' and creationdate < StartOfToday group by externalmemberid
    ),
    membernondigitalcard as
    (
    select externalmemberid, (select count(cardid) from cardmember where externalmemberid = m.externalmemberid and cardid not like '6299%') nondigitalcards from memberwithdigitalcard m
    )
    select count(*)
    into TempNumber
    from membernondigitalcard where nondigitalcards <> 0;
    dbms_output.put_line('    Existing Members ' || TempNumber);
EXCEPTION 
  when no_data_found then dbms_output.put_line('No data found exception');
  when too_many_rows then dbms_output.put_line('Too many rows exception');     
END;
/

CREATE OR REPLACE PROCEDURE FINALONE(pToday IN DATE) IS
    StartOfToday Date;
    EndOfYesterday Date;
    StartOfMonth Date;
    StartOfWeek Date;
    StartOfFinYear Date;
    Last12Month Date;
    Last18Month Date;
    StartOfProgram Date;
    
    TempNumber Number;
BEGIN
    StartOfToday := trunc(pToday);
    EndOfYesterday := to_date(to_char((pToday-1), 'DD-MM-YYYY') || ' 23:59:59', 'DD-MM-YYYY HH24:MI:SS');
    StartOfWeek := trunc(StartOfToday - 7);
    StartOfMonth := trunc(EndOfYesterday) - (to_number(to_char(EndOfYesterday,'DD')) - 1);
    StartOfFinYear := add_months(trunc(add_months(pToday,-6),'yyyy'),6);
    Last12Month := trunc(add_months(EndOfYesterday, -12));
    Last18Month := trunc(add_months(EndOfYesterday, -18));
    StartOfProgram := to_date('01/07/2007','dd/mm/yyyy');

    dbms_output.put_line('Fulfilment/Enrolments Numbers - ' || to_char(pToday,'dd-MON-yyyy'));
    dbms_output.put_line('Total Program Enrolments (including non-active members)');
    dbms_output.put_line(' ');
    dbms_output.put_line('1. Financial YTD (' || to_char(StartOfFinYear,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive)');
    FIRSTONE(StartOfFinYear, StartOfToday);
    
    dbms_output.put_line('2. Month to Date (' || to_char(StartOfMonth,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive)');
    FIRSTONE(StartOfMonth, StartOfToday);
    
    dbms_output.put_line('3. Week to date (' || to_char(StartOfWeek,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive)');
    FIRSTONE(StartOfWeek, StartOfToday);

    dbms_output.put_line('4. Last 12 Months (' || to_char(Last12Month,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive)');
    FIRSTONE(Last12Month, StartOfToday);

    dbms_output.put_line('5. Last 18 Months (' || to_char(Last18Month,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive)');
    FIRSTONE(Last18Month, StartOfToday);

    dbms_output.put_line('6. Program to Date (' || to_char(StartOfProgram,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive)');
    dbms_output.put_line('    a. From old 246,738');
    FIRSTONE(StartOfProgram, StartOfToday);

    dbms_output.put_line(' ');
    dbms_output.put_line('Total Card Fulfilments (kiosk and first stays combined)');
    SELECT COUNT(*)
    INTO TempNumber
    FROM CARDFULFILMENTREQUEST C
    WHERE C.FULFILLEDDATE >= StartOfFinYear 
        AND C.FULFILLEDDATE < StartOfToday
        AND C.PACKCODE IN (60,61)
        AND (C.COMMENTS LIKE '%BOOKING%' OR C.COMMENTS LIKE '%FROM KIOSK%');
    dbms_output.put_line('    1. Financial YTD ' || to_char(StartOfFinYear,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    SELECT COUNT(*)
    INTO TempNumber
    FROM CARDFULFILMENTREQUEST C
    WHERE C.FULFILLEDDATE >= StartOfMonth 
        AND C.FULFILLEDDATE < StartOfToday
        AND C.PACKCODE IN (60,61)
        AND (C.COMMENTS LIKE '%BOOKING%' OR C.COMMENTS LIKE '%FROM KIOSK%');
    dbms_output.put_line('    2. Month to Date ' || to_char(StartOfMonth,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    SELECT COUNT(*)
    INTO TempNumber
    FROM CARDFULFILMENTREQUEST C
    WHERE C.FULFILLEDDATE >= StartOfWeek 
        AND C.FULFILLEDDATE < StartOfToday
        AND C.PACKCODE IN (60,61)
        AND (C.COMMENTS LIKE '%BOOKING%' OR C.COMMENTS LIKE '%FROM KIOSK%');
    dbms_output.put_line('    3. Week to Date ' || to_char(StartOfWeek,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    dbms_output.put_line(' ');    
    dbms_output.put_line('Total Gold Upgrades (Pack Codes 92 & 93)');
    SELECT COUNT(*)
    INTO TempNumber
    FROM CARDFULFILMENTREQUEST C
    WHERE C.FULFILLEDDATE >= StartOfFinYear
        AND C.FULFILLEDDATE < StartOfToday 
        AND C.PACKCODE IN (92,93)
        AND C.STATUS < 50; -- There are status 52 request, duplicate gold upgrade request
    dbms_output.put_line('    1. Financial YTD ' || to_char(StartOfFinYear,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));    
    SELECT COUNT(*)
    INTO TempNumber
    FROM CARDFULFILMENTREQUEST C
    WHERE C.FULFILLEDDATE >= StartOfMonth
        AND C.FULFILLEDDATE < StartOfToday 
        AND C.PACKCODE IN (92,93)
        AND C.STATUS < 50; -- There are status 52 request, duplicate gold upgrade request
    dbms_output.put_line('    2. Month to Date ' || to_char(StartOfMonth,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));    

    dbms_output.put_line(' ');    
    dbms_output.put_line('Total Platinum Upgrades (Pack Codes 72, 73, 102 & 103)');
    SELECT COUNT(*)
    INTO TempNumber
    FROM CARDFULFILMENTREQUEST C
    WHERE C.FULFILLEDDATE >= StartOfFinYear 
        AND C.FULFILLEDDATE < StartOfToday 
        AND C.PACKCODE IN (72,73,102,103);
    dbms_output.put_line('    1. Financial YTD ' || to_char(StartOfFinYear,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    SELECT COUNT(*)
    INTO TempNumber
    FROM CARDFULFILMENTREQUEST C
    WHERE C.FULFILLEDDATE >= StartOfMonth 
        AND C.FULFILLEDDATE < StartOfToday 
        AND C.PACKCODE IN (72,73,102,103);
    dbms_output.put_line('    2. Month to Date ' || to_char(StartOfMonth,'dd/mm/yy hh24:mi') || ' to ' || to_char(EndOfYesterday,'dd/mm/yy hh24:mi') || ' inclusive) ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    dbms_output.put_line(' ');
    dbms_output.put_line('Total member opted in');
    SELECT COUNT(*)
    INTO TempNumber
    FROM MEMBER
    WHERE PRODUCTMGRID IN (22181,22191)
        AND AFFILIATION = 1;
    dbms_output.put_line('    ' || to_char(TempNumber, '99G999G999G999', 'NLS_NUMERIC_CHARACTERS=",."'));
    
    dbms_output.put_line(' ');
    FIRSTNEW(pToday);
    dbms_output.put_line(' ');
    SECONDNEW(pToday);
    THIRDNEW(pToday);
END;
/


set serveroutput on size 30000;
execute FINALONE(to_date('12/07/2018','dd/mm/yyyy'));
drop procedure firstone;
drop procedure finalone;
drop procedure firstnew;
drop procedure secondnew;