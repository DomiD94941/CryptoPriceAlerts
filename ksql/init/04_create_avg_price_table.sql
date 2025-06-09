CREATE TABLE avg_crypto_prices_per_minute AS
SELECT
  symbol,
  TIMESTAMPTOSTRING(WINDOWSTART, 'yyyy-MM-dd HH:mm:ss', 'Europe/Warsaw') AS window_start,
  CAST(AVG(price) AS DOUBLE) AS avg_price
FROM crypto_prices_stream
WINDOW TUMBLING (SIZE 1 MINUTE)
WHERE symbol IN ('BTCUSDT', 'ETHUSDT')
GROUP BY symbol
EMIT CHANGES;
