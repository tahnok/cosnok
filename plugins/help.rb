class Help
  include Cinch::Plugin

  match /h[ae]lp(?:\s+(\w+))?/

  def execute(m,command)
    if command.nil?
      command_names = bot.plugins.map do |plugin|
        plugin.class.name.downcase
      end
      m.reply "available commands: #{command_names.join(", ")}"
    else
      plugin = bot.plugins.first do |plugin| 
        plugin.class.name.downcase == command
      end

      unless plugin.nil?
        m.reply plugin.help 
      else
        m.reply "Command not found."
      end
    end
  end

  def help
    "help [command] - get help"
  end
end
