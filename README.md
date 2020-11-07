## Docker ELK stack

This stack consists of:
- 1 nginx server (for demo purpose, should be removed)
- 1 redis node
- 1 filebeat instance
- 1 logstash instance
- 3 Elastic Search nodes
- 1 Grafana instance

Example to popular the logs:
- Populate the logs: open http://localhost:8080/ multiple times
- Open http://localhost:9200/_cat/indices/*?v&s=index to capture the index name
- Open http://localhost:9200/logstash-nginx-sysadmins-2020.11.07/_search to confirm the logs are getting there
