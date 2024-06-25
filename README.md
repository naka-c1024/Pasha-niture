# Pasha-niture

<img src=https://github.com/naka-c1024/Pasha-niture/blob/main/client/app/assets/images/logo.png/ width=50%>

#### ぱしゃっと検索、かしゃっと出品

## 概要

<100文字程度で>

<プレゼン資料URL?>

## 環境構築

### backend

Dockerコンテナを立ち上げる。

```bash
$ cd backend 
$ docker-compose up --build
```

以下のようにcurlを叩き、`API is running`と返却されたらバックエンドは完了。

```bash
$ curl http://localhost:8080/ok
{"msg":"API is running"}%
```

もしデモデータを入れたい場合はコンテナが起動した状態で以下を打つ。

```bash
$ docker-compose exec backend-app python -m openapi_server.migrate_db
```

### client

- Flutter 3.22.2
- Dart 3.4.3
- iOS 17.5.1

#### ターミナルからビルド
Pasha-niture/client/app/ で以下を実行　
```
flutter run
```
#### XCodeからビルド
Pasha-niture/client/app/ios/Runner.xcworkspace をビルド

## 技術構成

<使用技術のスライドとかER図などなど>
