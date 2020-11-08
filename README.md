## Docker ELK stack

This stack consists of:
- 1 nginx server (for demo purpose, should be removed)
- 1 redis node
- 1 filebeat instance
- 1 logstash instance
- 3 Elastic Search nodes
- 1 Grafana instance

**Note this will download about 6GB of docker images.**

# Quick start

To test the demo, simply run the `start.sh` script. This will start the whole stack. It will generate a random password for Redis and update relevant configurations to use it.

## Populate the logs
- Populate the logs: open http://localhost:8080/ multiple times
- Open http://localhost:9200/_cat/indices/*?v&s=index to capture the index name
- Open http://localhost:9200/logstash-nginx-sysadmins-2020.11.07/_search to confirm the logs are getting there

# Custom nginx instance

Edit the docker-compose.yml file:
1. Remove the nginx service
2. Remove the nginx volume configuration
3. Add in your nginx system configuration:
```
log_format json_logs '{"@timestamp":"$time_iso8601","host":"$hostname",'
                        '"server_ip":"$server_addr","client_ip":"$remote_addr",'
                        '"xff":"$http_x_forwarded_for","domain":"$host",'
                        '"url":"$uri","referer":"$http_referer",'
                        '"args":"$args","upstreamtime":"$upstream_response_time",'
                        '"responsetime":"$request_time","request_method":"$request_method",'
                        '"status":"$status","size":"$body_bytes_sent",'
                        '"request_body":"$request_body","request_length":"$request_length",'
                        '"protocol":"$server_protocol","upstreamhost":"$upstream_addr",'
                        '"file_dir":"$request_filename","http_user_agent":"$http_user_agent"'
                        '}';
```
This should be located within the `http` configuration in your `nginx.conf` file. It should also work just fine if you put it above your `server` configuration in the specific alias.

4. Update your `access_log` to be
```
access_log  /var/log/nginx/access_json.log  json_logs;
```
5. Update the filebeat service `volumes` configuration to map to your nginx log directory (i.e. `/var/log/nginx`)

Then you can run the `start.sh` script.

# Release Notes

*2020-11-08*

Initial release. Configuration is very basic but works.

# Credits

Based on the work from [Ruan Bekker](https://blog.ruanbekker.com/blog/2020/04/28/nginx-analysis-dashboard-using-grafana-and-elasticsearch/).