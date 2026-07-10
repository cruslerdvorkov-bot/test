# Используем образ Nginx с поддержкой SSL
FROM nginx:alpine

# Копируем конфигурацию Nginx
COPY default.conf /etc/nginx/conf.d/default.conf

# Создаем директорию для SSL-сертификатов
RUN mkdir -p /etc/ssl

# Копируем сертификаты с проверкой формата
COPY cert.pem /etc/ssl/cert.pem
COPY key.pem /etc/ssl/key.pem

# Проверяем, что файлы не пустые
RUN [ -s /etc/ssl/cert.pem ] || { echo "❌ Ошибка: Файл cert.pem пустой или не существует!"; exit 1; }
RUN [ -s /etc/ssl/key.pem ] || { echo "❌ Ошибка: Файл key.pem пустой или не существует!"; exit 1; }

# Устанавливаем права на приватный ключ
RUN chmod 600 /etc/ssl/key.pem

# Запускаем Nginx
EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
