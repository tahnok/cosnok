require 'opengraph_parser'

class Links
  include Cinch::Plugin
  set :prefix, //

  PATTERN = %r{(https?://[\S]+)}

  match PATTERN

  def execute(m, url)
    page = OpenGraph.new("http://ogp.me")
    m.reply "[\"#{page.title}\"]"
  end

  def help
    "links - post summary of links"
  end

end
