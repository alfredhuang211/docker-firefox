FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	firefox \
	firefox-locale-zh-hans \
	fonts-wqy-zenhei fonts-wqy-microhei \
	language-pack-zh-hans \
	vnc4server \
	matchbox-window-manager


ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN locale-gen zh_CN.UTF-8 &&  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN locale-gen zh_CN.UTF-8  
ENV LANG zh_CN.UTF-8  
ENV LANGUAGE zh_CN:zh  
ENV LC_ALL zh_CN.UTF-8  

RUN mkdir /root/.vnc
COPY vnc/xstartup /root/.vnc/xstartup
COPY vnc/passwd /root/.vnc/passwd
RUN chmod +x /root/.vnc/xstartup

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh

COPY fonts /usr/share/fonts/

RUN apt-get install -y --no-install-recommends scim scim-pinyin

COPY config /etc/scim/config

EXPOSE 5901

WORKDIR /root

CMD /root/run.sh
