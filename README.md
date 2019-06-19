# chinachu-docker
Chinachu と samba をDockerコンテナに閉じ込めました

## 前提条件
- 他のホストで　Mirakurun が稼働していること
- 最新のdocker & docker-compose がインストール済

## 準備

### Sambaユーザー名・パスワードの設定
docker-compose.ymlの最終行のユーザー名、パスワードを書き換えます。

```
    command: '-n -u "user;badpass" -s （略）
```

### 録画先フォルダ・データフォルダを変更します。

docker-compose.ymlの最終行のユーザー名、パスワードを書き換えます。

```yaml
     - ./conf/config.json:/usr/local/chinachu/config.json:rw
     - ./conf/rules.json:/usr/local/chinachu/rules.json:rw
     - ./data:/usr/local/chinachu/data:rw          # データフォルダ（録画済みファイルリスト、予約リスト）
     - ./recorded:/usr/local/chinachu/recorded:rw  # 録画データフォルダ
```

### 
docker-compose.ymlの最終行のユーザー名、パスワードを書き換えます。

```
                       ↓     ↓
    command: '-n -u "user;badpass" -s （略）
```

### 起動

```shell
docker-compose up -d
```

### 停止

```shell
docker-compose down
```

### Chinachu
- ポート番号 : 10772, 20772(local network only), 5353/udp(mDNS)
- chinachu/conf/config.json  
チューナー設定  
チャンネル設定

## License
This software is released under the MIT License, see LICENSE.
