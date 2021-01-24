# Docker with Django + Python3

Python3 + Django + MySQL5.7環境を作るシンプルなDocker環境構築セット。

https://docs.docker.jp/compose/django.html を参考。

## 備考：MySQL8を使用しない理由
MySQL側で ネイティブパスワードで接続するように指定しても、 Django側が `caching_sha2_password` を利用して接続しようとするため。

## インストールされるDjangoのバージョン
現時点では `2.2` （LTS）。
バージョンを指定してインストールしたい場合は、 `requirements.txt` の下記の行を修正する。
```
Django>=2.2,<2.3
```

ちなみに、`2.2` の次のLTSは `3.2` となることが確定している。（2021/4リリース予定）  
https://www.djangoproject.com/download/

## 初回のみ実行（ビルド〜DB設定まで）
### Dockerイメージのビルド

下記コマンドでDockerイメージをビルドする。  

```sh
$ cd path/to/
$ docker-compose run web django-admin.py startproject www .
```

【コマンドの補足】  
引数で指定したコンテナ内で、コマンドを実行する。
```sh
$ cd path/to/
$ docker-compose run <コンテナ名> <コマンド>
```

つまり、 `web` サービスイメージ `django-admin startproject www` が実行される。  
このコマンドは、 `Django` に対して、 `Django` プロジェクトを組み立てるファイル群の生成を指示するものである。  
 `www` の部分に指定した名前でディレクトリが作成され、その中にファイル群が生成される。


### DB接続設定
`composeexample/settings.py` から `DATABASE` と記載されている部分を探し、下記の内容で置き換える。

```py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'test_database',
        'USER': 'docker',
        'PASSWORD': 'docker',
        'HOST': 'mysql',
        'PORT': 3306,
    }
}
```

## DBマイグレーション
Webサーバのコンテナにログインし、DB migrateを実行する。

```sh
$ cd path/to/
$ docker-compose exec web bash # コンテナに入る
$ python manage.py migrate
```

## 開発時に都度実行

### コンテナ起動

```sh
$ docker-compose up
```

上記コマンドを実行後、 http://localhost にアクセスすると、 Djangoのデフォルトページが表示される。

#### アクセスできない場合（MySQLが Exit Code 2 により起動しない場合）
DjangoはDBとの疎通が正常にできない場合、Django自体もアクセスできない状態となる。

一度MySQL8.0でイメージをビルドし、その後MySQL5.xを使用するように `docker-compose.yml` を書き換えてリビルドした場合、  
MySQLが起動しなくなる現象が確認されている。

その場合、下記手順に従い、全てのコンテナ・イメージ・ボリュームを全て削除し、再度ビルドすることで、正常に起動するようになる。
https://qiita.com/astrsk_hori/items/6ca1ff27c911673ff7cc

### コンテナログイン（Webサーバ）

```sh
$ cd path/to/
$ docker-compose exec web bash
```

### コンテナログイン（DBサーバ）

```sh
$ cd path/to/
$ docker-compose exec db bash
```
