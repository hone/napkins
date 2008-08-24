require 'test/unit'

require 'tokens'
require 'nodes'

class TestHeaderToken < Test::Unit::TestCase # :nodoc:
  def setup
  end
  
  def test_initialize
    header = HeaderToken.new( "h1.", 0 )
    assert_equal 1, header.level
  end

  def test_is_a_modifier_token
    header = HeaderToken.new( "h1.", 0 )
    assert_equal "Token", header.module
  end

  def test_node_class
    (1..6).each do |level|
      token = HeaderToken.new( "h#{level}", 0 )
      klass = Object.const_get( "Header#{level}Node" )
      assert_equal klass, token.node_class
    end
  end
end
