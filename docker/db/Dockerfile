FROM mariadb
LABEL maintainer="nedmaj@yahoo.com"
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=backup
ENV MYSQL_USER=express
ENV MYSQL_PASSWORD=AllSAfe0!
EXPOSE 3306
COPY ./backup.sql /tmp
WORKDIR /tmp
CMD ["mysqld"]