#!/bin/bash

echo "[init-ksql.sh] Czekam aż ksqlDB będzie gotowe..."
while ! curl -s http://ksqldb-server:8088/info > /dev/null; do
  echo "  ... nadal czekam na ksqlDB..."
  sleep 2
done

echo "[init-ksql.sh] Wykonuję wszystkie .sql po kolei..."
for f in /ksql-init/*.sql; do
  echo "➡️  Uruchamiam $f ..."
  ksql http://ksqldb-server:8088 < "$f"
done
