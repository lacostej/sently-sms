require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
# require 'webmock/test_unit'
begin require 'redgreen'; rescue LoadError; end
begin require 'turn'; rescue LoadError; end

require 'sently-sms'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

class Test::Unit::TestCase
  # include WebMock
end
