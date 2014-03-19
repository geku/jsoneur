require 'rubygems'
require 'bundler/setup'

require './jsoneur/registry'
require 'awesome_print'

reg = Jsoneur::Registry.new
reg.add('github_user_repos', 'https://api.github.com') do |service|
  service.path = '/users/defunkt/repos'
end

#   # todo allow parameters in URL
#   # todo error handling, e.g. 404 with callbacks
#   service.path   = 
#   service.default_params = {one: 'two'}
#   service.connection do |conn|
#     conn.request :json
#     #...
#   end
# end
# Registry.get('github_user_repos', params = {})

repos = reg.get('github_user_repos')
# ap repos

# repos.each do |r|
#   puts ""
#   puts "Name:  #{r.name}"
#   puts "Owner: #{r.owner.login}"
#   puts "Desc:  #{r.description}"
#   puts "Lang:  #{r.language}"
#   puts "=============================================="
# end
