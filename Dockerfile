FROM nginx:1.15.8

ADD assets/ /var/www/html/assets
ADD css/ /var/www/html/css
ADD js/ /var/www/html/js
ADD img/ /var/www/html/img
ADD classificados/ /var/www/html/classificados 
ADD index.html /var/www/html/index.html

EXPOSE 80
