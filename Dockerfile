FROM nginx:latest

ENV TZ="Asia/Jakarta"
ENV PS1="\u@\h:\w\\$"

# Install system dependencies
RUN apt-get update && apt-get install -y \
   build-essential \
   vim \
   libzip-dev \
   git \
   cron \
   curl \
   zip \
   unzip \
   tzdata

RUN ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
   &&  dpkg-reconfigure --frontend noninteractive tzdata

WORKDIR /var/www/html

COPY . /var/www/html/

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

COPY ./nginx/my_custom_proxy_settings.conf /etc/nginx/conf.d/my_custom_proxy_settings.conf

CMD ["nginx", "-g", "daemon off;"]