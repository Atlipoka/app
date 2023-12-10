FROM nginx:latest

COPY ./pages/intro/intro.html /var/www/html/intro/intro.html
COPY ./pages/describe/desc.html /var/www/html/describe/desc.html
COPY ./pages/image/dev.jpg /var/www/html/image/dev.jpg
COPY ./default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
