CREATE STREAM crypto_prices_formatted WITH (VALUE_FORMAT = 'AVRO') AS
SELECT
  symbol,
  price,
  TIMESTAMPTOSTRING(timestamp, 'yyyy-MM-dd HH:mm:ss', 'Europe/Warsaw') AS ts_fmt
FROM crypto_prices_stream
EMIT CHANGES;
