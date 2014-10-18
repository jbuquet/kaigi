redis_uri = URI.parse(ENV["REDISGREEN_URL"])

Rails.application.config.middleware.delete Rack::Lock
Rails.application.config.middleware.use FayeRails::Middleware, mount: '/socket', :timeout => 25,
                      :engine  => { :type     => Faye::Redis,
                                    :host     => redis_uri.host,
                                    :port     => redis_uri.port,
                                    :password => redis_uri.password }
