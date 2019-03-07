# Pure Node OAuth

このレポジトリは[Qiitaの記事](https://qiita.com/sudame/items/50e740f48ffdf95547e7)用のレポジトリです。

## 試してみる

`index.js` を動作させるには以下の設定が必要です。

### ① GitHubにアプリを登録する

[こちら](https://github.com/settings/applications/new)から自分のアプリを新規登録してください。

`Application Name` や `Homepage URL` は適当で構いませんが、 `index.js` をそのまま動作させる場合、 `Authorization callback URL` には `http://localhost:3000/callback` を指定してください。

### ② アプリ情報の確認

新規登録が完了したら、[こちら](https://github.com/settings/developers)にアクセスしてください。新規登録したアプリが表示されているはずです。

アプリを開くと、 `Client ID` と `Client Secret` が見えると思います。これを控えておいてください。

### ③ `keys.json` の作成

`index.js` と同じディレクトリ(フォルダ)に、 `keys.json` というファイルを新規作成し、下記のような内容にしてください。

```json
{
  "clientID": "<取得した Client ID>",
  "clientSecret": "<取得した Client Secret>"
}
```

ここまで終えれば、 `index.js` は動作するはずです。

```bash
$ node index.js
```

で起動してみてください。

## お問い合わせ

[ホームページ](https://sudame.net)をご覧になってください。
