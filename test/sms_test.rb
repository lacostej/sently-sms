require 'helper'

class Sently::SmsTest < Test::Unit::TestCase
  context Sently::Sms do
    setup do
      Sently::Sms.configuration = nil
      Sently::Sms.configure do |config|
        config.username = 'test@sent.ly'
        config.password = '$ecret'
        config.production_environment = false
      end
    end

    should "format number with dashs" do
      sms = Sently::Sms.new("1-555-5556471", "test")
      assert_equal(sms.format_number("1-555-5556471"), "15555556471")
    end

    should "format number with brackets" do
      sms = Sently::Sms.new("1(555)5556471", "test")
      assert_equal(sms.format_number("1-555-5556471"), "15555556471")
    end

    should "format number with brackets and dashs" do
      sms = Sently::Sms.new("1(555)555-6471", "test")
      assert_equal(sms.format_number("1-555-5556471"), "15555556471")
    end

    should "accept recipient with at least 4 characters" do
      sms = Sently::Sms.new("0123", "test")
      assert_equal(sms.format_number("0123"), "0123")
    end

    should "reject recipient with less than 4 characters" do
      sms = Sently::Sms.new("123", "test")
      assert_raise(Sently::Sms::SentlySMSException) do
        sms.format_number("123")
      end
    end

    should "keep + prefixes" do
      sms = Sently::Sms.new(" +47 12345678", "doh")
      assert_equal(sms.format_number(" +47 12345678"), "+4712345678")
    end

    should "raise on invalidate message length" do
      sms = Sently::Sms.new("123", "Well, if you like burgers give 'em a try sometime. I can't usually get 'em myself because my girlfriend's a vegitarian which pretty much makes me a vegitarian. But I do love the taste of a good burger. Mm-mm-mm. You know what they call a Quarter Pounder with cheese in France?")

      assert_raise(Sently::Sms::SentlySMSException) do
        sms.deliver_sms
      end
    end

    should "not production submit sms" do
      sms = Sently::Sms.new("40867729", "test")
      assert_equal(sms.deliver_sms, {"id"=>12345, "error" => ""})
    end

    should "handle bad response" do
      sms = Sently::Sms.new
      r = sms.send(:parse, "x")
      assert_equal(r, {'id' => -1, 'error' => 'Error parsing: \'x\''})
    end

    #should "process find" do
    #  Sently::Sender.any_instance.stubs(:get).returns('{"credit":5000,"id":"123456","reports":"[]","stat":"ok"}')

    #  assert_equal(Sently::Sms.find('123456'), {"id"=>"123456", "credit"=>5000, "stat"=>"ok", "reports"=>"[]"})
    #end
  end

  context Sently::Sms do
    setup do
      Sently::Sms.configuration = nil
      Sently::Sms.configure do |config|
        config.username = 'test@sent.ly'
        config.password = '$ecret'
        config.host = 'notrealxxx1234sently.com'
      end
    end

    should "return DNS error" do
      assert_equal(Sently::Sms.new("1(555)555-6471", "test").deliver_sms["error"], "getaddrinfo")
    end
  end

end
