from confluent_kafka import Consumer
import json

conf = {
    'bootstrap.servers': 'localhost:29092',
    'group.id': 'analytics-group',
    'auto.offset.reset': 'latest'
}

consumer = Consumer(conf)
consumer.subscribe(['crypto_prices'])

print("📥 Listening for crypto prices...")

try:
    while True:
        msg = consumer.poll(1.0)
        if msg is None:
            continue
        if msg.error():
            print("Error:", msg.error())
            continue

        data = json.loads(msg.value().decode('utf-8'))
        symbol = data.get('symbol')
        price = data.get('price')
        ts = data.get('timestamp')
        print(f"{symbol} @ {price} (ts: {ts})")


except KeyboardInterrupt:
    print("Stopping consumer...")
finally:
    consumer.close()

