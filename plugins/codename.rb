class Codename
  include Cinch::Plugin

  match "codename"

  def execute(m)
    m.reply make_codename
  end

  def make_codename
    "#{prefix}#{random_nsa}#{random_nsa}"
  end

  def prefix
    if Random.rand > 0.3
      ""
    else
      random_colour + " "
    end
  end

  def random_colour
    random_line("data/colours")
  end

  def random_nsa
    random_line("data/nsa")
  end

  def random_adverb
    random_line("data/adverbs")
  end

  def random_adjective
    random_line("data/adjectives")
  end

  def random_noun
    random_line("data/nouns")
  end

  def random_line(path)
    File.readlines(path).sample.chomp.upcase
  end

end
