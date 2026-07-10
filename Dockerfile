# Используем образ Nginx с поддержкой SSL
FROM nginx:alpine

# Копируем конфигурацию Nginx
COPY default.conf /etc/nginx/conf.d/default.conf

# Создаем директорию для SSL-сертификатов
RUN mkdir -p /etc/ssl

# Копируем сертификаты с проверкой формата
COPY public.key /etc/ssl/public.key
COPY private.key /etc/ssl/private.key

# Проверяем, что файлы не пустые
RUN [ -s /etc/ssl/public.key ] || { echo "❌ Ошибка: Файл public.key пустой или не существует!"; exit 1; }
RUN [ -s /etc/ssl/private.key ] || { echo "❌ Ошибка: Файл private.key пустой или не существует!"; exit 1; }

# Устанавливаем права на приватный ключ
RUN chmod 600 /etc/ssl/private.key

# Запускаем Nginx
EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
