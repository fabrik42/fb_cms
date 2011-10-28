require 'spec_helper'

describe Text do

  describe "linkify" do
    it "replaces an url in a string with a link" do
      linkify("hi http://google.com ho").should eql("hi <a href=\"http://google.com\">http://google.com</a> ho")
    end

    it "replaces an url without protocol in a string with a link" do
      linkify("hi www.google.com ho").should eql("hi <a href=\"http://www.google.com\">www.google.com</a> ho")
    end

    it "replaces nothing in a string without a url" do
      linkify("hi google ho").should eql("hi google ho")
    end
  end

  describe "simple_format" do
    it "wraps the given text in a paragrah" do
      simple_format("hi").should eql("<p class=\"\">hi</p>")
    end

    it "adds a given class attribute to the paragraph" do
      simple_format("hi", :class => "greeting").should eql("<p class=\"greeting\">hi</p>")
    end

    it "adds a given class attribute to the paragraph" do
      simple_format("hi", :class => "greeting").should eql("<p class=\"greeting\">hi</p>")
    end

    it "inserts a br tag for a new line" do
      text = <<-eos
        Line 1
        Line 2
      eos
      text.gsub!(/ +/, ' ')

      simple_format(text).should eql("<p class=\"\"> Line 1\n<br /> Line 2\n</p>")
    end

    it "starts a new paragraph at 2 new lines" do
      text = <<-eos
        Paragraph 1

        Paragraph 2
      eos
      text.gsub!(/ +/, ' ')

      simple_format(text).should eql("<p class=\"\"> Paragraph 1</p>\n\n<p class=\"\"> Paragraph 2\n</p>")
    end
  end

  describe "nl2br" do
    it "adds br tags after new lines" do
      text = "This\nis a\ntest\n"
      nl2br(text).should eql("This\n<br />is a\n<br />test\n")
    end
  end
end