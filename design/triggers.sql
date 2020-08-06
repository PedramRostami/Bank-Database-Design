DELIMITER //

CREATE TRIGGER user_created_at_update
    BEFORE INSERT ON user
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER user_updated_at_update
    BEFORE UPDATE ON user
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //	
	
CREATE TRIGGER account_created_at_update
    BEFORE INSERT ON account
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER account_updated_at_update
    BEFORE UPDATE ON account
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //

CREATE TRIGGER user_account_created_at_update
    BEFORE INSERT ON user_account
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER user_account_updated_at_update
    BEFORE UPDATE ON user_account
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //



CREATE TRIGGER bill_created_at_update
    BEFORE INSERT ON bill
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER bill_updated_at_update
    BEFORE UPDATE ON bill
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //



CREATE TRIGGER payment_created_at_update
    BEFORE INSERT ON payment
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER payment_updated_at_update
    BEFORE UPDATE ON payment
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //



CREATE TRIGGER transaction_created_at_update
    BEFORE INSERT ON transaction
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER transaction_updated_at_update
    BEFORE UPDATE ON transaction
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //
	
	
	
CREATE TRIGGER user_phone_number_created_at_update
    BEFORE INSERT ON user_phone_number
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER user_phone_number_updated_at_update
    BEFORE UPDATE ON user_phone_number
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //



CREATE TRIGGER user_address_created_at_update
    BEFORE INSERT ON user_address
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER user_address_updated_at_update
    BEFORE UPDATE ON user_address
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //


CREATE TRIGGER payment_signature_created_at_update
    BEFORE INSERT ON payment_signature
    FOR EACH ROW
    BEGIN
    SET NEW.created_at = now();
    END; //
	
CREATE TRIGGER payment_signature_updated_at_update
    BEFORE UPDATE ON payment_signature
    FOR EACH ROW
    BEGIN
    SET NEW.updated_at = now();
    END; //







	
CREATE TRIGGER log_acc
    AFTER UPDATE ON user_account
    FOR EACH ROW
    BEGIN
    DECLARE msg VARCHAR(512);
	SET msg = 'national_code = ';
	SET msg = CONCAT(msg, NEW.national_code);
    IF NEW.pay_acc=1 AND OLD.pay_acc=0 THEN
    SET msg = CONCAT(msg, '-- payment access granted --');
    END IF;
    IF NEW.pay_acc=0 AND OLD.pay_acc=1 THEN
    SET msg = CONCAT(msg, '-- payment access revoked --');
    END IF;
    IF NEW.bill_acc=1 AND OLD.bill_acc=0 THEN
    SET msg = CONCAT(msg, '-- bill access granted --');
    END IF;
    IF NEW.bill_acc=0 AND OLD.bill_acc=1 THEN
    SET msg = CONCAT(msg, '-- bill access revoked --');
    END IF;
    IF NEW.signature_acc=1 AND OLD.signature_acc=0 THEN
    SET msg = CONCAT(msg, '-- signature access granted --');
    END IF;
    IF NEW.signature_acc=0 AND OLD.signature_acc=1 THEN
    SET msg = CONCAT(msg, '-- signature access revoked --');
    END IF;
    
    INSERT INTO log SET time = now(), message = msg;
    END; //

	
