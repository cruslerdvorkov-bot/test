# Используем OpenResty (включает Lua, lua-nginx-module и resty.http)
FROM openresty/openresty:latest

# Копируем пользовательскую конфигурацию NGINX
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

# Очистка кэша (опционально, но рекомендуется для уменьшения размера образа)
RUN rm -rf /var/lib/apt/lists/*
