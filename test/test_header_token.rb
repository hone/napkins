require 'test/unit'

require 'tokens'

class TestHeaderToken < Test::Unit::TestCase
  def setup
  end
  
  def test_initialize
    header = HeaderToken.new "h1.", 0, 2
    assert_equal 1, header.level
  end
end
