FROM registry.esav.fi:5000/centos

MAINTAINER Esa Varemo <esa@kuivanto.fi>

RUN yum install -y mariadb openssh openssh-clients rsync

ADD backup.sh /backup.sh

VOLUME /root/ # ~/.ssh/id_rsa

CMD /backup.sh
