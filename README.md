# 🚀 Real-Time Crypto Price Analytics & Alert System

This project is a real-time cryptocurrency price tracking, analytics, and alerting system powered by **Apache Kafka**. It collects live market data from crypto exchanges (e.g., Binance), processes it in real time, and triggers alerts based on user-defined conditions.

---

## 📊 Features

- ✅ Real-time crypto price streaming via Kafka
- 📈 Moving average, price delta, and volatility analytics
- 🔔 Configurable alert system for threshold breaches
- 💾 Optional persistence to PostgreSQL
- 📺 Live dashboard (React.js)
- 🧠 Stream processing with **ksqlDB** or **Kafka Streams**

---

## 🧱 Architecture

```plaintext
[Binance WS API] → [Kafka Producer] → [Kafka Topic: crypto_prices]
                                   ↓
              [Analytics] [Alerting] [Storage] [ksqlDB Queries]
                                   ↓
                        [Kafka Topic: alerts]
                                   ↓
                     [Backend API → Dashboard → User]
```


## 🧪 Prerequisites

Docker & Docker Compose

Python 3.9+

Node.js (for frontend dashboard)

Git

Binance API key (optional)

## 🚀 Getting Started

```bash
# 1. Clone the repo
git clone https://github.com/youruser/crypto-alert-system.git
cd crypto-alert-system

# 2. Start Kafka stack + PostgreSQL
docker-compose up -d

# 3. Install Python dependencies
pip install -r requirements.txt

# 4. Start producers and consumers
python producers/binance_producer.py
python consumers/analytics_consumer.py
python consumers/alert_consumer.py

# 5. (Optional) Run the dashboard
cd dashboard/frontend
npm install && npm start
```

## 📡 Kafka Topics

crypto_prices: Raw streaming data from Binance
alerts: Triggered alerts (e.g., threshold exceeded)
