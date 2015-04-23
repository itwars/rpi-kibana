# Pull base image.
#FROM resin/rpi-raspbian:wheezy
FROM itwars/rpi-elacticsearch151
MAINTAINER Vincent RABAH <vincent.rabah@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN \
  	apt-get update && \
  	apt-get -y dist-upgrade && \
  	apt-get install -y wget && \
	mkdir -p /kibana && \
	wget --no-check-certificate -O - https://download.elasticsearch.org/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz \
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
#	sed -i.bak s/0.0.0.0/1.1.1.1/g /kibana/config/kibana.yml

WORKDIR /kibana

CMD ["/kibana/bin/kibana"]

EXPOSE 5601
