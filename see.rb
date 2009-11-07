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
ARGV.options do |opt|
  opt.on('-m msg') {|m| msg << m }
  opt.on('-g') {|b| msg << "ｺﾞｺﾞｺﾞ" }
  opt.on('-o') {|b| msg << "おはよう" }

  opt.parse!
end

see = ARGV.map {|arg| "@#{arg}" }.join(" ") + " <〇> <〇> #{msg}"
Twitter.post('/statuses/update.xml', :query => {:status => see})
