CREATE OR REPLACE Procedure DeleteVoucher(pVoucherId in Integer, pCaseNumber in VarChar)
Is
Begin

    update INSTANTREWSUMMARYTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update INSTANTREWTERMINALTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update COUPONSUMMARYTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update COUPONTERMINALTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update LOYALTYPNTSSUMMARYTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update LOYALTYPNTSTERMINALTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update PASSSUMMARYTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update PASSTERMINALTRANSACTION set status = 99, comments = comments || ' (deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    delete NONMEMBERPOINTS where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    delete NONMEMBERPRODUCTUSAGE where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    delete ADDRESSBOOK where addressbookid = 
        (select addressbookid from PERSON where personid = 
            (select personid from RETAILCUSTOMER where retailcustomerid in 
                (select retailcustomerid from CARDPURCHASEREPORTSUMMARY where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId))));
    delete ADDRESS where addressbookid = 
        (select addressbookid from PERSON where personid = 
            (select personid from RETAILCUSTOMER where retailcustomerid in 
                (select retailcustomerid from CARDPURCHASEREPORTSUMMARY where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId))));
    delete PERSON where personid =
        (select personid from RETAILCUSTOMER where retailcustomerid in
            (select retailcustomerid from CARDPURCHASEREPORTSUMMARY where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId)));
    delete RETAILCUSTOMER where retailcustomerid in 
        (select retailcustomerid from CARDPURCHASEREPORTSUMMARY where cardid in ( select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId));
    delete CARDPURCHASEREPORTSUMMARY where cardid in (select cardid from VOUCHERSALECODECARD where voucherid = pVoucherId);
    update VOUCHERSALECODE set status = 99 where voucherid = pVoucherId;
    update VOUCHERSALECODECARD set status = 99 where voucherid = pVoucherId; 
    update VOUCHER set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where voucherid = pVoucherId;

end;
/

CREATE OR REPLACE PROCEDURE DeleteCard(pCardId in Integer, pCaseNumber in VarChar)
is
begin
    update INSTANTREWSUMMARYTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update INSTANTREWTERMINALTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update COUPONSUMMARYTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update COUPONTERMINALTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update LOYALTYPNTSSUMMARYTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update LOYALTYPNTSTERMINALTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update PASSSUMMARYTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update PASSTERMINALTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    delete NONMEMBERPOINTS where cardid = pCardId;
    delete NONMEMBERPRODUCTUSAGE where cardid = pCardId;
    delete ADDRESSBOOK where addressbookid = 
        (select addressbookid from PERSON where personid = 
            (select personid from RETAILCUSTOMER where retailcustomerid = 
                (select retailcustomerid from cardpurchasereportsummary where cardid = pCardId)));
    delete ADDRESS where addressbookid = 
        (select addressbookid from PERSON where personid = 
            (select personid from RETAILCUSTOMER where retailcustomerid = 
                (select retailcustomerid from cardpurchasereportsummary where cardid = pCardId)));
    delete PERSON where personid =
        (select personid from RETAILCUSTOMER where retailcustomerid =
            (select retailcustomerid from cardpurchasereportsummary where cardid = pCardId));
    delete RETAILCUSTOMER where retailcustomerid = 
        (select retailcustomerid from cardpurchasereportsummary where cardid = pCardId);
    delete CARDPURCHASEREPORTSUMMARY where cardid = pCardId;
    update SALECODEDIRECTSALE set status = 99, saleinvoicestatus = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
    update SALETERMINALTRANSACTION set status = 99, comments = comments || ' (Deleted by Nghi, case ' || pCaseNumber || '), ' || to_char(sysdate,'dd/mm/yyyy hh:mi') where cardid = pCardId;
end;
/


execute DeleteCard(903600399930024565 ,'160883');
commit;

execute DeleteVoucher(192313,'161019');
commit;

select * from salecodedirectsale where cardid like '%%'

select * from vouchersalecodecard where cardid like '%%'