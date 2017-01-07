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

    it "says nothing is url is on blacklist" do
      @plugin.execute(@msg, "https://github.com/uOttawa-Makerspace/MakerSpaceRepo")
    end
  end
end
