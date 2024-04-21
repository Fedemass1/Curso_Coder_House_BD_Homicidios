-- Creo dos usuarios
use homicidios;
create user if not exists 'fede'@'localhost' identified by 'mypassword';
create user if not exists 'fedemass'@'localhost' identified by 'mypassword';

grant select on homicidios.* to 'fede'@'localhost';
grant select, insert, update on homicidios.* to 'fedemass'@'localhost';

show grants for 'fede'@'localhost';
show grants for 'fedemass'@'localhost';