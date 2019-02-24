const http = require('http');
const https = require('https');
const queryString = require('querystring');
const url = require('url');

const keys = require('./keys.json');

const CLIENT_ID = keys.clientID;
const CLIENT_SECRET = keys.clientSecret;


// メールアドレスを取得する
const getEmail = (access_token) => {
  // Promise
  return new Promise((resolve, reject) => {
    // 最終的に得られるレスポンスを保存する変数
    let resBodyFromGitHub = '';
    // GitHubに要求を出すときに必要な情報
    const reqBodyToGitHub = queryString.stringify({
      // 今回の場合はアクセストークンのみ渡せば良い
      access_token: access_token
    });
    // GitHubに要求を出す準備
    const reqToGitHubOptions = {
      protocol: 'https:',
      host: 'api.github.com',
      port: '443',
      // GETクエリを自分で組み立てる
      path: `/user/emails?${reqBodyToGitHub}`,
      method: 'GET',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': Buffer.byteLength(reqBodyToGitHub),
        // この要求ではUser-Agentが必須
        // Doc: https://developer.github.com/v3/#user-agent-required
        'User-Agent': 'pure-node-oauth'
      }
    };
    // GitHubに対する要求の本体
    const reqToGitHub = https.request(reqToGitHubOptions, (resFromGitHub) => {
      // レスポンスのエンコーディング設定
      resFromGitHub.setEncoding('utf8');
      // データが送られてきたときの処理
      resFromGitHub.on('data', (d) => {
        // 送られてきたデータをつなぎ合わせる
        resBodyFromGitHub += d;
      });
      // データの受信が終了したときの処理
      resFromGitHub.on('end', () => {
        // JSONを文字列化したデータを取得できるので、JavaScriptオブジェクトにパースする
        const arrayedResBodyFromGitHub = JSON.parse(resBodyFromGitHub);
        // データからメールアドレスのみを抽出する
        // Doc: https://developer.github.com/v3/users/emails/#response
        const emails = [];
        arrayedResBodyFromGitHub.forEach((el) => {
          emails.push(el.email);
        });
        // Promise.resolve() を呼び出す
        // then() の引数としてメールアドレスの配列を渡す
        resolve(emails);
      });
    });

    // エラーが発生した場合の処理
    reqToGitHub.on('error', (e) => {
      console.error(`[E]: ${e.message}`);
      reject(e);
    })
    // 実際に要求を送信する
    reqToGitHub.write(reqBodyToGitHub);
    reqToGitHub.end();
  });
};

// アクセストークンを取得する関数
const getAccessToken = (code) => {
  // Promiseを用いる
  return new Promise((resolve, reject) => {
    // 最終的に得られるレスポンスを保存する変数
    let resBodyFromGitHub = '';
    // GitHubに要求を出すときに必要な情報
    // Doc: https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#parameters-1
    const reqBodyToGitHub = queryString.stringify({
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      code: code
    });
    // GitHubに要求を出す準備
    // Doc: https://nodejs.org/api/http.html#http_http_request_url_options_callback
    const reqToGitHubOptions = {
      // URLの組み立ては [protocol]//[hostname]:[port][pathname]となる
      // 今の場合 https://github.com/login/oauth/access_token へのアPOSTクセスを組み立てている
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
    // GitHubに対する要求の本体
    const reqToGitHub = https.request(reqToGitHubOptions, (resFromGitHub) => {
      // エンコードの設定をしないとBufferとして扱われ、文字として表示されない
      resFromGitHub.setEncoding('utf8');
      // データが次々に降ってくるときの処理
      resFromGitHub.on('data', (chunk) => {
        // 降ってきたデータをつなぎ合わせる
        resBodyFromGitHub += chunk;
      });
      // データの受信が完了した場合の処理
      resFromGitHub.on('end', () => {
        // access_token=e72e16c7e42f292c6912e7710c838347ae178b4a&token_type=bearer などという情報がデータとして得られるので、パースする
        // Doc: https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#response
        const accessToken = queryString.parse(resBodyFromGitHub).access_token;
        // Promise.resolve() を呼び出して処理を終了
        // then() の引数関数にの引数にはaccessTokenが渡される
        resolve(accessToken);
      });
    });
    // 要求を出すときにエラーが発生した場合の処理
    reqToGitHub.on('error', (e) => {
      // Promise.reject() を呼び出して処理を終了
      // エラーオブジェクトをそのまま受け流す
      reject(e);
    });
    // 実際に要求を出す
    reqToGitHub.write(reqBodyToGitHub);
    reqToGitHub.end();
  });
}

// サーバの設定
// Doc: https://nodejs.org/api/https.html#https_https_createserver_options_requestlistener
const server = http.createServer((req, res) => {
  // Doc: https://nodejs.org/api/url.html
  const reqURL = url.parse(req.url);
  // 標準モジュールにはルーティングなどという便利な機能は無いのでswitchで切り分け
  switch (reqURL.pathname) {
    // http://localhost:3000/ にアクセスした場合
    case '/':
      // ユーザに認可を要求するときに必要な情報をまとめておく
      // Doc: https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#parameters
      const reqBodyToGitHub = queryString.stringify({
        client_id: CLIENT_ID,
        scope: 'user:email'
      });
      // ユーザに対して認可を取りに行く
      // HTTP 30x でリダイレクトをかけ、GitHub側に操作を渡す
      // GETクエリとして先ほどまとめた「ユーザに認可を要求するときに必要な情報」を渡す
      res.writeHead(303, { 'Location': `https://github.com/login/oauth/authorize?${reqBodyToGitHub}` });
      res.end();
      break;
    // http://localhost:3000/callback/ にアクセスした場合
    // GitHub側から自動的にアクセスされる
    case '/callback':
      // GitHubから自動的にアクセスされる時、GETクエリとして code が渡されるので、パースして code を取得する
      // Doc: https://nodejs.org/api/querystring.html#querystring_querystring_parse_str_sep_eq_options
      // 取得した code がユーザから渡される許可状(認可コード)
      // Doc: https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#2-users-are-redirected-back-to-your-site-by-github
      const tempCode = queryString.parse(reqURL.query).code;
      // ユーザから渡される許可状(認可コード)を添えて、GitHubに対して認可を要求する
      getAccessToken(tempCode)
        .then((accessToken) => {
          // GitHubから渡される許可状(アクセストークン)を添えて、GitHubに対してメールアドレスを教えるよう要求する
          return getEmail(accessToken);
        })
        .then((emails) => {
          res.writeHead(200);
          // GitHubから取得したメールをブラウザの画面に書く(OAuthとは無関係)
          emails.forEach((email, index) => {
            res.write(`emails[${index}]: ${email}\n`);
          })
          res.end();
        });
      break;
    // 想定していないURLにアクセスされたら404 Not Foundを返す
    default:
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end();
      break;
  }
});

// 3000番ポートのリッスン
// http://localhost:3000にアクセスすると動作が開始する
server.listen(3000);