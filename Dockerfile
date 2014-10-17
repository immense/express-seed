# DOCKER-VERSION 1.3.0

FROM centos:centos6

# Enable EPEL for Node.js
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

RUN touch /etc/yum.repos.d/mongo.repo && \
    echo "[mongodb]" > /etc/yum.repos.d/mongo.repo && \
    echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongo.repo && \
    echo "baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/" >> /etc/yum.repos.d/mongo.repo && \
    echo "gpgcheck=0" >> /etc/yum.repos.d/mongo.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/mongo.repo

# Install Node.js and npm
RUN yum install -y npm git mongodb-org

RUN service mongod start

RUN npm install -g coffee-script grunt-cli bower

ADD . /src

WORKDIR /src

EXPOSE 3002

RUN npm install
RUN bower --allow-root install
