DELIMITER //

--1--
CREATE PROCEDURE add_user (n_c VARCHAR(10), f_name VARCHAR(32), l_name VARCHAR(32), c VARCHAR(16), pass VARCHAR(64))
BEGIN
DECLARE salt_pass VARCHAR(64);
SET salt_pass = pass;
SET salt_pass = CONCAT(salt_pass, n_c);
INSERT INTO user SET national_code = n_c, first_name = f_name, last_name = l_name, code = c, password = PASSWORD(salt_pass);
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--2--
CREATE PROCEDURE add_account (a FLOAT, t INT, m_s INT)
BEGIN
INSERT INTO account SET amount = a, type = t, min_signature = m_s;
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--3--
CREATE PROCEDURE add_user_account (n_c VARCHAR(10), a_i INT, p_a BOOLEAN, s_a BOOLEAN, b_a BOOLEAN)
BEGIN
INSERT INTO user_account SET national_code = n_c, account_id = a_i, pay_acc = p_c, signature_acc = s_a, bill_acc = b_c;
END; // 

CREATE PROCEDURE grant_acc (n_c VARCHAR(10), a_i INT, type VARCHAR(10))
BEGIN
IF type = 'pay' THEN
UPDATE user_account SET pay_acc = TRUE WHERE national_code = n_c AND account_id = a_i;
END IF;
IF type = 'signature' THEN
UPDATE user_account SET signature_acc = TRUE WHERE national_code = n_c AND account_id = a_i;
END IF;
IF type = 'bill' THEN
UPDATE user_account SET bill_acc = TRUE WHERE national_code = n_c AND account_id = a_i;
END IF;
END; //

CREATE PROCEDURE revoke_acc (n_c VARCHAR(10), a_i INT, type VARCHAR(10))
BEGIN
IF type = 'pay' THEN
UPDATE user_account SET pay_acc = FALSE WHERE national_code = n_c AND account_id = a_i;
END IF;
IF type = 'signature' THEN
UPDATE user_account SET signature_acc = FALSE WHERE national_code = n_c AND account_id = a_i;
END IF;
IF type = 'bill' THEN
UPDATE user_account SET bill_acc = FALSE WHERE national_code = n_c AND account_id = a_i;
END IF;
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--4--
CREATE PROCEDURE add_payment (c_n_c VARCHAR(10), s_a_i INT, c_d VARCHAR(1024))
BEGIN
IF (SELECT COUNT(*) FROM user_account WHERE user_account.national_code = c_n_c AND user_account.account_id = s_a_i) > 0 THEN
INSERT INTO payment SET creator_national_code = c_n_c, source_account_id = s_a_i, creator_description = c_d;
ELSE
SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 30001, MESSAGE_TEXT = 'YOU ARE NOT ALLOW TO DO THIS!';
END IF;
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--5--
CREATE PROCEDURE edit_payment (n_c VARCHAR(10), p_i INT, new_a_i INT, new_c_d VARCHAR(1024))
BEGIN
IF (SELECT COUNT(*) FROM payment WHERE payment.payment_id = p_i AND payment.creator_national_code = n_c) > 0 THEN
IF (SELECT COUNT(*) FROM payment_signature WHERE payment_id = p_i AND is_removed = FALSE) = 0 THEN
UPDATE payment SET source_account_id = new_a_i, creator_description = new_c_d WHERE payment_id = p_i;
END IF;
END IF;
END; //

CREATE PROCEDURE remove_payment (n_c VARCHAR(10), p_i INT)
BEGIN
IF (SELECT COUNT(*) FROM payment WHERE payment.payment_id = p_i AND payment.creator_national_code = n_c) > 0 THEN
UPDATE payment SET is_removed = TRUE WHERE payment_id = p_i;
END IF;
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--6--
CREATE PROCEDURE add_signature ( p_i INT, n_c VARCHAR(10))
BEGIN
IF (SELECT COUNT(*) FROM all_user_payment_acc WHERE payment_id = p_i AND national_code = n_c AND signature_acc = TRUE) > 0 THEN
IF (SELECT SUM(mode) FROM payment WHERE payment_id = p_i) != 0 THEN
INSERT INTO payment_signature SET payment_id = p_i, national_code = n_c;
END IF;
END IF;
END; //

