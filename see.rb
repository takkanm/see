#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'httparty'
require 'pit'

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

see = ARGV.map {|arg| "@#{arg}" }.join(" ") + " <〇> <〇>"
Twitter.post('/statuses/update.xml', :query => {:status => see})
