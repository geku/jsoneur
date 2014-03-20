require 'open-uri'

module Jsoneur
  class Service

    # Config methods
    attr_accessor :path, :default_params, :empty_response

    def initialize(name, base_url, &block)
      @name         = name
      @base_url     = base_url

      # Set default config
      @default_params = {}
      @empty_response = []

      block.call(self)

      if @faraday.nil?
        @faraday  = Faraday.new(@base_url) do |f|
          set_faraday_defaults(f)
        end
      end
    end

    def connection(&block)
      @faraday  = Faraday.new(@base_url, &block)
    end

    def set_faraday_defaults(faraday)
      faraday.request :json

      faraday.response :mashify
      faraday.response :json, :content_type => /\bjson$/
      
      faraday.adapter Faraday.default_adapter
    end

    # Raises (depending on adapter that is used, by default NetHTTP)
    # * Faraday::Error::ConnectionFailed on connection problems
    # * Faraday::Error::TimeoutError     on timeouts
    # e.g. Typhoeus raises Faraday::Error::ClientError as well
    def get(params = {})
      final_path = path % urlencoded_params(params)
      result = @faraday.get(final_path, default_params.merge(params))

      if result && result.success? && result.body
        result.body 
      else
        empty_response
      end
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