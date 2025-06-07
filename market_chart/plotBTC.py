from kafka import KafkaConsumer
import json
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import datetime

TOPIC = 'crypto_prices_formatted'
BOOTSTRAP_SERVERS = 'localhost:29092'

consumer = KafkaConsumer(
    TOPIC,
    bootstrap_servers=BOOTSTRAP_SERVERS,
    value_deserializer=lambda m: json.loads(m.decode('utf-8')),
    auto_offset_reset='latest',
    enable_auto_commit=True
)

data = []

print("🎨 Rysuję i zapisuję wykresy co 10 sekund...")

last_save_time = datetime.datetime.now()

while True:
    msg = next(consumer)
    value = msg.value
    if value['symbol'] == 'BTCUSDT':
        value['ts_fmt'] = pd.to_datetime(value['ts_fmt'])
        data.append(value)

    now = datetime.datetime.now()
    if (now - last_save_time).total_seconds() > 10:
        df = pd.DataFrame(data[-50:])  # ostatnie 50 rekordów
        df = df.sort_values('ts_fmt')

        plt.figure(figsize=(10, 4))
        plt.plot(df['ts_fmt'], df['price'], marker='o')
        plt.title('BTCUSDT - Live cena')
        plt.xlabel('Czas')
        plt.ylabel('Cena')
        plt.xticks(rotation=45)
        plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%H:%M:%S'))
        plt.tight_layout()
        plt.savefig('plot.png')
        plt.close()

        print(f"[{now.strftime('%H:%M:%S')}] zapisano wykres do plot.png")
        last_save_time = now
