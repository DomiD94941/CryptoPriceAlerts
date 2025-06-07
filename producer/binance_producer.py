import json
import websocket
from confluent_kafka import Producer

producer = Producer({'bootstrap.servers': 'localhost:29092'})  
TOPIC = 'crypto_prices'
BINANCE_WS = "wss://stream.binance.com:9443/ws/btcusdt@trade"

def on_message(ws, message):
    data = json.loads(message)
    payload = {
        "symbol": data['s'],
        "price": float(data['p']),
        "timestamp": data['T']
    }
    producer.produce(TOPIC, json.dumps(payload))
    producer.flush()
    print("→ Sent:", payload)

def on_error(ws, error): print("WebSocket Error:", error)
def on_close(ws, close_status_code, close_msg): print("WebSocket Closed")
def on_open(ws): print("Connected to Binance WebSocket")

if __name__ == "__main__":
    print("Starting Binance Kafka Producer..")
    ws = websocket.WebSocketApp(
        BINANCE_WS,
        on_open=on_open,
        on_message=on_message,
        on_error=on_error,
        on_close=on_close
    )
    ws.run_forever()


