# DOCKER-VERSION 0.8.1

FROM ubuntu:12.04

ENV DEBIAN_FRONTEND noninteractive

ADD ./lib/apt/sources.list /etc/apt/sources.list

ADD http://ftp.uk.debian.org/debian/pool/main/t/tzdata/tzdata_2014e-0wheezy1_all.deb /tmp/tzdata_2013i-0wheezy1_all.deb
ADD http://ftp.uk.debian.org/debian/pool/main/t/tzdata/tzdata-java_2014a-0wheezy1_all.deb   /tmp/tzdata-java_2013i-0wheezy1_all.deb

RUN apt-get update -y; apt-get upgrade -y
RUN dpkg -i /tmp/tzdata_2013i-0wheezy1_all.deb
RUN dpkg -i /tmp/tzdata-java_2013i-0wheezy1_all.deb
RUN apt-get install -y curl openjdk-7-jre-headless supervisor pwgen

ADD ./lib/craftbukkit.jar /usr/local/etc/minecraft/craftbukkit.jar
ADD ./lib/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./lib/supervisor/conf.d/minecraft.conf /etc/supervisor/conf.d/minecraft.conf
ADD ./lib/minecraft/opts.txt /usr/local/etc/minecraft/opts.txt
ADD ./lib/minecraft/white-list.txt /usr/local/etc/minecraft/white-list.txt
ADD ./lib/minecraft/server.properties /usr/local/etc/minecraft/server.properties
ADD http://jruby.org.s3.amazonaws.com/downloads/1.7.12/jruby-complete-1.7.12.jar /usr/local/etc/minecraft/jruby-complete.jar
ADD http://dev.bukkit.org/media/files/765/560/purugin-0.7.1-bukkit-1.7.2-R0.2.jar /usr/local/etc/minecraft/plugins/purugin.jar

ADD ./lib/scripts/start /start
ENV GEM_HOME ./gems

RUN chmod +x /start

EXPOSE 25565
VOLUME ["/data"]
CMD ["/start"]
