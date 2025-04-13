FROM python:3.10-slim

WORKDIR /app

# 複製並安裝依賴
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 安裝 black
RUN pip install black

# 複製所有項目文件
COPY . .

# 自動格式化代碼並運行應用
CMD ["sh", "-c", "black . && python main.py"]
