# Ruby on Rails実行環境Dockerコンテナイメージ

これはRuby on Railsの実行環境を作成するためのDockerイメージをビルドするDockerfileです。
Dockerをインストール後、以下のようにして、イメージをビルドし、コンテナを実行してください。

~~~
cd rails.Dockerfile
docker build -t rails:4.2.2
docker run --name rde -p 3000:3000 --restart=always -d rails:4.2.2 tail -f /dev/null
~~~

以下のようにコンテナにでシェルを実行し、hello_app,toy_app,sample_appをgit cloneし、rails serverコマンドなどを実行します。

~~~
docker exec -it rde /bin/bash
~~~
