#!/bin/bash

rundb {
  docker run -d -p 5433:5432 --name cbdb postgres:9.4.1
}

runmigration {
  docker run -it -e DB_ENV_POSTGRES_USER=postgres -e DB_ENV_POSTGRES_PASSWORD=  --link cbdb:db  -v /Users/akanto/prj/docker-mybatis-migrations/scripts:/migrate/scripts sequenceiq/mybatis-migrations 
}
