# 1. Usamos la imagen base que pide el ejercicio
FROM php:apache

# 2. Actualizamos e instalamos herramientas (vim, nano, net-tools)
RUN apt-get update && apt-get install -y \
    vim \
    nano \
    net-tools \
    ssl-cert \
    && rm -rf /var/lib/apt/lists/*

# 3. Activamos el módulo SSL de Apache
RUN a2enmod ssl

# 4. Copiamos nuestros certificados dentro de la imagen
COPY ./certs/server.crt /etc/apache2/ssl/server.crt
COPY ./certs/server.key /etc/apache2/ssl/server.key

# 5. Copiamos la configuración de Apache
COPY ./conf/000-default.conf /etc/apache2/sites-available/000-default.conf

# 6. Copiamos nuestra web
COPY ./html /var/www/html/

# 7. Exponemos los puertos HTTP (80) y HTTPS (443)
EXPOSE 80 443
