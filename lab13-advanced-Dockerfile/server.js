'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
var requestId = 0;
app.get('/', (req, res) => {
  requestId++;
  var ip = req.ip;
  console.log('Got request ' + requestId + ' from IP ' + ip + '\n');
  res.type('json');
  res.send('{ "ip": "'+ ip + '", "requestId": ' + requestId + ' }\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
