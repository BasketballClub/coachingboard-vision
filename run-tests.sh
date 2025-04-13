#!/bin/sh
set -e

# 構建 Docker 映像
docker build -t my-app .

# 檢查代碼格式
if ! docker run --rm -v $(pwd):/app my-app sh -c "black . --check"; then
  echo "Code not formatted correctly. Formatting now..."
  # 格式化代碼
  docker run --rm -v $(pwd):/app my-app sh -c "black ."
  echo "\033[0;31mCode formatted. Please commit the changes. Tests aborted.\033[0m"
  # 刪除 Docker 映像
  docker rmi my-app
  exit 1
fi

# 格式正確時運行測試
docker run --rm -v $(pwd):/app my-app sh -c "pytest"

# 測試完成後刪除 Docker 映像
docker rmi my-app
