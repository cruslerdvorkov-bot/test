FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/nginx/ssl
COPY entrypoint.sh /entrypoint.sh

# Даем права на выполнение скрипта
RUN chmod +x /entrypoint.sh
# Указываем скрипт как точку входа
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
EXPOSE 443
