FROM ubuntu:14.04
MAINTAINER Samuel Warkentin <s.warkentin@mittwald.de>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python python-pip git
RUN pip install PyYAML tornado --upgrade

RUN sudo groupadd -r cronitor
RUN sudo useradd -r -s /usr/sbin/nologin -g cronitor \
               -d /opt/cronitor cronitor

ENV TZ=Europe/Berlin
RUN echo $TZ | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

CMD /opt/cronitor/cronitor-server -c /opt/cronitor/server.yaml
