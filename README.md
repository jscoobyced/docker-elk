## Docker ELK stack

This stack consists of:
- 1 redis node
- 1 filebeat instance
- 1 logstash instance
- 3 Elastic Search nodes
- 1 Grafana instance

**Note this will download about 6GB of docker images.**

# Setup nginx instance

Edit your nginx instance:
1. Create a `/etc/nginx/conf.d/logs.conf` file with content:
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
2. Update your `access_log` to be
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