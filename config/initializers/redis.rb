$redis = Redis::Namespace.new("chat_app", :redis => Redis.new)