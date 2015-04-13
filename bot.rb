require 'cinch'
require "cinch/plugins/identify"

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
    c.server = "irc.freenode.net"
    c.channels = ["#mcgill"]
    c.nick = botname
    c.plugins.plugins = plugins_to_load << Cinch::Plugins::Identify
    c.plugins.prefix = /^#{botname}\:? ?/
    c.plugins.options[Cinch::Plugins::Identify] = {
      username: botname,
      password: ENV['NICKSERV_PASS'],
      type:     :nickserv,
    }
  end

end

bot.start
