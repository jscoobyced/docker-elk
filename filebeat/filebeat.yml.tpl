filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/nginx/access_json.log
  json.keys_under_root: true
  json.overwrite_keys: true
  json.add_error_key: true

# filebeat modules 
filebeat.config.modules:
  # remove the escape character before the wildcard below
  path: ${path.config}/modules.d/\*.yml
  reload.enabled: false

# elasticsearch template settings
setup.template.settings:
  index.number_of_shards: 3

# redis output
output.redis:
  hosts: ["redis:6379"]
  password: "PASSPASSPASS"
  key: "nginx_logs"
  db: 0
  timeout: 5