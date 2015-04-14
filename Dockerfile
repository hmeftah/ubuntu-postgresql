# dockerfile for postgresql as production-like server
FROM       ubuntu:latest
MAINTAINER Herve Meftah "rv.meftah@gmail.com"

RUN apt-get update

RUN apt-get -y install coreutils
RUN apt-get -y install build-essential
RUN apt-get -y install python-dev
RUN apt-get -y install python-pip
RUN apt-get -y install systemtap-sdt-dev
RUN apt-get -y install libreadline6-dev
RUN apt-get -y install libzlcore-dev
RUN apt-get -y install libssl-dev

RUN pip install fabric

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:password' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
