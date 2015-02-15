require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#mctest"]
    c.nick = 'cosnok'
  end

  on :message, "hello" do |m|
    m.reply "Hello, #{m.user.nick}"
  end
end

bot.start
