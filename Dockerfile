FROM nginx:alpine

# Копируем свой конфиг в нужное место
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
