# frozen_string_literal: true

$redis = Redis::Namespace.new('chat_app', redis: Redis.new)
