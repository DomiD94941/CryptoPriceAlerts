CREATE STREAM BTC_PRICES WITH (VALUE_FORMAT = 'AVRO') AS
SELECT
  symbol,
  price,
  TIMESTAMPTOSTRING(timestamp, 'yyyy-MM-dd HH:mm:ss.SSS', 'Europe/Warsaw') AS ts
FROM crypto_prices_stream
WHERE symbol = 'BTCUSDT'
EMIT CHANGES;
