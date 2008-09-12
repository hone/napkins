require 'test/unit'

require 'tokens'

class TestNewLineToken < Test::Unit::TestCase
  def test_node_class
    token = NewLineToken.new( 0 )
    assert_equal NewLineNode, token.node_class
  end
end
