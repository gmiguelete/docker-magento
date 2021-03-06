FROM php:7.1.14-fpm

RUN apt-get update && apt-get install -y \     
    cron libfreetype6-dev libicu-dev \      
    libjpeg62-turbo-dev libmcrypt-dev libpng12-dev \        
    libxslt1-dev

RUN docker-php-ext-configure \
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \       
    bcmath \        
    gd \        
    intl \      
    mbstring \      
    mcrypt \        
    pdo_mysql \     
    soap \      
    xsl \       
    zip

# Install MailHog
COPY ./mailhog.ini /usr/local/etc/php/conf.d/mailhog.ini

RUN curl -fSL "https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64" -o /usr/local/bin/mailhog \
    && chmod +x /usr/local/bin/mailhog

# Install xDebug
COPY ./xdebug.ini /usr/local/etc/php/conf.d/

RUN apt-get update -y && apt-get install -y \       
    && pecl install xdebug  \     
    && docker-php-ext-enable xdebug

# Install MongoDB
RUN apt-get update -y && apt-get install -y \
    && pecl install mongodb  \
    && docker-php-ext-enable mongodb

# Install Composer
RUN curl -sS https://getcomposer.org/installer | \
  php -- --install-dir=/usr/local/bin --filename=composer

CMD ["php-fpm"]
