require 'cinch'

# CONFIG
#
botname = 'cosnok'

plugins_to_load = []

Dir['plugins/*.rb'].each do |plugin|
  load plugin
  plugins_to_load << Object.const_get(File.basename(plugin, '.rb').capitalize)
end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#mcgill"]
    c.nick = botname
    c.plugins.plugins = plugins_to_load
    c.plugins.prefix = /^#{botname}\:? ?/
  end

end

bot.start
