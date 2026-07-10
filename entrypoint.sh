!/bin/sh
 
# Останавливаем Nginx, если уже работает (на всякий случай)
nginx -s stop 2>/dev/null || true

# Создаем файлы сертификатов из переменных
echo "Создание файлов сертификатов..."
echo "$RAILWAY_SSL_CERT" > /etc/nginx/ssl/cert.pem
echo "$RAILWAY_SSL_KEY" > /etc/nginx/ssl/key.pem

# Проверяем, что файлы не пустые
if [ ! -s /etc/nginx/ssl/cert.pem ] || [ ! -s /etc/nginx/ssl/key.pem ]; then
    echo "❌ Ошибка: Файлы сертификатов пустые или не существуют!"
    echo "🔹 Проверьте, что переменные RAILWAY_SSL_CERT и RAILWAY_SSL_KEY установлены в Railway."
    exit 1
fi

# Устанавливаем правильные права на приватный ключ
chmod 600 /etc/nginx/ssl/key.pem

# Запускаем Nginx
echo "🚀 Запуск Nginx с SSL..."
nginx -g "daemon off;"
