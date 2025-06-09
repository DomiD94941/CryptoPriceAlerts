#!/bin/bash

echo "[init-ksql.sh] Waiting for ksqlDB to be ready..."
while ! curl -s http://ksqldb-server:8088/info > /dev/null; do
  echo "  ... still waiting for ksqlDB..."
  sleep 2
done

echo "[init-ksql.sh] Executing all .sql files in order..."
for f in /ksql-init/*.sql; do
  echo "Executing $f ..."
  ksql http://ksqldb-server:8088 < "$f"
done
