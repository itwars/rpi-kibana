# Pull base image.
FROM resin/rpi-raspbian
MAINTAINER Vincent RABAH <vincent.rabah@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN \
  	apt-get update && \
  	apt-get -y dist-upgrade && \
  	apt-get install -y wget curl && \
	mkdir -p /kibana && \
	wget --no-check-certificate -O - https://download.elasticsearch.org/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz \
	| tar xzf - --strip-components=1 -C "/kibana" && \
	wget http://node-arm.herokuapp.com/node_latest_armhf.deb && \
	dpkg -i node_latest_armhf.deb && \
	rm /kibana/node/bin/node && \
	rm /kibana/node/bin/npm && \
	ln -s /usr/local/bin/node /kibana/node/bin/node && \
	ln -s /usr/local/bin/npm /kibana/node/bin/npm && \
	apt-get remove -y wget && \
	apt-get clean -y && \
	apt-get autoclean -y && \
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ADD config/kibana.yml /kibana/config/kibana.yml
ADD config/run.sh /run.sh

RUN chmod +x /run.sh

EXPOSE 5601

#CMD ["/kibana/bin/kibana","-c", "/kibana/config/kibana.yml"]

ENTRYPOINT /run.sh

