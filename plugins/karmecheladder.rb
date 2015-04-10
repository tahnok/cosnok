class Karmecheladder
  include Cinch::Plugin

  set :prefix, //

  match /(\w+)'s karma is now (\d+)/

  def execute(m, user, karma)
    return unless m.user.nick == "Nethaera"
    m.reply case karma.to_i
    when 1
      "wow! your first karma! it's so shinny and useful! you climb the ladder to the GREENTIKE rung!"
    when 10
      "quite a chunk of karma you've got there! you now perch atop the mildly respectable KNEEHIGH RASCALLY SCALLYWAG"
    when 100
      "100! that is more 0 karma by a lot! the coveted AMUSING IRC DENIZEN rung is yours!"
    when 300
      "unreal heir"
    when 500
      "shiet! You are going to need a godhood"
    else
      return
    end
  end

  def help
    "karmecheladder - a homestuck joke"
  end

end
