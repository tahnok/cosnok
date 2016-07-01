class Rollcall
  include Cinch::Plugin

  set :prefix, //
  match "!rollcall"

  def execute(m)
    m.reply "OHAI! say cosnok: help for a complete list of commands"
  end

  def help
    "rollcall - respond to !rollcall"
  end

end
