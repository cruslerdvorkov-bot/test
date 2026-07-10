# Используем официальный образ NGINX
FROM nginx:alpine

# Копируем только конфиг NGINX (папку html удаляем)
COPY nginx.conf /etc/nginx/nginx.conf

# (Опционально) Если нужен статический сайт, создайте папку `html` и положите туда файлы
# RUN mkdir -p /usr/share/nginx/html
# COPY html/ /usr/share/nginx/html/

# Порт, который будет открыт
EXPOSE 80
