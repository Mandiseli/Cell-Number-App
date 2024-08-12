const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors());

const dbConfig = {
  host: 'srv1475.hstgr.io',
  user: 'u296730420_siluxcontrol',
  password: '!Q1w2e3q1w2e3',
  database: 'u296730420_siluxcontrol'
};

let db;

function handleDisconnect() {
  db = mysql.createConnection(dbConfig);

  db.connect(err => {
    if (err) {
      console.error('Error connecting to MySQL database:', err);
      setTimeout(handleDisconnect, 2000); // Retry connection after 2 seconds
      return;
    }
    console.log('Connected to MySQL database');
  });

  db.on('error', err => {
    console.error('MySQL error', err);
    if (err.code === 'PROTOCOL_CONNECTION_LOST' || err.code === 'ECONNRESET') {
      handleDisconnect(); // Reconnect on connection loss
    } else {
      throw err; // Throw other errors
    }
  });
}

// Call handleDisconnect initially to set up the connection
handleDisconnect();

// Keep-alive mechanism
setInterval(() => {
  db.query('SELECT 1', (err, results) => {
    if (err) {
      console.error('Error executing keep-alive query:', err);
    }
  });
}, 60000); // Execute every minute

app.get('/cellnumbers', (req, res) => {
  const query = 'SELECT * FROM hsbc_cellnumberlink';
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

app.post('/assign', (req, res) => {
  const { cellNumber, expiryDate, hub } = req.body;
  const query = 'INSERT INTO hsbc_cellnumberlink (cell_number, expiry_date, hub) VALUES (?, ?, ?)';
  db.query(query, [cellNumber, expiryDate, hub], (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json({ success: true, id: results.insertId });
  });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

