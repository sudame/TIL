const http = require('http');
const https = require('https');
const queryString = require('querystring');
const url = require('url');

const keys = require('./keys.json');

const CLIENT_ID = keys.clientID;
const CLIENT_SECRET = keys.clientSecret;


const getEmail = (access_token) => {
  return new Promise((resolve, reject) => {
    let resBodyFromGitHub = '';

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
        'User-Agent': 'pure-node-oauth'
      }
    };

    const reqToGitHub = https.request(reqToGitHubOptions, (resFromGitHub) => {
      resFromGitHub.setEncoding('utf8');

      resFromGitHub.on('data', (d) => {
        resBodyFromGitHub += d;
      });

      resFromGitHub.on('end', () => {
        const arrayedResBodyFromGitHub = JSON.parse(resBodyFromGitHub);
        const emails = [];

        arrayedResBodyFromGitHub.forEach((el) => {
          emails.push(el.email);
        });
        resolve(emails);
      });
    });

    reqToGitHub.on('error', (e) => {
      console.error(`[E]: ${e.message}`);
      reject(e);
    })

    reqToGitHub.write(reqBodyToGitHub);
    reqToGitHub.end();
  });
};

const getAccessToken = (code) => {
  return new Promise((resolve, reject) => {
    let resBodyFromGitHub = '';

    const reqBodyToGitHub = queryString.stringify({
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      code: code
    });

    const reqToGitHubOptions = {
      protocol: 'https:',
      hostname: 'github.com',
      port: 443,
      path: '/login/oauth/access_token',
      method: 'POST',
      headers: {
        'Content-type': 'application/x-www-form-urlencoded',
        'Content-Length': reqBodyToGitHub.length,
        'User-Agent': 'pure-node-oauth',
      },
    };

    const reqToGitHub = https.request(reqToGitHubOptions, (resFromGitHub) => {
      resFromGitHub.setEncoding('utf8');
      resFromGitHub.on('data', (chunk) => {
        resBodyFromGitHub += chunk;
      });

      resFromGitHub.on('end', () => {
        const accessToken = queryString.parse(resBodyFromGitHub).access_token;
        resolve(accessToken);
      });
    });

    reqToGitHub.on('error', (e) => {
      reject(e);
    });

    reqToGitHub.write(reqBodyToGitHub);
    reqToGitHub.end();
  });
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
      const tempCode = queryString.parse(reqURL.query).code;
      getAccessToken(tempCode).then((accessToken) => {
        return getEmail(accessToken);
      }).then((emails) => {
        res.writeHead(200);
        emails.forEach((email, index) => {
          res.write(`emails[${index}]: ${email}\n`);
        })
        res.end();
      });
      break;

    default:
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end();
      break;
  }
});

server.listen(3000);