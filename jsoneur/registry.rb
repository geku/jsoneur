require 'faraday'
require 'faraday_middleware'

require './jsoneur/service'

module Jsoneur
  class Registry

    attr_reader :services

    def initialize
      @services = {}
    end

    def add(name, base_url, &block)
      services[name] = Service.new(name, base_url, &block)
    end

    def default_faraday_settings(faraday)
      faraday.adapter(Faraday.default_adapter)
      faraday.request :json
      faraday.response :mashify
      faraday.response :json, :content_type => /\bjson$/
    end

    def [](service_name)
      services[service_name]
    end

  end
end



#
# USAGE
#
# Registry.add('github_user_repos', 'https://api.github.com') do |service|
#   # todo allow parameters in URL
#   # todo error handling, e.g. 404 with callbacks
#   service.path   = '/users/defunkt/repos'
#   service.default_params = {one: 'two'}
#   service.connection do |conn|
#     conn.request :json
#     #...
#   end
# end


# Registry.get('github_user_repos', params = {})



