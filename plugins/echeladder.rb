class Echeladder
  include Cinch::Plugin

  match /(\w+)'s karma is now (\d+)/

  def execute(m, user, karma)
    m.reply case karma.to_i
    when 10
      "CRAZY TYKE"
    else
      "butts"
    end
  end

  def self.help
    "echeladder - track your karma progress!"
  end

end