CREATE PROCEDURE delete_signature ( p_i INT, n_c VARCHAR(10))
BEGIN
IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_id AND is_removed = FALSE) > 0 THEN
IF (SELECT SUM(mode) FROM payment WHERE payment_id = p_id) != 0 THEN
UPDATE payment_signature SET is_removed = TRUE WHERE payment_id = p_i AND national_code = n_c;
END IF;
END IF;
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--7--
CREATE PROCEDURE add_transaction ( n_c VARCHAR(10), p_i INT, d_a_i INT, a INT)
BEGIN
IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_i AND creator_national_code = n_c) > 0 THEN
IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_id AND mode = 0 AND is_removed = FALSE) > 0 THEN
IF (SELECT COUNT(*) FROM payment_signature WHERE payment_id = p_i AND is_removed = FALSE) = 0 THEN
INSERT INTO transaction SET payment_id = p_i, dest_account_id = d_a_i, amount = a;
END IF;
END IF;
END IF;
END; //

CREATE PROCEDURE delete_transaction ( n_c VARCHAR(10), p_i INT, d_a_i INT)
BEGIN
IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_i AND creator_national_code = n_c) > 0 THEN
IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_id AND mode = 0 AND is_removed = FALSE) > 0 THEN
IF (SELECT COUNT(*) FROM payment_signature WHERE payment_id = p_i AND is_removed = FALSE) = 0 THEN
UPDATE transaction SET  is_removed = TRUE WHERE payment_id = p_i AND dest_account_id = d_a_i;
END IF;
END IF;
END IF;
END; //

CREATE PROCEDURE update_transaction ( n_c VARCHAR(10), p_i INT, d_a_i INT, n_a INT)
BEGIN
IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_i AND creator_national_code = n_c) > 0 THEN
IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_id AND mode = 0 AND is_removed = FALSE) > 0 THEN
IF (SELECT COUNT(*) FROM payment_signature WHERE payment_id = p_i AND is_removed = FALSE) = 0 THEN
UPDATE transaction SET  amount = n_a WHERE payment_id = p_i AND dest_account_id = d_a_i;
END IF;
END IF;
END IF;
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--8--
CREATE PROCEDURE pay ( p_i INT, n_c VARCHAR(10), m INT)
BEGIN
	DECLARE has_acc BOOLEAN;
	SELECT source_account_id INTO @source_account_id from payment WHERE payment_id = p_i;
	SELECT has_pay_acc(n_c, @source_account_id) INTO has_acc;
	IF has_acc = TRUE THEN
		IF (SELECT COUNT(*) FROM payment_signature WHERE payment_id = p_i AND is_removed = FALSE) > (SELECT SUM(min_signature) FROM account, payment WHERE payment.payment_id = p_i AND account.account_id = payment.source_account_id) THEN
			IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_id AND is_removed = FALSE) > 0 THEN
				UPDATE payment SET mode = m WHERE payment_id = p_i;
			END IF;
		END IF;
	END IF;
END; //

----------------------------------------------------------------------------------------------------------------------------------------------------
--9--
CREATE PROCEDURE pay_all ( p_i INT, n_c VARCHAR(10), m INT)
BEGIN
declare n INT default 0;
declare counter INT default 0;
declare amo INT default 0;
declare acc_id INT default 0;
IF (SELECT COUNT(*) FROM all_user_payment_acc WHERE payment_id = p_i AND national_code = n_c AND pay_acc = TRUE) > 0 THEN
	IF (SELECT COUNT(*) FROM payment_signature WHERE payment_id = p_id AND is_removed = FALSE) > (SELECT SUM(min_signature) 
	FROM account, payment WHERE payment.payment_id = p_id AND account.account_id = payment.source_account_id) THEN
		IF (SELECT COUNT(*) FROM payment WHERE payment_id = p_id AND is_removed = FALSE) > 0 THEN
			UPDATE payment SET mode = m WHERE payment_id = p_i;
			if m = 1 THEN				
				SELECT COUNT(*) INTO n FROM transaction WHERE payment_id = p_i AND is_removed = FALSE;
				WHILE counter < n DO
					SELECT account_id INTO acc_id FROM transaction WHERE payment_id = p_i LIMIT counter, 1;
					SELECT amount INTO amo FROM transaction WHERE payment_id = p_i LIMIT counter, 1;
					INSERT INTO bill SET type = TRUE, time = now(), amount = amo, account_id = acc_id;
					SET counter = counter + 1;
				END WHILE;
				SELECT source_account_id INTO @source_account_id FROM payment WHERE payment_id = p_i;
				SELECT amount INTO @amount FROM payment WHERE payment_id = p_i;
				INSERT INTO bill SET type = FALSE, amount = @amount, account_id = @source_account_id, time = now();
			END IF;
		END IF;
	END IF;
END IF;
END; //

DELIMITER ;
