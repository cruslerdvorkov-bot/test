FROM nginx:latest

# Копируем нашу конфигурацию nginx в контейнер
COPY nginx.conf /etc/nginx/nginx.conf
