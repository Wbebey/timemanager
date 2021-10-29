#!/bin/bash

command -v pg_isready

# BACKEND_VARS="$(pwd)/.env"

if [ -z ".env" ]; then
    exit 1
fi

# if [ -f "${BACKEND_VARS}" ]; then
#     echo "${BACKEND_VARS} exist"
# else
#     echo "Environment variable Missing on $(pwd)"
#     exit 1
# fi

echo "${PGUSER} ${PGHOST}:${PGPORT} ---- VERYFYING"
while ! pg_isready -q -h $PGHOST -p $PGPORT --username=$PGUSER
do
    echo "$(date) - waiting database to start"
    sleep 2
done

# Create and migrate database

if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
    echo "Database $PGDATABASE does not exist. Creating..."
    # createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
    mix ecto.create
    mix ecto.migrate
    mix run priv/repo/seeds.exs
    echo "Database $PGDATABASE created."
else
    source .env
    if [[ $RESETDB == 1 ]]; then
    echo "Database $PGDATABASE is being reseted becauge you have specified RESETDB !! /!\ "
    mix ecto.reset
    echo "Database $PGDATABASE reseted !"
    export RESETDB=0
    else
    mix ecto.migrate
    fi
fi
echo "Backend Running on port ${PORT}"
exec mix phx.server