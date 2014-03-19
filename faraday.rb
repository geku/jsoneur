require 'rubygems'
require 'bundler/setup'

require 'faraday'
require 'faraday_middleware'
require 'awesome_print'


conn = Faraday.new 'https://api.github.com' do |conn|
  conn.adapter Faraday.default_adapter

  conn.request :json

  conn.response :mashify
  conn.response :json, :content_type => /\bjson$/
end

res = conn.get('/users/defunkt/repos')
repos = res.body

repos.each do |r|
  puts ""
  puts "Name:  #{r.name}"
  puts "Owner: #{r.owner.login}"
  puts "Desc:  #{r.description}"
  puts "Lang:  #{r.language}"
  puts "=============================================="
end
