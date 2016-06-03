require 'wolfram-alpha'

class Dice
  include Cinch::Plugin


  match /wolfram (.*)/

  def execute(m,query)
    response = client.query(query)
    result = response["Result"].subpods[0].plaintext
    m.reply(result)
  end

  def help
    "query wolfram alpha"
  end

  def client
    @@client ||= WolframAlpha::Client.new(ENV["WOLFRAM_KEY"], { "format" => "plaintext" })
  end

end
