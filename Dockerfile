FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf

# Создаем директорию для сертификатов
RUN mkdir -p /etc/nginx/ssl

# Монтируем сертификаты из переменных окружения
RUN echo "$RAILWAY_SSL_CERT" > /etc/nginx/ssl/cert.pem && \
    echo "$RAILWAY_SSL_KEY" > /etc/nginx/ssl/key.pem && \
    chmod 600 /etc/nginx/ssl/key.pem

EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
