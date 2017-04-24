FROM centos:7

RUN useradd minecraft -d /home/minecraft

RUN yum -y install wget

RUN wget --quiet --no-cookies --no-check-certificate \
 --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.rpm" \
&& yum -y localinstall jre-8u60-linux-x64.rpm && rm jre-8u60-linux-x64.rpm


WORKDIR /home/minecraft
COPY config config
COPY libraries libraries
COPY logs logs
COPY mods mods
COPY world world
COPY files/* ./
RUN chown -R minecraft:minecraft /home/minecraft

EXPOSE 25565

user minecraft
#install pixelmon

RUN wget --quiet -O /home/minecraft/mods/Pixelmon-1.10.2-5.0.3-universal.jar \
 http://download.nodecdn.net/containers/pixelmon/core/Pixelmon-1.10.2-5.0.3-universal.jar 

RUN wget --quiet -O /home/minecraft/mods/minecraft_server.1.10.2.jar \
 https://s3.amazonaws.com/Minecraft.Download/versions/1.10.2/minecraft_server.1.10.2.jar 

CMD java -jar forge.jar
