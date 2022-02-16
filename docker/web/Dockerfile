FROM centos:7
LABEL maintainer="nedmaj@yahoo.com"
ENV PORT=80
RUN yum install httpd php mod_php php-mysql -y
COPY ./express /var/www/html
EXPOSE $PORT
WORKDIR /etc/httpd
CMD ["-D", "FOREGROUND"]
ENTRYPOINT [ "/usr/sbin/httpd" ]