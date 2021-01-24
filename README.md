# Docker with Django

　参考：https://docs.docker.jp/compose/django.html

下記コマンドでDockerイメージをビルドする。  

```sh
$ docker-compose run web django-admin.py startproject composeexample .
```

【コマンドの補足】  
引数で指定したコンテナ内で、コマンドを実行する。
```sh
$ docker-compose run <コンテナ名> <コマンド>
```

つまり、 `web` サービスイメージ `django-admin startproject` が実行される。  
このコマンドは、 `Django` に対して、 `Django` プロジェクトを組み立てるファイル群の生成を指示するものである。
