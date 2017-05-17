FROM ubuntu:14.04
MAINTAINER Samuel Warkentin <s.warkentin@mittwald.de>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python python-pip git
RUN pip install PyYAML tornado --upgrade
#RUN git clone git://github.com/josh-berry/cronitor.git /opt/cronitor
RUN mkdir -p /var/log/cronitor
RUN mkdir -p /etc/cronitor

RUN sudo groupadd -r cronitor
RUN sudo useradd -r -s /usr/sbin/nologin -g cronitor \
               -d /opt/cronitor cronitor
RUN chmod u=rwx,go= /var/log/cronitor
RUN sudo chown cronitor:cronitor /var/log/cronitor

ADD server.yaml /etc/cronitor/server.yaml
ADD rules.yaml  /etc/cronitor/rules.yaml

ENV TZ=Europe/Berlin
RUN echo $TZ | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

CMD /opt/cronitor/cronitor-server -c /etc/cronitor/server.yaml
