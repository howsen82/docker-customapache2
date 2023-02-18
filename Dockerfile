FROM ubuntu

LABEL maintainer="mail@email.com"
LABEL description="Test"

ENV TZ="Asia/Kuala_Lumpur" \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2

# Set time time, install Apache, remove unnecessary file
# from package cache immediately, enable HTTPS
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y apache2 && \
    apt-get -y clean && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* && \
    a2ensite default-ssl && \
    a2enmod ssl

# Release ports 80 and 443
EXPOSE 80 443

# Copy entire content of project directory
COPY . /var/www/html

# Start command
CMD [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]