# docker-mirakurun-chinachu
Mirakurun と Chinachu をDockerコンテナに閉じ込めました

## Constitution
### Mirakurun
- Alpine Linux 3.4
- [Mirakurun](https://github.com/kanreisa/Mirakurun)

### Chinachu
- Alpine Linux 3.4
- [Chinachu](https://github.com/kanreisa/Chinachu)  
branch: devel-beta
- [Rivarun](https://github.com/kanreisa/Rivarun)

## 動作確認環境
>CentOS Linux release 7.2.1511 (Core)  
> Linux 3.10.0-327.22.2.el7.x86_64  

> Docker version 1.11.2, build b9f10c9

> ISDB-S, ISDB-T Tuner PT3  
> USB SmartCard Reader NTT Communications Corp. SCR3310-NTTCom

## 利用方法
- 最新のdocker & docker-compose がインストール済
- SELinuxの無効化推奨
- ホストマシンにPT3 Driverがインストール済
```
$ ls -l /dev/pt*video*
crw-rw-rw- 1 root video 246, 0 Jun 26 16:07 /dev/pt3video0
crw-rw-rw- 1 root video 246, 1 Jun 26 16:07 /dev/pt3video1
crw-rw-rw- 1 root video 246, 2 Jun 26 16:07 /dev/pt3video2
crw-rw-rw- 1 root video 246, 3 Jun 26 16:07 /dev/pt3video3
```
- B-CAS 用に利用するスマートカードリーダーはMirakurunコンテナ内で管理しますので  
ホストマシン上のpcscdは停止してください
```
sudo systemctl stop pcscd.socket
sudo systemctl disable pcscd.socket
```

- docker-composeを利用しておりますので、プロジェクトディレクトリ内で下記コマンドを実行してください  
プロジェクトディレクトリ名はビルド時のレポジトリ名になりますので、適当に短いフォルダ名が推奨です

### 取得例
```
git clone https://github.com/h-mineta/docker-mirakurun-chinachu.git tvs
cd tvs
```
### 起動
```
docker-compose up -d
```
### 停止
```
docker-compose down
```

## 設定
エリア、環境によって変更が必要なファイルは下記の通りとなります
### Mirakurun
- ポート番号 : 36960
- mirakurun/config/tuners.yml  
チューナー設定
- mirakurun/config/channels.yml  
チャンネル設定

### Chinachu
- ポート番号 : 10772
- chinachu/config/config.json  
チューナー設定  
チャンネル設定

### 録画ファイル保存先
また録画ファイルはプロジェクトフォルダ内の./recordedに保存されます  
> 保存先を別HDDにしたい場合は、docker-compose.ymlの
>> ./recorded:/usr/local/chinachu/recorded
>
> を./recordedを変更することで保存先を変更可能

## License
This software is released under the MIT License, see LICENSE.
