class Codename
  include Cinch::Plugin

  match "codename"

  def execute(m)
    m.reply make_codename
  end

  def make_codename
    "#{prefix}#{endpart}"
  end

  def endpart
    if Random.rand > 0.5
      "#{random("nsa")} #{random("nsa")}"
    else
      "#{random("adverbs")} #{random("gods")}"
    end
  end

  def prefix
    if Random.rand > 0.3
      ""
    else
      if Random.rand < 0.3
        random("colours") + " "
      else
        random("adjectives") + " "
      end
    end
  end

  def random(thing)
    random_line("data/#{thing}")
  end

  def random_line(path)
    File.readlines(path).sample.chomp.upcase
  end

  def help
    "codename - makes a random codename for a project"
  end

end
