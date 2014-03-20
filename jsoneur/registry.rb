require 'faraday'
require 'faraday_middleware'

require './jsoneur/service'

module Jsoneur
  class Registry
    class << self

      def services
        @services ||= {}
      end

      def add(name, base_url, &block)
        services[name] = Service.new(name, base_url, &block)
      end

      def [](service_name)
        services[service_name]
      end

    end
  end
end

