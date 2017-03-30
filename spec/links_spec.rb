require 'spec_helper'
require 'cinch'
require './plugins/links.rb'
require 'pry'

RSpec.describe Links do
  before do
    @plugin = Links.new(Cinch::Bot.new{ self.loggers.clear })
  end

  context "help" do
    it "has a help message" do
      expect(@plugin).to respond_to(:help)
    end
  end

  context "matching" do
    before do
      @pattern = Links::PATTERN
    end

    it "matches https links" do
      expect(@pattern.match("https://foo.com")).to be_truthy
    end

    it "matches http links" do
      expect(@pattern.match("http://foo.com")).to be_truthy
    end

    it "doesn't match normal text" do
      expect(@pattern.match("foo.com")).to be_nil
    end

    it "matches links inside text" do
      expect(@pattern.match("this is some text https://link.url end bits")).to be_truthy
    end

    it "extracts the link" do
      capture = @pattern.match("this https://this.link stuff")[0]
      expect(capture).to eq("https://this.link")
    end
  end

  context "execute", :vcr do

    before do
      @msg = double("msg")
    end

    it "return title if og:title" do
      expect(@msg).to receive(:reply).with("[\"Open Graph protocol\"]")
      @plugin.execute(@msg, "http://ogp.me/")
    end

    it "says nothing if url has no title" do
      @plugin.execute(@msg, "http://tahnok.me/")
    end

    it "says nothing if for github" do
      @plugin.execute(@msg, "https://github.com/uOttawa-Makerspace/MakerSpaceRepo")
    end

    it "says nothing if for imgur" do
      @plugin.execute(@msg, "https://imgur.com/a/s8pi2")
    end

    it "says nothing for giphy" do
      @plugin.execute(@msg, "https://media.giphy.com/media/10LKovKon8DENq/giphy.gif")
    end

    it "expands tweets" do
      tweet = double("tweet", text: "Current status: listening to lots of weirdddd radio protocols: https://t.co/Ry8mAUDRom", user: double("twitter user", screen_name: "tahnok"))
      twitter_client = double("twitter_client")
      allow(twitter_client).to receive(:status) { tweet }
      @plugin.twitter_client = twitter_client

      expect(@msg).to receive(:reply).with("[\"Current status: listening to lots of weirdddd radio protocols: https://t.co/Ry8mAUDRom\" @tahnok]")

      @plugin.execute(@msg, "https://twitter.com/tahnok/status/803049967053078528")
    end
  end
end
