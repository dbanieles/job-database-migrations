#!/bin/bash
: ${DB_ENV_POSTGRES_USER:=postgres}
: ${DB_ENV_POSTGRES_SCHEMA:=postgres}

cat <<CONF > /migrate/environments/development.properties
time_zone=GMT+0:00

driver=org.postgresql.Driver
url=jdbc:postgresql://$DB_PORT_5432_TCP_ADDR:$DB_PORT_5432_TCP_PORT/$DB_ENV_POSTGRES_SCHEMA
username=$DB_ENV_POSTGRES_USER
password=$DB_ENV_POSTGRES_PASSWORD

script_char_set=UTF-8
send_full_script=true
delimiter=;
full_line_delimiter=false
auto_commit=false
changelog=changelog

CONF

while ! nc -q 1 $DB_PORT_5432_TCP_ADDR $DB_PORT_5432_TCP_PORT </dev/null;
do
  echo "Waiting for database"
  sleep 10;
done

/opt/mybatis-migrations-3.2.0/bin/migrate "$@"
