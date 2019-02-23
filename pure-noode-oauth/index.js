const http = require('http');
const keys = require('./keys.json');

const CLIENT_ID = keys.clientID;
const CLIENT_SECRET = keys.clientSecret;

const server = http.createServer((req, res) => {
  switch (req.url) {
    case '/':
      res.writeHead(200, { 'Content-Type': 'text/plain' });
      res.end('root page');
    case '/hoge':
      res.writeHead(200, { 'Content-Type': 'text/plain' });
      res.end('hoge page');
    default:
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end();
  }
});

server.listen(3000);