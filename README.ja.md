#docker-bind
BIND起動用Dockerfile

##概要
BINDを簡易起動する構成のDockerfileです。

##Maintainer
minanon

##外部からアクセスするための情報
- 使用するポート番号は、53(UDPとTCP）です
- データの保存箇所は/etc/namedとなっています

##起動方法
以下のようなコマンドで実行します。

    docker run -d --name bind -p 53:53/udp -p 53:53 -v /opt/docker/data/bind:/etc/named -d minanon/bind
