#!/bin/bash

# source .back.production.env  #Use this when you want to apply 

# Wait until Postgres is ready
while ! pg_isready -h $PGHOST -p $PGPORT -U $PGUSER
do
    echo "user: $PGUSER password: $PGPASSWORD db: $PGDATABASE port: $PGPORT host: $PGHOST"
    echo "$(date) - waiting for database to start"
    sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
    echo "Database $PGDATABASE does not exist. Creating..."
    mix ecto.setup
    echo "Database $PGDATABASE created."
else
    echo "Database $PGDATABASE exists. Starting reset..."
    mix ecto.reset
    mix ecto.setup
    echo "Database $PGDATABASE reset."
fi

exec mix phx.server