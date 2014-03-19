require 'open-uri'

module Jsoneur
  class Service

    attr_accessor :path, :default_params

    def initialize(name, base_url, &block)
      @name     = name
      @base_url = base_url

      block.call(self)

      if @faraday.nil?
        @faraday  = Faraday.new(@base_url) do |f|
          set_faraday_defaults(f)
        end
      end
    end

    def default_params
      @default_params || {}
    end

    def connection(&block)
      @faraday  = Faraday.new(@base_url, &block)
    end

    def set_faraday_defaults(faraday)
      faraday.adapter Faraday.default_adapter
      faraday.request :json
      faraday.response :mashify
      faraday.response :json, :content_type => /\bjson$/
    end

    def get(params = {})
      final_path = path % urlencoded_params(params)
      result = @faraday.get(final_path, default_params.merge(params))
      # TODO how to do error handling?
      result.body
    end


    private
      def urlencoded_params(params)
        safe_params = params.dup
        safe_params.each do |key, value|
          safe_params[key] = URI::encode(value)
        end
      end

  end
end