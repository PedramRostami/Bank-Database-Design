CREATE VIEW all_user_payment_acc AS 
SELECT payment_id, creator_national_code, account_id, national_code, pay_acc, signature_acc, bill_acc, mode 
FROM payment, user_account 
WHERE payment.source_account_id = user_account.account_id and payment.is_removed = 0;


CREATE VIEW all_account_payment AS
SELECT account.account_id, account.min_signature, payment.payment_id, payment_signature.national_code, payment.is_removed AS pay_removed, payment_signature.is_removed as sig_removed
FROM account, payment, payment_signature 
WHERE account.account_id = payment.source_account_id AND payment.payment_id = payment_signature.payment_id;