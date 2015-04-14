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
    when 20
      "If karma was worth anything, you'd be doing great! Congrats on reaching the FLEDGLING JOKE CRAFTER rung"
    when 42
      "Weren't expecting a new rung now were you?! SUPRISE! You are now a JUNIOR FUNTIME JUNIOR"
    when 50
      "Halfway to a 100! I bet that feels good. You are hereby awarded the SEMI SERIOUS KARMA PERSON"
    when 100
      "100! that is more 0 karma by a lot! the coveted AMUSING IRC DENIZEN rung is yours!"
    when 200
      "200 TWICE AS OK AS 100! Are you enjoying the dizzying heights of the WEB MASTER IN TRAINING rung?"
    when 250
      "WOW! GOLLY GEE! LOOK AT YOU REACHING THE bit twiddler extraordinaire!"
    when 300
      "unreal heir"
    when 500
      "shiet! You are going to need a godhood! I really doubted anybody would get here"
    else
      return
    end
  end

  def help
    "karmecheladder - a homestuck joke"
  end

end
