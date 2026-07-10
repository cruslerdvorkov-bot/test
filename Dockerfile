# Используем OpenResty (включает Lua, lua-nginx-module и resty.http)
FROM openresty/openresty:latest

# Копируем пользовательскую конфигурацию NGINX
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

# Удаляем стандартный конфиг (если не нужен)
RUN rm /usr/local/openresty/nginx/conf/conf.d/default.conf

# Очистка кэша (опционально, но рекомендуется для уменьшения размера образа)
RUN rm -rf /var/lib/apt/lists/*
