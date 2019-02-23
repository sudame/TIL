const http = require('http');
const queryString = require('querystring');
const keys = require('./keys.json');

const CLIENT_ID = keys.clientID;
const CLIENT_SECRET = keys.clientSecret;

const server = http.createServer((req, res) => {
  switch (req.url) {
    case '/':
      const requrestBody = queryString.stringify({
        client_id: CLIENT_ID,
        scope: 'user:email'
      });
      res.writeHead(303, { 'Location': `https://github.com/login/oauth/authorize?${requrestBody}` });
      res.end();
    case '/hoge':
      res.writeHead(200, { 'Content-Type': 'text/plain' });
      res.end('hoge page');
    default:
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end();
  }
});

server.listen(3000);