require 'rubygems'
require 'bundler/setup'
require 'jsoneur'

#
# Jsoneur example to list all public
# Github repos of a certain user
#

if ARGV.size < 1
  puts "\n!!! Wrong number of parameters\n\n"
  puts "ruby github.rb <username>"
  exit
end

Jsoneur.add('github_user_repos', 'https://api.github.com') do |service|
  service.path = '/users/%{user}/repos'
end

repos = Jsoneur['github_user_repos'].get(user: ARGV.first)
repos.each do |r|
  puts "  Name:  #{r.name}"
  puts "  Owner: #{r.owner.login}"
  puts "  Desc:  #{r.description}"
  puts "  Lang:  #{r.language}"
  puts ""
  puts "=============================================="
  puts ""
end
