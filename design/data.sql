INSERT INTO account SET amount = 2500, type = 1, min_signature = 1;
INSERT INTO account SET amount = 3000, type = 1, min_signature = 1;
INSERT INTO account SET amount = 4000, type = 1, min_signature = 2;
INSERT INTO account SET amount = 4500, type = 1, min_signature = 3;
INSERT INTO account SET amount = 4500, type = 1, min_signature = 2;
INSERT INTO account SET amount = 2750, type = 1, min_signature = 4;

INSERT INTO user SET national_code = '1', first_name = 'user_1', last_name = 'user_1', code = '1', password = '1';
INSERT INTO user SET national_code = '2', first_name = 'user_2', last_name = 'user_2', code = '2', password = '2';
INSERT INTO user SET national_code = '3', first_name = 'user_3', last_name = 'user_3', code = '3', password = '3';
INSERT INTO user SET national_code = '4', first_name = 'user_4', last_name = 'user_4', code = '4', password = '4';
INSERT INTO user SET national_code = '5', first_name = 'user_5', last_name = 'user_5', code = '5', password = '5';
INSERT INTO user SET national_code = '6', first_name = 'user_6', last_name = 'user_6', code = '6', password = '6';
INSERT INTO user SET national_code = '7', first_name = 'user_7', last_name = 'user_7', code = '7', password = '7';
INSERT INTO user SET national_code = '8', first_name = 'user_8', last_name = 'user_8', code = '8', password = '8';
INSERT INTO user SET national_code = '9', first_name = 'user_9', last_name = 'user_9', code = '9', password = '9';
INSERT INTO user SET national_code = '10', first_name = 'user_10', last_name = 'user_10', code = '10', password = '10';
INSERT INTO user SET national_code = '11', first_name = 'user_11', last_name = 'user_11', code = '11', password = '11';
INSERT INTO user SET national_code = '12', first_name = 'user_12', last_name = 'user_12', code = '12', password = '12';
INSERT INTO user SET national_code = '13', first_name = 'user_13', last_name = 'user_13', code = '13', password = '13';
INSERT INTO user SET national_code = '14', first_name = 'user_14', last_name = 'user_14', code = '14', password = '14';
INSERT INTO user SET national_code = '15', first_name = 'user_15', last_name = 'user_15', code = '15', password = '15';
INSERT INTO user SET national_code = '16', first_name = 'user_16', last_name = 'user_16', code = '16', password = '16';


INSERT INTO user_phone_number SET national_code = '1', phone_number = '09121111111';
INSERT INTO user_phone_number SET national_code = '1', phone_number = '09121111112';
INSERT INTO user_phone_number SET national_code = '2', phone_number = '09122111111';
INSERT INTO user_phone_number SET national_code = '2', phone_number = '09122111112';
INSERT INTO user_phone_number SET national_code = '3', phone_number = '09123111111';
INSERT INTO user_phone_number SET national_code = '3', phone_number = '09123111112';
INSERT INTO user_phone_number SET national_code = '4', phone_number = '09124111111';
INSERT INTO user_phone_number SET national_code = '4', phone_number = '09124111112';
INSERT INTO user_phone_number SET national_code = '5', phone_number = '09125111111';
INSERT INTO user_phone_number SET national_code = '5', phone_number = '09125111112';
INSERT INTO user_phone_number SET national_code = '6', phone_number = '09126111111';
INSERT INTO user_phone_number SET national_code = '6', phone_number = '09126111112';
INSERT INTO user_phone_number SET national_code = '7', phone_number = '09127111111';
INSERT INTO user_phone_number SET national_code = '7', phone_number = '09127111112';
INSERT INTO user_phone_number SET national_code = '8', phone_number = '09128111111';
INSERT INTO user_phone_number SET national_code = '8', phone_number = '09128111112';
INSERT INTO user_phone_number SET national_code = '9', phone_number = '09129111111';
INSERT INTO user_phone_number SET national_code = '9', phone_number = '09129111112';
INSERT INTO user_phone_number SET national_code = '10', phone_number = '09120101111';
INSERT INTO user_phone_number SET national_code = '10', phone_number = '09120101112';
INSERT INTO user_phone_number SET national_code = '11', phone_number = '09120111111';
INSERT INTO user_phone_number SET national_code = '11', phone_number = '09120111112';
INSERT INTO user_phone_number SET national_code = '12', phone_number = '09120121111';
INSERT INTO user_phone_number SET national_code = '12', phone_number = '09120121112';
INSERT INTO user_phone_number SET national_code = '13', phone_number = '09120131111';
INSERT INTO user_phone_number SET national_code = '13', phone_number = '09120131112';
INSERT INTO user_phone_number SET national_code = '14', phone_number = '09120141111';
INSERT INTO user_phone_number SET national_code = '14', phone_number = '09120141112';
INSERT INTO user_phone_number SET national_code = '15', phone_number = '09120151111';
INSERT INTO user_phone_number SET national_code = '15', phone_number = '09120151112';
INSERT INTO user_phone_number SET national_code = '16', phone_number = '09120161111';
INSERT INTO user_phone_number SET national_code = '16', phone_number = '09120161112';




