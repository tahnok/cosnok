require 'open_graph_reader'

class Links
  include Cinch::Plugin
  set :prefix, //

  PATTERN = %r{(https?://[\S]+)}

  match PATTERN

  BLACKLIST = [
    'github.com',
  ]

  def execute(m, url)
    return if blacklisted?(url)
    page = OpenGraphReader.fetch(url)
    return unless page
    m.reply "[\"#{page.og.title}\"]"
  end

  def blacklisted?(url)
    host = URI.parse(url).host
    BLACKLIST.include?(host)
  end

  def help
    "links - post summary of links"
  end

end
