const http = require('http');
const https = require('https');
const queryString = require('querystring');
const url = require('url');

const keys = require('./keys.json');

const CLIENT_ID = keys.clientID;
const CLIENT_SECRET = keys.clientSecret;


function getEmail(access_token, res) {
  let data = '';

  const reqBodyToGitHub = queryString.stringify({
    access_token: access_token
  });

  const reqToGitHubOptions = {
    protocol: 'https:',
    host: 'api.github.com',
    port: '443',
    path: `/user/emails?${reqBodyToGitHub}`,
    method: 'GET',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Length': Buffer.byteLength(reqBodyToGitHub),
      'User-Agent': 'hoge'
    }
  };

  const reqToGitHub = https.request(reqToGitHubOptions, (resFromGitHub) => {
    resFromGitHub.setEncoding('utf8');

    resFromGitHub.on('data', (d) => {
      data += d;
      console.log(d);
    });

    resFromGitHub.on('end', () => {
      data = JSON.parse(data);
      let emails = [];
      data.forEach(el => {
        emails.push(el.email);
      });


      res.writeHead(200);
      res.end(emails.toString());
    });
  });

  reqToGitHub.on('error', (e) => {
    console.error(`[E]: ${e.message}`);
  })

  reqToGitHub.write(reqBodyToGitHub);
  reqToGitHub.end();
}

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
      break;
    case '/callback':

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
        responseClient.setEncoding('utf8');
        responseClient.on('data', (d) => {
          getEmail(queryString.parse(d).access_token, res);
        })
      });

      requestClient.write(requestBody);
      break;
    default:
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end();
      break;
  }
});

server.listen(3000);