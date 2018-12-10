FROM  centos:7
LABEL com.li9.maintainer="Artemii Kropachev"
ARG   ADMIN_PASSWORD=Example123
COPY  jboss-eap-7.1.0.zip /opt
ENV   EAP_HOME=/opt/jboss-eap-7.1
RUN   yum update -y \
 &&   yum install --setopt=tsflags=nodocs -y java-1.8.0-openjdk unzip \
 &&   yum clean all \
 &&   useradd -u 1001 jboss \
 &&   unzip /opt/jboss-eap-7.1.0.zip -d /opt \
 &&   rm -f /opt/jboss-eap-7.1.0.zip \
 &&   $EAP_HOME/bin/add-user.sh -u admin -p $ADMIN_PASSWORD \
 &&   chown -R jboss $EAP_HOME
WORKDIR $EAP_HOME
USER 1001
EXPOSE 8080 9990
CMD [ "bin/standalone.sh","-Djboss.bind.address=0.0.0.0","-Djboss.bind.address.management=0.0.0.0" ]
