require 'open_graph_reader'
require 'twitter'

class Links
  include Cinch::Plugin

  attr_writer :twitter_client

  set :prefix, //

  PATTERN = %r{(https?://[\S]+)}

  match PATTERN

  BLACKLIST = [
    'github.com',
    'imgur.com',
    'media.giphy.com',
  ]

  def execute(m, url)
    return if blacklisted?(url)

    if tweet?(url)
      m.reply formatted_tweet(url)
    else
      page = OpenGraphReader.fetch(url)
      return unless page

      m.reply "[\"#{page.og.title}\"]"
    end
  end

  def tweet?(url)
    url =~ /https?:\/\/twitter.com\/[^ \/]+\/status\/(\d+)/
  end

  def formatted_tweet(url)
    id = /https?:\/\/twitter.com\/[^ \/]+\/status\/(\d+)/.match(url)[1]
    status = twitter_client.status(id)
    "[\"#{status.text.gsub(/\n/, ' \n ')}\" @#{status.user.screen_name}]"
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_consumer_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_token_secret"]
    end
  end


  def blacklisted?(url)
    host = URI.parse(url).host
    BLACKLIST.include?(host)
  end

  def help
    "links - post summary of links"
  end

end
