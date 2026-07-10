# Используем официальный образ NGINX
FROM nginx:alpine

# Копируем только конфиг NGINX (папку html удаляем)
COPY nginx.conf /etc/nginx/nginx.conf

# Порт, который будет открыт
EXPOSE 8443
