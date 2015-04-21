#!/bin/bash
: ${DB_ENV_POSTGRES_USER?"DB_ENV_POSTGRES_USER not set"}
: ${DB_ENV_POSTGRES_PASSWORD?"DB_ENV_POSTGRES_PASSWORD not set"}

cat <<CONF > //migrate/environments/development.properties
time_zone=GMT+0:00

driver=org.postgresql.Driver
url=jdbc:postgresql://$DB_PORT_5432_TCP_ADDR:$DB_PORT_5432_TCP_PORT/$POSTGRES_USER
username=$DB_ENV_POSTGRES_USER
password=$DB_ENV_POSTGRES_PASSWORD

script_char_set=UTF-8
send_full_script=true
delimiter=;
full_line_delimiter=false
auto_commit=false
changelog=changelog

CONF

/opt/mybatis-migrations-3.2.0/bin/migrate "$@"
