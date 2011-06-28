# coding: utf-8
require "spec_helper"

describe Tweet do
  context "本文ありでつぶやく" do
    before do
      @tw = Tweet.new(:body => "Hello, world!!")
    end
    it "本文がセットされている" do
      @tw.body.should == "Hello, world!!"
    end
    it "validである" do
      @tw.should be_valid
    end
  end
  context "本文なしでつぶやく" do
    before do
      @tw = Tweet.new
    end
    it "invalidである" do
      @tw.should_not be_valid
    end
  end
end
