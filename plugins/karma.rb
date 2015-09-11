require 'redis'

class Karma
  include Cinch::Plugin

  set :prefix, //

  match /(\w+)(\+\+|\-\-)/

  def execute(m, user, direction)
    redis = Redis.new(url: ENV['REDIS_URL'])
    return unless track_karma?(redis, m, user)
    karma = redis.get("karma:#{user}").to_i || 0
    if direction == "++"
      karma = karma + 1
    else
      karma = karma - 1
    end
    redis.sadd("nicks:#{m.channel.name}", user)
    redis.set("karma:#{user}", karma)
  end

  def help
    "karma - in beta"
  end

  def track_karma?(redis, m, user)
    m.user.nick != user && (m.channel.users.keys.include?(user) || redis.sismember("nicks:#{m.channel.name}", user))
  end


end
