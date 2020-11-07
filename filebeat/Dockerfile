FROM docker.elastic.co/beats/filebeat:7.9.3

USER root
COPY filebeat.yml /usr/share/filebeat/filebeat.yml
RUN mkdir -p /var/log/nginx
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
RUN chmod go-w /usr/share/filebeat/filebeat.yml

USER filebeat

VOLUME [ "/var/log/nginx" ]