module Sently
  class Sms
    attr_accessor :number, :message, :hid

    class << self
      attr_accessor :configuration
      attr_accessor :sender

      def configure
        self.configuration ||= Configuration.new
        yield(configuration)
        self.sender = Sender.new(configuration)
      end

      #def find(id)
      #  response = sender.get(configuration.sms_uri + "/#{id}")

      #  JSON.parse(response.to_s)
      #end
    end

    def initialize(number = "", message = "", hid = "")
      @number = number
      @message = message
      @hid = hid
    end

    def deliver_sms
      #raise SentlySMSException.new("Invalid message") unless is_message_valid?(@message)

      params = { :text => @message.to_s, :to => format_number(@number), :hid => @hid }

      if production_environment?
        begin
          response = sender.get(configuration.sms_uri, params)
        rescue Exception => e
          response = RestClient::Response.create("Error:#{e.message}", "", {})
        end
      else
        response = RestClient::Response.create('Id:12345', "", {})
      end

      parse(response.to_s)
    rescue SentlySMSException => exception
      raise exception
    end

    def format_number(number)
      formatted = number.scan(/\d+/i).join
      return is_number_valid?(formatted) ? formatted : (raise SentlySMSException.new("Phone number (#{number}) is not formatted correctly"))
    end

    def is_number_valid?(number)
      number.length >= 4 && number[/^.\d+$/]
    end

    #def is_message_valid?(message)
    #  if message_length_check?
    #    message_length_range.include?(message.to_s.size)
    #  else
    #    true
    #  end
    #end

    class SentlySMSException < StandardError; end

    private
      def sender
        Sently::Sms.sender
      end

      def configuration
        Sently::Sms.configuration
      end

      def production_environment?
        configuration.production_environment
      end

      def parse(str)
        r = {'id' => -1, 'error' => ''}
        begin
          a = str.split(':')
          case a[0]
          when 'Id'
            r['id'] = a[1].to_i
          when 'Error'
            r['error'] = a[1]
          else
            r['error'] = "Error parsing: '#{str}'"
          end
          r
        rescue Exception => e
          {"id"=>-1, "error"=>"json parser error", "response"=>json.to_s}
        end
      end
  end
end
