require 'open_graph_reader'

class Links
  include Cinch::Plugin
  set :prefix, //

  PATTERN = %r{(https?://[\S]+)}

  match PATTERN

  def execute(m, url)
    page = OpenGraphReader.fetch(url)
    return unless page
    m.reply "[\"#{page.og.title}\"]"
  end

  def help
    "links - post summary of links"
  end

end
