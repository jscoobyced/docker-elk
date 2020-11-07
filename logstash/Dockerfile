FROM docker.elastic.co/logstash/logstash:7.9.3
COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf

USER root
RUN chown logstash:root /usr/share/logstash/pipeline/logstash.conf
RUN echo "http.host: \"127.0.0.1\"" > /usr/share/logstash/config/logstash.yml

USER logstash