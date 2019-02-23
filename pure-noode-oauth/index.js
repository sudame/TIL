const http = require('http');
const https = require('https');
const queryString = require('querystring');
const url = require('url');

const keys = require('./keys.json');

const CLIENT_ID = keys.clientID;
const CLIENT_SECRET = keys.clientSecret;

const server = http.createServer((req, res) => {
  const reqURL = url.parse(req.url);
  const reqPathName = reqURL.pathname;

  switch (reqPathName) {
    case '/':
      const requrestBody = queryString.stringify({
        client_id: CLIENT_ID,
        scope: 'user:email'
      });
      res.writeHead(303, { 'Location': `https://github.com/login/oauth/authorize?${requrestBody}` });
      res.end();
    case '/callback':

      console.log(queryString.parse(reqURL.query).code);
      const requestBody = queryString.stringify({
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        code: queryString.parse(reqURL.query).code
      });


      const requestClient = https.request('https://github.com/login/oauth/access_token', {
        method: 'POST',
        hostname: 'github.com',
        port: 443,
        path: '/login/oauth/access_token',
        headers: {
          "Content-type": "application/x-www-form-urlencoded",
          'Content-Length': requestBody.length
        },
      }, (responseClient) => {
        console.log(responseClient.statusCode);
        responseClient.setEncoding('utf8');
        responseClient.on('data', (d) => {
          console.log(queryString.parse(d));
        })
      });

      requestClient.write(requestBody);

      res.writeHead(200);
      res.end();
    default:
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end();
  }
});

server.listen(3000);