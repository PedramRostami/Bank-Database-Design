create table user(
    national_code    varchar(10) ,
    first_name       varchar(32) not null,
    last_name        varchar(32) not null,
    code             varchar(16) not null unique,
    password         varchar(64) not null,
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default false,
    primary key(national_code));
	

create table account(
    account_id       int not null AUTO_INCREMENT,
    amount           float not null default 0.0,
    type             int not null,
    min_signature    int not null,
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default 0,
    CONSTRAINT type_lower_bound CHECK (type>0),
    CONSTRAINT type_upper_bound CHECK (type<4),
    primary key(account_id));
	
create table user_account(
    national_code            varchar(10),
    account_id               int,
    pay_acc                  boolean not null default 0,
    signature_acc            boolean not null default 0,
    bill_acc                 boolean not null default 0,
    account_name             varchar(32),
    account_color            varchar(16),
    created_at               timestamp default '0000-00-00 00:00:00',
    updated_at               timestamp default '0000-00-00 00:00:00',
    is_removed               boolean not null default 0,
    CONSTRAINT `fk_user_account_account` FOREIGN KEY (account_id) REFERENCES account(account_id),
    CONSTRAINT `fk_user_account_user` FOREIGN KEY (national_code) REFERENCES user(national_code),
    primary key(national_code, account_id));
	
create table bill(
    bill_id          int not null AUTO_INCREMENT,
    account_id       int not null,
    amount           int not null,
    description      varchar(1024),
    time             timestamp,
	type			 boolean not null,
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default 0,
    CONSTRAINT `fk_bill_account` FOREIGN KEY (account_id) REFERENCES account(account_id),
    primary key(bill_id));
	
create table payment(
    payment_id       int not null AUTO_INCREMENT,
    creator_national_code    varchar(10) not null,
    source_account_id        int not null,
    amount           int not null default 0,
    creator_decription       varchar(1024),
    mode             int not null default 0,
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default 0,
    CONSTRAINT `fk_payment_user` FOREIGN KEY (creator_national_code) REFERENCES user(national_code),
    CONSTRAINT `fk_payment_account` FOREIGN KEY (source_account_id) REFERENCES account(account_id),
    CONSTRAINT `mode_lower_bound` CHECK (mode>-2),
    CONSTRAINT `mode_upper_bound` CHECK (mode<2),
    primary key(payment_id));
	
create table transaction(
    payment_id       int not null,
    dest_account_id  int not null,
    amount           float not null,
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default 0,
    CONSTRAINT `fk_transaction_payment` FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
    CONSTRAINT `fk_transaction_account` FOREIGN KEY (dest_account_id) REFERENCES account(account_id),
    primary key(payment_id, dest_account_id));
	
	
create table user_phone_number(
    national_code    varchar(10),
    phone_number     char(11),
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default 0,
    CONSTRAINT `fk_user_phone_number_user` FOREIGN KEY (national_code) REFERENCES user(national_code),
    primary key(national_code, phone_number));
	
create table user_address(
    national_code    varchar(10),
    address          varchar(128),
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default 0,
    CONSTRAINT `fk_user_address_user` FOREIGN KEY (national_code) REFERENCES user(national_code),
    primary key(national_code, address));
	
create table payment_signature(
    payment_id       int,
    national_code    varchar(10),
    created_at       timestamp default '0000-00-00 00:00:00',
    updated_at       timestamp default '0000-00-00 00:00:00',
    is_removed       boolean not null default 0,
    CONSTRAINT `fk_payment_signature_payment` FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
    CONSTRAINT `fk_payment_signature_user` FOREIGN KEY (national_code) REFERENCES user(national_code),
    primary key(payment_id, national_code));
	
CREATE TABLE log(
    id       int not null AUTO_INCREMENT,
    time     TIMESTAMP,
    message  varchar(512),
    primary key(id));
	
CREATE TABLE account_history(
    history_id       INT NOT NULL AUTO_INCREMENT,
    time             TIMESTAMP,
    message              VARCHAR(512),
    PRIMARY KEY (history_id));
	
	
	