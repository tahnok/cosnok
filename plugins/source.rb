class Hello
  include Cinch::Plugin

  match "source"

  def execute(m)
    m.reply "https://github.com/tahnok/cosnok"
  end

  def help
    "source - get a link to the source code"
  end

end
