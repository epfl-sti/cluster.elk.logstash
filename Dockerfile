# http://marceldegraaf.net/2014/05/05/coreos-follow-up-sinatra-logstash-elasticsearch-kibana.html
# Marcel de Graaf <mail@marceldegraaf.net>

FROM ubuntu:14.04
MAINTAINER Nicolas Borboën <nicolas.borboen@epfl.ch>

# Install Java
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes default-jre-headless wget curl

# Install confd
# https://github.com/kelseyhightower/confd/releases
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -O confd
RUN mv confd /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

# Create directories
RUN mkdir -p /opt/logstash/ssl
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Install Logstash
RUN wget https://download.elastic.co/logstash/logstash/logstash-1.5.4.tar.gz -O /tmp/logstash-1.5.4.tar.gz
RUN tar xfz /tmp/logstash-1.5.4.tar.gz -C /opt/logstash --strip-components=1

# Add files
ADD ./confd                   /etc/confd
ADD ./bin/boot.sh             /boot.sh

# Start the container
RUN chmod +x /boot.sh
CMD /boot.sh
