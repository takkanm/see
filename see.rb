#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'httparty'
require 'pit'
require 'optparse'

class Twitter
  include HTTParty
  base_uri 'twitter.com'
  config = Pit.get("twitter", :require => {
    "user_id"  => "required id",
    "password" => "required password"
  })
  basic_auth *config.values_at("user_id", "password")
  format :xml
end

msg = ""
pupil ="◯"
ARGV.options do |opt|
  opt.on('-m msg') {|m| msg << m }
  opt.on('-g') {|b| msg << "ｺﾞｺﾞｺﾞ" }
  opt.on('-o') {|b| msg << "おはよう" }
  opt.on('-c') {|b| pupil = "・" }

  opt.parse!
end

eye = (["<#{pupil}>"]*2).join(" ")

see = ARGV.map {|arg| "@#{arg}" }.join(" ") + " #{eye} #{msg}"
Twitter.post('/statuses/update.xml', :query => {:status => see})
