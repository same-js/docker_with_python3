#!/bin/bash

# Git管理しないディレクトリとファイルを自動生成する
mkdir www
mkdir -p mysql/logs
touch mysql/logs/mysql-error.log
touch mysql/logs/mysql-query.log
touch mysql/logs/mysql-slow.log
