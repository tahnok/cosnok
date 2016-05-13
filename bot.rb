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
    c.server = "127.0.0.1"
    c.channels = ["#tildetown", "bots"]
    c.nick = botname
    c.plugins.plugins = plugins_to_load
    c.plugins.prefix = /^#{botname}_*\:? ?/
  end

  on :connect do |m|
    User('nickserv').send("identify #{botname} #{ENV['NICKSERV_PASS']}")
  end

end

bot.start
