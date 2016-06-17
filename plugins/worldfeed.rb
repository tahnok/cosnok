require 'rss'

class Worldfeed
  include Cinch::Plugin

  timer 5 * 60, method: :poll

  def initialize(*args)
    super
    @last_poll = Time.now
  end

  def poll
    feed = RSS::Parser.parse("https://tilde.town/\~nju/worldfeed/feed.atom")
    debug "last poll #{@last_poll}"
    if feed.updated.content > @last_poll
      feed.items.select{|f| f.updated.content > @last_poll}.each do |f|
        title = f.title.content
        Channel("#worldfeed").send(title)
      end
    end
    @last_poll = feed.updated.content
  end


  def help
    "worldfeed - I periodically post new contents in #worldfeed"
  end

end
