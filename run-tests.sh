#!/bin/sh
set -e

# 構建 Docker 映像
docker build -t my-app .

# 運行 Docker 容器，格式化代碼並執行測試
docker run --rm -v $(pwd):/app my-app sh -c "black . && pytest"
