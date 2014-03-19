require 'rubygems'
require 'bundler/setup'

require './jsoneur/registry'
require 'awesome_print'

puts "wrong parameters" && exit if ARGV.size != 1

reg = Jsoneur::Registry.new
reg.add('github_user_repos', 'https://api.github.com') do |service|
  service.path = '/users/%{user}/repos'
end

repos = reg['github_user_repos'].get(user: ARGV.first)

repos.each do |r|
  puts ""
  puts "Name:  #{r.name}"
  puts "Owner: #{r.owner.login}"
  puts "Desc:  #{r.description}"
  puts "Lang:  #{r.language}"
  puts "=============================================="
end
