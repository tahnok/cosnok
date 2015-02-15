require 'cinch'

plugins_to_load = []

Dir['plugins/*.rb'].each do |plugin|
  load plugin
  plugins_to_load << Object.const_get(File.basename(plugin, '.rb').capitalize)
end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#mctest"]
    c.nick = 'cosnok'
    c.plugins.plugins = plugins_to_load
    c.plugins.prefix = /^\$/
  end
end

bot.start
