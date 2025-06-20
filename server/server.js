const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const { Client } = require('pg');

const PORT = process.env.PORT || 3001;

const app = express();
const httpServer = http.createServer(app);
const io = new Server(httpServer, {
  cors: {
    origin: '*'
  }
});

const db = new Client({
  host: process.env.PGHOST || 'postgres',
  port: process.env.PGPORT || 5432,
  user: process.env.PGUSER || 'crypto',
  password: process.env.PGPASSWORD || 'crypto',
  database: process.env.PGDATABASE || 'cryptodb'
});

db.connect().catch(err => console.error('DB connection error', err));

async function fetchLatest() {
  const query = 'SELECT DISTINCT ON (LEFT("TS", 19)) LEFT("TS", 19) AS "TS", "PRICE" FROM "BTC_PRICES" ORDER BY LEFT("TS", 19) DESC, "TS" DESC LIMIT 100;';
  const { rows } = await db.query(query);
  return rows;
}

async function broadcast() {
  try {
    const rows = await fetchLatest();
    io.emit('prices', rows);
  } catch (err) {
    console.error('Error fetching prices', err);
  }
}

io.on('connection', socket => {
  console.log('Client connected');
  fetchLatest().then(data => socket.emit('prices', data)).catch(console.error);
});

setInterval(broadcast, 5000);

httpServer.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
