input {
  redis {
    data_type =>"list"
    key =>"nginx_logs"
    host =>"redis"
    port => 6379
    password => "PASSPASSPASS"
    db => 0
  }
}

filter {
  geoip {
    target => "geoip"
    source => "client_ip"
    database => "/usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/logstash-filter-geoip-6.0.3-java/vendor/GeoLite2-City.mmdb"
    add_field => [ "[geoip][coordinates]", "%{[geoip][longitude]}" ]
    add_field => [ "[geoip][coordinates]", "%{[geoip][latitude]}" ]
    remove_field => ["[geoip][latitude]", "[geoip][longitude]", "[geoip][country_code]", "[geoip][country_code2]", "[geoip][country_code3]", "[geoip][timezone]", "[geoip][continent_code]", "[geoip][region_code]"]
  }
  mutate {
    convert => [ "size", "integer" ]
    convert => [ "status", "integer" ]
    convert => [ "responsetime", "float" ]
    convert => [ "upstreamtime", "float" ]
    convert => [ "[geoip][coordinates]", "float" ]
    remove_field => [ "ecs","agent","host","cloud","@version","input","logs_type" ]
  }
  useragent {
    source => "http_user_agent"
    target => "ua"
    remove_field => [ "[ua][minor]","[ua][major]","[ua][build]","[ua][patch]","[ua][os_minor]","[ua][os_major]" ]
  }
}
output {
  elasticsearch {
    hosts => ["es01", "es02", "es03"]
    #user => "myusername"
    #password => "mypassword"
    index => "logstash-nginx-sysadmins-%{+YYYY.MM.dd}"
  }
}