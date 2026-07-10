# Используем официальный образ NGINX с поддержкой Lua
FROM nginx:latest

# Устанавливаем зависимости для Lua и NGINX
RUN apt-get update && \
    apt-get install -y nginx-extras luarocks && \
    luarocks install lua-nginx-module

# Копируем конфигурацию NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Удаляем стандартный конфиг (если не нужен)
RUN rm /etc/nginx/conf.d/default.conf

# Очистка кэша (опционально, но рекомендуется)
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
