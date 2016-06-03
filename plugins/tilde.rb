class Tilde
  include Cinch::Plugin

  match "tilde"

  def execute(m)
    m.reply "!tilde"
  end

  def help
    "hello - get hello"
  end

end
