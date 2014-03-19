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

