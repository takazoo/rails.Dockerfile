# Ruby on Rails実行環境Dockerコンテナイメージ

これはRuby on Railsの実行環境を作成するためのDockerイメージをビルドするDockerfileです。
Dockerをインストール後、以下のようにして、イメージをビルドし、コンテナを実行してください。

~~~
cd rails.Dockerfile
docker build -t rails:4.2.2
docker run --name rde -p 3000:3000 --restart=always -d rails:4.2.2 tail -f /dev/null
~~~

以下のようにコンテナにでシェルを実行して利用します。

~~~
docker exec -it rde /bin/bash
~~~

hello_app,toy_app,sample_appをgit cloneし、
ポートバインドし、rails serverコマンドなどを実行します。
コンテナの3000ポートをホストの3000ポートから公開しているため、アプリケーションはhttp:<IPアドレス>:3000/から動作確認できます。

~~~
rails server -b 0.0.0.0
~~~


