# 🚀 Real-Time Crypto Price Analytics & Alert System

This project is a real-time cryptocurrency price tracking, analytics, and alerting system powered by **Apache Kafka**. It collects live market data from crypto exchanges (e.g., Binance), processes it in real-time, and triggers alerts based on user-defined conditions.

---

## 📊 Features

- ✅ Real-time price streaming using Kafka
- 📈 Moving average and price delta analytics
- 🔔 Alert system for price thresholds and volatility
- 💾 Persistent storage in PostgreSQL
- 📺 Live dashboard (React.js or Grafana)
- 🧠 Pluggable stream processing via ksqlDB or Kafka Streams

---

## 🧱 Architecture

```plaintext
[Crypto API] → [Kafka Producer] → [Kafka Topic: crypto_prices]
                             ↓
          [Analytics] [Alerting] [Storage] [ksqlDB]
                             ↓
                  [Kafka Topic: alerts]
                             ↓
                 [API → Dashboard → User]
```

## 🧪 Prerequisites

Docker & Docker Compose

Python 3.9+

Node.js (for dashboard frontend)

API key (optional for Binance)

Git

## 🚀 Getting Started

# 1. Clone the repo
git clone https://github.com/youruser/crypto-alert-system.git
cd crypto-alert-system

# 2. Start Kafka + DB + ksqlDB
docker-compose -f docker/kafka-docker-compose.yml up -d

# 3. Install dependencies
pip install -r requirements.txt

# 4. Start producers & consumers
python producers/binance_producer.py
python consumers/analytics_consumer.py
python consumers/alert_consumer.py

# 5. (Optional) Run dashboard
cd dashboard/frontend
npm install && npm start

## Run

# 1. Run docker-compose.yaml
```bash
docker-compose up -d
``` 

# 2. Create Kafka topic
```bash
docker exec cryptopricealerts-kafka-1 kafka-topics --create --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1 --topic crypto_prices
``` 

# 2. Run ksqlDB and create stream
```bash
docker exec -it cryptopricealerts-ksqldb-cli-1 ksql http://ksqldb-server:8088

CREATE STREAM crypto_prices_stream (
  symbol VARCHAR,
  price DOUBLE,
  timestamp BIGINT
) WITH (
  KAFKA_TOPIC = 'crypto_prices',
  VALUE_FORMAT = 'JSON'
);
```

