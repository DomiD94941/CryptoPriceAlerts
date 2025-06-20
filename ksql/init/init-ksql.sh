#!/bin/bash

echo "[init-ksql.sh] Waiting for ksqlDB to be ready..."
until curl -s http://ksqldb-server:8088/info | grep -q "KsqlServerInfo"; do
  echo "  ... still waiting for ksqlDB..."
  sleep 2
done

echo "[init-ksql.sh] Executing all SQL files in /ksql-init (sorted)..."

for file in $(ls /ksql-init/*.sql | sort); do
  echo ">>> Executing $file"
  ksql http://ksqldb-server:8088 < "$file"
  sleep 5
done

echo "[init-ksql.sh] All SQL files executed!"
