SELECT user.first_name, user.last_name FROM 
user, 
	(SELECT distinct user.national_code 
	FROM user, user_account 
	WHERE user.national_code = user_account.national_code AND user_account.signature_acc = TRUE) 
AS t 
WHERE user.national_code = t.national_code;

-----------------------------------------------------------------

SELECT account_id 
FROM account, 
	(SELECT t.acc_id, COUNT(*) AS total_signature 
	FROM (
		SELECT account_id AS acc_id 
		FROM user_account 
		WHERE signature_acc = TRUE) 
	AS t GROUP BY t.acc_id) 
AS t 
WHERE account.account_id = t.acc_id AND account.min_signature <= t.total_signature;

-----------------------------------------------------------------

SELECT s.pay_id 
FROM 
	( SELECT COUNT(*) as total, t.payment_id as pay_id, t.min_signature as min_sig 
	FROM 
		(SELECT * FROM all_account_payment WHERE sig_removed = FALSE) 
	as t group by t.payment_id) 
AS s 
WHERE s.total >= s.min_sig

-----------------------------------------------------------------

SELECT * 
FROM transaction, 
	(SELECT payment_id AS pay_id 
	FROM payment 
	WHERE payment.mode = 0 AND is_removed = FALSE) 
AS t 
WHERE t.pay_id = transaction.payment_id AND transaction.dest_account_id = 1 AND transaction.is_removed = FALSE;

-----------------------------------------------------------------

SELECT * 
FROM payment_signature 
WHERE national_code = '1' AND is_removed = TRUE;

-----------------------------------------------------------------

SELECT account_id 
FROM user_account 
WHERE national_code = '1' AND account_id in 
	(SELECT account_id 
	FROM user_account 
	WHERE national_code = '13');
	
-----------------------------------------------------------------

SELECT payment_id 
FROM all_user_payment_acc 
WHERE national_code = '1' AND signature_acc = TRUE;

-----------------------------------------------------------------

SELECT * FROM transaction, 
	(SELECT distinct payment_id as pay_id from all_user_payment_acc WHERE creator_national_code = '1' 
	AND payment_id IN (SELECT distinct payment_id FROM all_user_payment_acc WHERE national_code = '1' AND signature_acc = FALSE)) 
as t WHERE transaction.is_removed = FALSE AND t.pay_id = transaction.payment_id;

-----------------------------------------------------------------

SELECT amount 
FROM bill 
WHERE type = TRUE AND amount > 100;