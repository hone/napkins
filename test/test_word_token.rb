require 'test/unit'

require 'tokens'
require 'nodes'

class TestWordToken < Test::Unit::TestCase # :nodoc:
  def test_node_class
    token = WordToken.new( "hello", 0 )
    assert_equal TextNode, token.node_class
  end
end
