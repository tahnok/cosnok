class Tildetheft
  include Cinch::Plugin

  match /(.*)/

  def execute(m, message)
    debug "check if #{m.user.nick} is tildebot"
    return unless m.user.nick == "tildebot"

    debug "check if #{message} matches"
    return unless message =~ /: ([^:]*\?) \(/
    debug "query wolfram for #{$1}"

    response = client.query($1)
    result = response["Result"].subpods[0].plaintext
    m.reply(result)
  end

  def help
    "tildetheft: say cosnok: tilde and I will try to be my sneakiest"
  end

  def client
    @@client ||= WolframAlpha::Client.new(ENV["WOLFRAM_KEY"], { "format" => "plaintext" })
  end

end
