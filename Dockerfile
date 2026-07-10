FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf

# Копируем файлы сертификатов и конфигурацию
COPY cert.pem /etc/ssl/mycert.pem
COPY key.pem /etc/ssl/mykey.pem
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443
