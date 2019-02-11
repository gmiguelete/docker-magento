FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
	libmcrypt-dev  \
	libicu-dev \
	mysql-client \
	zlib1g-dev \
	&& docker-php-ext-install pdo_mysql \
 		iconv \
 		mcrypt \
		intl \
 		opcache \
		mbstring \
		zip

# Install PHP BCMath
RUN docker-php-ext-install bcmath

# Install PHP Soap
RUN apt-get install -y libxml2-dev && \
    docker-php-ext-install soap

# Install PHP GD
RUN apt-get install -y libpng-dev && \
    docker-php-ext-install gd

# Install PHP Gearman
RUN apt-get install -y libgearman-dev && \
    pecl install gearman && \
    echo extension=gearman.so > /usr/local/etc/php/conf.d/gearman.ini && \
	docker-php-ext-install sockets

# Install xDebug
RUN apt-get update -y && apt-get install -y \
    && pecl channel-update pecl.php.net \
 	&& pecl install xdebug-2.2.7  \
    && docker-php-ext-enable xdebug

COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY ./php-custom.ini /usr/local/etc/php/conf.d/php-custom.ini

# Install APC Cache
RUN pecl install apcu-4.0.11 \
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

# Install MailHog
RUN curl -fSL "https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64" -o /usr/local/bin/mailhog \
    && chmod +x /usr/local/bin/mailhog

COPY ./mailhog.ini /usr/local/etc/php/conf.d/mailhog.ini


CMD ["php-fpm"]
