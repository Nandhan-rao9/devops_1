require('dotenv').config();
const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;
const USERNAME = process.env.USERNAME;
const PASSWORD = process.env.PASSWORD;
const SECRET_MESSAGE = process.env.SECRET_MESSAGE || 'No secret set.';

function basicAuth(req, res, next) {
  const authHeader = req.headers['authorization'] || '';
  const [type, encoded] = authHeader.split(' ');
  if (type !== 'Basic' || !encoded) {
    res.set('WWW-Authenticate', 'Basic realm="Secret Area"');
    return res.status(401).send('Authentication required');
  }

  const [user, pass] = Buffer.from(encoded, 'base64').toString().split(':');
  const ok = user === USERNAME && pass === PASSWORD;
  if (!ok) {
    res.set('WWW-Authenticate', 'Basic realm="Secret Area"');
    return res.status(401).send('Invalid credentials');
  }
  return next();
}

app.get('/', (req, res) => {
  res.send('Hello, world!');
});

app.get('/secret', basicAuth, (req, res) => {
  res.send(SECRET_MESSAGE);
});

app.listen(PORT, () => {
  console.log(`Server listening on http://localhost:${PORT}`);
});
