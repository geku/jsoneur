module Jsoneur
  class Service

    attr_accessor :path, :default_params

    def initialize(name, base_url, &block)
      @name     = name
      @base_url = base_url
      @faraday  = Faraday.new(@base_url)
      @faraday_configured = false
      block.call(self)

      set_faraday_defaults unless @faraday_configured
    end

    def default_params
      @default_params || {}
    end

    def connection(&block)
      block.call(@faraday)
      @faraday_configured = true
    end

    def set_faraday_defaults
      @faraday.adapter Faraday.default_adapter
      @faraday.request :json
      @faraday.response :mashify
      @faraday.response :json, :content_type => /\bjson$/
    end

    def get(params = {})
      result = @faraday.get(path, default_params.merge(params))
      # TODO how to do error handling?
      result.body
    end

  end
end