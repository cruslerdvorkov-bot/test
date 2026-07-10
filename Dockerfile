# Используем OpenResty (включает NGINX + Lua + lua-nginx-module)
FROM openresty/openresty:latest

# Копируем конфигурацию NGINX
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

# Очистка кэша (опционально, уменьшает размер образа)
RUN rm -rf /var/lib/apt/lists/*
