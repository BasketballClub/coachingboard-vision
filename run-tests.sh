#!/bin/sh
set -e

# 構建 Docker 映像
docker build -t my-app .

# 檢查代碼格式
docker run --rm -v $(pwd):/app my-app sh -c "black . --check"
if [ $? -ne 0 ]; then
  echo "Code not formatted correctly. Please run black."
  # 格式化代碼
  docker run --rm -v $(pwd):/app my-app sh -c "black ."
  exit 1
fi

# 格式正確時運行測試
docker run --rm -v $(pwd):/app my-app sh -c "pytest"