INSERT INTO user_account SET national_code = '1', account_id = 1, pay_acc = true, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '2', account_id = 1, pay_acc = false, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '3', account_id = 1, pay_acc = false, signature_acc = false, bill_acc = true;

INSERT INTO user_account SET national_code = '4', account_id = 2, pay_acc = false, signature_acc = true, bill_acc = false;
INSERT INTO user_account SET national_code = '5', account_id = 2, pay_acc = true, signature_acc = true, bill_acc = false;
INSERT INTO user_account SET national_code = '6', account_id = 2, pay_acc = true, signature_acc = false, bill_acc = true;
INSERT INTO user_account SET national_code = '7', account_id = 2, pay_acc = false, signature_acc = true, bill_acc = true;

INSERT INTO user_account SET national_code = '8', account_id = 3, pay_acc = false, signature_acc = false, bill_acc = false;
INSERT INTO user_account SET national_code = '9', account_id = 3, pay_acc = true, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '10', account_id = 3, pay_acc = true, signature_acc = true, bill_acc = false;
INSERT INTO user_account SET national_code = '11', account_id = 3, pay_acc = false, signature_acc = false, bill_acc = false;
INSERT INTO user_account SET national_code = '12', account_id = 3, pay_acc = false, signature_acc = true, bill_acc = false;

INSERT INTO user_account SET national_code = '13', account_id = 4, pay_acc = false, signature_acc = true, bill_acc = false;
INSERT INTO user_account SET national_code = '14', account_id = 4, pay_acc = false, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '15', account_id = 4, pay_acc = true, signature_acc = true, bill_acc = false;
INSERT INTO user_account SET national_code = '16', account_id = 4, pay_acc = true, signature_acc = false, bill_acc = true;
INSERT INTO user_account SET national_code = '1', account_id = 4, pay_acc = true, signature_acc = true, bill_acc = false;

INSERT INTO user_account SET national_code = '3', account_id = 5, pay_acc = false, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '7', account_id = 5, pay_acc = false, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '10', account_id = 5, pay_acc = true, signature_acc = false, bill_acc = true;
INSERT INTO user_account SET national_code = '13', account_id = 5, pay_acc = true, signature_acc = false, bill_acc = true;

INSERT INTO user_account SET national_code = '4', account_id = 6, pay_acc = true, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '1', account_id = 6, pay_acc = true, signature_acc = false, bill_acc = true;
INSERT INTO user_account SET national_code = '12', account_id = 6, pay_acc = true, signature_acc = false, bill_acc = true;
INSERT INTO user_account SET national_code = '3', account_id = 6, pay_acc = true, signature_acc = true, bill_acc = true;
INSERT INTO user_account SET national_code = '5', account_id = 6, pay_acc = true, signature_acc = false, bill_acc = true;


INSERT INTO payment SET creator_national_code = '1', source_account_id = 1, mode = 0;
INSERT INTO payment SET creator_national_code = '14', source_account_id = 4, mode = 1;
INSERT INTO payment SET creator_national_code = '6', source_account_id = 2, mode = 0;
INSERT INTO payment SET creator_national_code = '11', source_account_id = 3, mode = 0;

INSERT INTO transaction SET payment_id = 1, dest_account_id = 2, amount = 150;
INSERT INTO transaction SET payment_id = 1, dest_account_id = 3, amount = 350;
INSERT INTO transaction SET payment_id = 2, dest_account_id = 1, amount = 1000;
INSERT INTO transaction SET payment_id = 2, dest_account_id = 2, amount = 25;
INSERT INTO transaction SET payment_id = 2, dest_account_id = 5, amount = 675;
INSERT INTO transaction SET payment_id = 3, dest_account_id = 6, amount = 600;
INSERT INTO transaction SET payment_id = 4, dest_account_id = 1, amount = 895;

INSERT INTO payment_signature SET payment_id = 1, national_code = '2', is_removed = TRUE;
INSERT INTO payment_signature SET payment_id = 1, national_code = '1', is_removed = FALSE;
INSERT INTO payment_signature SET payment_id = 2, national_code = '13', is_removed = TRUE;
INSERT INTO payment_signature SET payment_id = 2, national_code = '14', is_removed = FALSE;
INSERT INTO payment_signature SET payment_id = 2, national_code = '1', is_removed = FALSE;
INSERT INTO payment_signature SET payment_id = 3, national_code = '4', is_removed = TRUE;
INSERT INTO payment_signature SET payment_id = 3, national_code = '5', is_removed = FALSE;
INSERT INTO payment_signature SET payment_id = 4, national_code = '9', is_removed = FALSE;

INSERT INTO bill SET account_id = 4, amount = 1700, type = FALSE, time = now();
INSERT INTO bill SET account_id = 1, amount = 1000, type = TRUE, time = now();
INSERT INTO bill SET account_id = 5, amount = 675, type = TRUE, time = now();
INSERT INTO bill SET account_id = 2, amount = 25, type = TRUE, time = now();



