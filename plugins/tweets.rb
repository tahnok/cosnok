require "twitter"

class Tweets
  include Cinch::Plugin
  set :prefix, //

  match /https?:\/\/twitter.com\/[^ \/]+\/status\/(\d+)/

  def execute(m,id)
    status = twitter.status(id)
    m.reply "[\"#{status.text.join('\n ')}\" @#{status.user.screen_name}]"
  end

  def help
    "tweets - auto post tweets"
  end

  def twitter
    @@twitter ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_consumer_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_token_secret"]
    end
  end

end
