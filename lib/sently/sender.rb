module Sently
  class Sender
    attr_reader :host, :port, :secure, :http_open_timeout, :http_read_timeout, :protocol, :username, :password

    def initialize(options = {})
      [:protocol, :host, :port, :secure, :http_open_timeout, :http_read_timeout, :username, :password].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
    end

    #def post(data, uri)
    #  http  = RestClient::Resource.new(
    #            url(uri),
    #            :username => username,
    #            :timeout => http_read_timeout,
    #            :open_timeout => http_open_timeout
    #          )

    #  response = http.post(data)
    #end

    def get(uri, additional_headers = {})
      http  = RestClient::Resource.new(
                url(uri),
                :timeout => http_read_timeout,
                :open_timeout => http_open_timeout
              )
      headers = { :username => username, :password => password }

      p = { :params => headers.merge(additional_headers) }

      response = http.get p
    end

    private
      def url(uri = "")
        URI.parse("#{protocol}://#{host}:#{port}").merge(uri).to_s
      end

      def configuration
        Sently::Sms.configuration
      end

      def production_environment?
        configuration.production_environment
      end
  end
end