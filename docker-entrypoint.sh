#!/bin/bash
# fail if we error out
set -e
# Wait for database to come up
until psql -h db -U "root" -c '\q' 2>/dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
# Ensure we have the basics...
mix local.hex --force
mix local.rebar --force
mix phx.server