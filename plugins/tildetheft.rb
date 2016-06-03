class Tildetheft
  include Cinch::Plugin

  match "(.*)"

  def execute(m, message)
    return unless m.user.nick == "tildebot"

    return unless message =~ /: ([^:]*\?) \(/

    response = client.query($1)
    result = response["Result"].subpods[0].plaintext
    m.reply(result)
  end

  def help
    "hello - get hello"
  end

  def client
    @@client ||= WolframAlpha::Client.new(ENV["WOLFRAM_KEY"], { "format" => "plaintext" })
  end

end
