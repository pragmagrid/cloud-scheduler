insert into users (fname, lname, email, username, password, salt, timezone, lastlogin, status_id, date_created, language, organization)
        values ('$DBuser', '$DBuser', '$ADMIN_EMAL', 'admin', SHA(concat('$DBPASSWD', '$SALT')), '$SALT', '$TIMEZONE', '2010-03-26 00:00:00', 1, now(), 'en_us', 'PRAGMA Cloud');

insert into user_groups values (1,1);
insert into user_groups values (1,2);
insert into user_groups values (1,3);
insert into user_groups values (1,4);

