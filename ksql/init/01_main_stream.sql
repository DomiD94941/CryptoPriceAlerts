CREATE STREAM crypto_prices_stream (
  symbol VARCHAR,
  price DOUBLE,
  timestamp BIGINT
) WITH (
  KAFKA_TOPIC = 'crypto_prices',
  VALUE_FORMAT = 'JSON',
  PARTITIONS = 1
);