--CREATE TRIGGER transaction_adder
--    BEFORE INSERT ON transaction
--    FOR EACH ROW
--    BEGIN
--    IF (SELECT payment.mode FROM payment, transaction WHERE payment.payment_id = NEW.payment_id) != 0 THEN
--    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 30001, MESSAGE_TEXT = 'YOU ARE NOT ALLOW TO DO THIS!';
--    ELSEIF (SELECT COUNT(*) FROM payment_signature WHERE NEW.payment_id = payment_signature.payment_id AND payment_signature.is_removed = FALSE) > 0 THEN
--    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 30001, MESSAGE_TEXT = 'YOU ARE NOT ALLOW TO DO THIS!';
--    ELSE
--    UPDATE payment SET payment.amount = payment.amount + NEW.amount WHERE payment.payment_id = NEW.payment_id;
--    END IF;
--    END; //
	
	
CREATE TRIGGER add_transaction
    AFTER INSERT ON transaction
    FOR EACH ROW
    BEGIN
    UPDATE payment SET payment.amount = payment.amount + NEW.amount WHERE payment.payment_id = NEW.payment_id;
    END; //
	
 CREATE TRIGGER update_transaction
    AFTER UPDATE ON transaction
    FOR EACH ROW
    BEGIN
    IF NEW.is_removed = TRUE AND OLD.is_removed = FALSE THEN
    UPDATE payment SET payment.amount = payment.amount - NEW.amount WHERE payment.payment_id = NEW.payment_id;
    END IF;
	IF NEW.is_removed = FALSE AND NEW.amount != OLD.amount THEN
    UPDATE payment SET payment.amount = payment.amount - OLD.amount + NEW.amount WHERE payment.payment_id = NEW.payment_id;
    END IF;
    END; //
	
CREATE TRIGGER update_account
    AFTER INSERT ON bill
    FOR EACH ROW
    BEGIN
    IF NEW.type = TRUE then
    UPDATE account SET account.amount = account.amount + NEW.amount WHERE account.account_id = NEW.account_id;
    END IF;
    IF NEW.type = FALSE then
    UPDATE account SET account.amount = account.amount - NEW.amount WHERE account.account_id = NEW.account_id;
    END IF;
    END; //
	
CREATE TRIGGER add_signature
    AFTER INSERT ON payment_signature
    FOR EACH ROW
    BEGIN
    DECLARE msg VARCHAR(512);
    SET msg = 'payment_id = ';
    SET msg = CONCAT(msg, NEW.payment_id);
    SET msg = CONCAT(msg, ' -- national_code = ');
    SET msg = CONCAT(msg, NEW.national_code);
	SET msg = CONCAT(msg, ' -- NEW SIGNATURE CREATED');
    IF NEW.is_removed = FALSE THEN
    INSERT INTO account_history SET message = msg, time = now();
    END IF;
    END; //

CREATE TRIGGER remove_signature
    AFTER UPDATE ON payment_signature
    FOR EACH ROW
    BEGIN
    DECLARE msg VARCHAR(512);
    SET msg = 'payment_id = ';
    SET msg = CONCAT(msg, NEW.payment_id);
    SET msg = CONCAT(msg, ' -- national_code = ');
    SET msg = CONCAT(msg, NEW.national_code);
	SET msg = CONCAT(msg, ' -- SIGNATURE REMOVED');
    IF NEW.is_removed = TRUE AND OLD.is_removed = FALSE THEN
    INSERT INTO account_history SET message = msg, time = now();
    END IF;
    END; //
	
CREATE TRIGGER add_account
    AFTER INSERT ON account
    FOR EACH ROW
    BEGIN
    DECLARE msg VARCHAR(512);
    SET msg = 'account_id = ';
	SET msg = CONCAT(msg, NEW.account_id);
    SET msg = CONCAT(msg, ' -- ACCOUNT ADDED');
    IF NEW.is_removed = FALSE THEN
    INSERT INTO account_history SET message = msg, time = now();
    END IF;
    END; //

CREATE TRIGGER pay
	AFTER UPDATE ON payment
	FOR EACH ROW
	BEGIN
	DECLARE msg VARCHAR(512);
	SET msg = 'payment_id = ';
	SET msg = CONCAT(msg, NEW.payment_id); 
	IF NEW.mode = 1 AND OLD.mode = 0 AND NEW.is_removed = FALSE AND OLD.is_removed = FALSE THEN
	INSERT INTO account_history SET message = msg, time = now();
	END IF;
	END; //
	
DELIMITER ;


