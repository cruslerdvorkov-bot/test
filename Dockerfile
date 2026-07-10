FROM nginx:latest

# Устанавливаем зависимости для установки luarocks и lua-nginx-module
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpcre3-dev \
        zlib1g-dev \
        luarocks && \
    luarocks install lua-nginx-module

# Копируем конфигурацию Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Копируем приложение (если есть)
COPY ./app /app

# Запускаем Nginx
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
