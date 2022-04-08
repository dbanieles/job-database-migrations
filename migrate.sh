#!/bin/bash
: ${DATABASE_USER:=postgres}
: ${DATABASE_IN_USE:=postgres}

cat <<CONF > /migrate/environments/development.properties
time_zone=GMT+0:00

driver=org.postgresql.Driver
url=jdbc:postgresql://$DATABASE_HOST:$DATABASE_PORT/$DATABASE_IN_USE
username=$DATABASE_USER
password=$DATABASE_PASSWORD

script_char_set=UTF-8
send_full_script=true
delimiter=;
full_line_delimiter=false
auto_commit=false
changelog=changelog

CONF

while ! nc -q 1 $DATABASE_HOST $DATABASE_PORT </dev/null;
do
  echo "Waiting for database"
  sleep 10;
done

/opt/mybatis-migrations-3.2.0/bin/migrate up "$@"
