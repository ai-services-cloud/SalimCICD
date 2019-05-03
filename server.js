const express = require('express');
const port = 4000;
const app = express();

app.listen(port)

console.log('Server running at http://localhost:' + port)

app.get('/', (req, res) => {
  res.set('Content-Type', 'text/plain');
  secret = process.env.MYSUPERSECRET || 'no secret set'
  res.send(`Hello World ` + secret);
  return res.end();
});
