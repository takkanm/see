#! /bin/env ruby
require 'rubygems'
require 'httparty'
require 'pit'

class Twitter
	include HTTParty
	base_uri 'twitter.com'
	config = Pit.get("twitter", :require => {
					"user_id" => "required id",
					"password" => "required password"})
	basic_auth config["user_id"], config["password"]
	format :xml
end

see = ARGV.map{|arg| "@#{arg}"}.join(" ")
see << " <〇> <〇>"
Twitter.post('/statuses/update.xml', :query => {:status => see})
