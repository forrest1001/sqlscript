set define off;

CREATE OR REPLACE PROCEDURE FRIDAY(pFirstDate IN DATE, pSecondDate IN DATE) IS
WEB NUMBER;
KIOSK NUMBER;
FTP NUMBER;
temp NUMBER;
temp1 NUMBER;
temp2 NUMBER;
firstDate VarChar(20);
secondDate VarChar(20);
BEGIN
    firstDate := to_char(pFirstDate, 'dd/mm/yyyy');
    secondDate := to_char(pSecondDate, 'dd/mm/yyyy');
    dbms_output.put_line('OK HERE 1');
    execute immediate 'drop table temp_nghitemptable1';
    dbms_output.put_line('OK HERE 1');
    execute immediate 'create table temp_nghitemptable1 as 
    select i.terminaltransactionid, i.externalmemberid, i.productmgrid, m.membershiplevel, c.cardpkgclassid, i.value, i.cardprodclassid
    from instantrewsummarytransaction i, cardmember c, member m
    where i.status < 50 
       and i.cardprodclassid in (851,861)
       and i.transactiondate >= to_date(''' || firstDate || ',''dd/mm/yyyy'')
       and i.transactiondate < to_date(''' || secondDate || ',''dd/mm/yyyy'')
       and i.suppliertransactiontype <= 60000
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
       and i.transactiondate >= to_date(''' || firstDate || ',''dd/mm/yyyy'')
       and i.transactiondate < to_date(''' || secondDate || ',''dd/mm/yyyy'')
       and i.suppliertransactiontype <= 60000
       and i.issuanceflag = 1
       and c.externalmemberid = i.externalmemberid 
       and c.productmgrid = i.productmgrid 
       and c.status < 50 
       and c.status <> 9
       and c.externalmemberid = m.externalmemberid
       and c.productmgrid = m.productmgrid';

    select distinct externalmemberid, productmgrid
    into temp1, temp2  
    from temp_nghitemptable1;

    dbms_output.put_line('* Count of unique members who have a membership card and stayed (both eligible & non eligible nights) during the period 03-Sep-14 to 02-Sep-15 (previous 12 month [ F ])');
    
    dbms_output.put_line('    '  || temp1);
        
EXCEPTION 
  when no_data_found then dbms_output.put_line('No data found exception');
  when too_many_rows then dbms_output.put_line('Too many rows exception');     
END;
/

set serveroutput on size 30000;
execute FRIDAY(to_date('03/09/2014','dd/mm/yyyy'), to_date('03/09/2015','dd/mm/yyyy'));