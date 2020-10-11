uri = URI.parse(ENV.fetch("REDIS_URL_CACHING", "redis://localhost:6379/0"))
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)