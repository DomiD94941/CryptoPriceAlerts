CREATE TABLE avg_price_per_min AS
SELECT
  symbol,
  TIMESTAMPTOSTRING(WINDOWSTART, 'yyyy-MM-dd HH:mm:ss', 'Europe/Warsaw') AS window_start,
  AVG(price) AS avg_price
FROM crypto_prices_stream
WINDOW TUMBLING (SIZE 1 MINUTE)
GROUP BY symbol
EMIT CHANGES;
