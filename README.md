# Crypto Price Alerts – Real-Time Kafka Pipeline with PostgreSQL Sink

This project is a **real-time streaming pipeline** that ingests cryptocurrency prices (e.g. BTCUSDT, ETHUSDT), processes and aggregates them using **Apache Kafka + ksqlDB**, and stores 1-minute average prices in **PostgreSQL**.

---

## Stack

- **Apache Kafka** – message broker
- **ksqlDB** – real-time SQL engine over Kafka
- **Kafka Connect** – ETL layer with JDBC Sink
- **PostgreSQL** – destination database
- **Confluent Schema Registry** – AVRO schema management
- **Kafka UI** – GUI to browse topics
- **Docker Compose** – for full infrastructure setup

---

## What It Does

1. **Data Ingestion**: a Kafka producer (WebSocket client) sends crypto price ticks to the topic `crypto_prices` in raw JSON.
2. **Stream Parsing**: `ksqlDB` creates a stream `crypto_prices_stream` to parse incoming JSON data.
3. **AVRO Conversion**: the stream is formatted and written to a new topic (`CRYPTO_PRICES_FORMATTED`) in AVRO.
4. **Aggregation**: `ksqlDB` creates a 1-minute tumbling window table of average prices → `AVG_CRYPTO_PRICES_PER_MINUTE`.
5. **Storage**: `Kafka Connect` reads AVRO messages and writes to PostgreSQL table `AVG_CRYPTO_PRICES_PER_MINUTE`.
6. **Schemas**: AVRO schemas are managed by **Schema Registry**.

---

## How to Run

1. **Clone & Start the Stack (Just it. Everything needed is done automatically after running the commands below)**

```bash

docker-compose down -v
docker-compose up -d
```

2. **Run the Binance price producer**

```bash
pip install -r requirements.txt
python producer/binance_producer.py
```

3. **Run the sample analytics consumer**

```bash
python consumer/analytics_consumer.py
```

4. **Start the Node server (once implemented)**

```bash
cd server
npm install
npm start
```

5. **Start the React client (once implemented)**

```bash
cd client
npm install
npm start
```
