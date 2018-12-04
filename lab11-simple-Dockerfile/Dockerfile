FROM centos:7

RUN yum install -y httpd && \
    yum clean all && \
    echo "It works" >/var/www/html/index.html

CMD /usr/sbin/httpd -DFOREGROUND

