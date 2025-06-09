#!/bin/sh

echo "⌛ Czekam na Kafka Connect..."
for i in $(seq 1 15); do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://connect:8083/connectors)
  if [ "$STATUS" = "200" ]; then
    echo "✅ Kafka Connect gotowy"
    break
  fi
  echo "⏳ ($i) Kafka Connect jeszcze nie gotowy"
  sleep 2
done

echo "🚀 Rejestruję konektor avg_price_sink.json:"
cat /connect-init/avg_price_sink.json

curl -s -i -X POST http://connect:8083/connectors \
  -H "Content-Type: application/json" \
  --data-binary @/connect-init/avg_price_sink.json
