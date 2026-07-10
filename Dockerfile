# Используем официальный образ NGINX
FROM nginx:alpine

# Копируем конфигурацию NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Копируем SSL-сертификаты (Render предоставит их автоматически)
RUN mkdir -p /etc/nginx/ssl && \
    echo "Рендер автоматически предоставит сертификаты" > /etc/nginx/ssl/placeholder.txt

# Копируем бэкенд (если есть)
# COPY backend/ /app/
# WORKDIR /app
# RUN npm install && npm run build

# Открываем порт
EXPOSE 80
EXPOSE 443
