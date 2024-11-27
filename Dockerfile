# Python 3.9 bazlı imaj
FROM python:3.9-slim

# Çalışma dizini oluştur
WORKDIR /app

# requirements.txt dosyasını kopyala
COPY requirements.txt /app/

# Bağımlılıkları yükle
RUN pip install --no-cache-dir -r requirements.txt

# Uygulama dosyasını kopyala
COPY . /app/

# Prometheus için metrikleri yayınlamak üzere ek bir port aç
EXPOSE 8000

# Uygulama çalıştırma komutu
CMD ["python", "ETL.py"]
