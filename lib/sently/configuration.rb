module Sently
  class Configuration

    OPTIONS = [:username, :password,
               :http_open_timeout, :http_read_timeout,
               :protocol, :host, :port, :secure,
               :production_environment].freeze

    attr_accessor :username
    attr_accessor :password
    attr_accessor :sms_uri
    attr_accessor :secure
    attr_accessor :http_open_timeout
    attr_accessor :http_read_timeout
    attr_accessor :host
    attr_accessor :port
    attr_accessor :production_environment

    alias_method :secure?, :secure

    def initialize
      @secure                   = false
      @host                     = 'sent.ly'
      @http_open_timeout        = 10
      @http_read_timeout        = 10
      @production_environment   = true
      @sms_uri                  = '/command/sendsms'
      @port                     = default_port
    end

    def [](option)
      send(option)
    end

    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash.merge(option.to_sym => send(option))
      end
    end

    def merge(hash)
      to_hash.merge(hash)
    end

    def port
      @port || default_port
    end

    def protocol
      if secure?
        'https'
      else
        'http'
      end
    end

    private
      def default_port
        if secure?
          443
        else
          80
        end
      end
  end
end
