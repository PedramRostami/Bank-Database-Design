CREATE FUNCTION has_signature_acc ( n_c VARCHAR(10), a_i INT)
    RETURNS BOOLEAN DETERMINISTIC
    BEGIN
    IF (SELECT COUNT(*) FROM user_account WHERE account_id = a_i AND national_code = n_c AND signature_acc = TRUE) > 0 THEN
    RETURN TRUE;
    ELSE
    RETURN FALSE;
    END IF;
    END; //
	

CREATE FUNCTION has_pay_acc ( n_c VARCHAR(10), a_i INT)
    RETURNS BOOLEAN DETERMINISTIC
    BEGIN
    IF (SELECT COUNT(*) FROM user_account WHERE account_id = a_i AND national_code = n_c AND pay_acc = TRUE) > 0 THEN
    RETURN TRUE;
    ELSE
    RETURN FALSE;
    END IF;
    END; //


CREATE FUNCTION has_bill_acc ( n_c VARCHAR(10), a_i INT)
    RETURNS BOOLEAN DETERMINISTIC
    BEGIN
    IF (SELECT COUNT(*) FROM user_account WHERE account_id = a_i AND national_code = n_c AND bill_acc = TRUE) > 0 THEN
    RETURN TRUE;
    ELSE
    RETURN FALSE;
    END IF;
    END; //

	