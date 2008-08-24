require 'test/unit'

require 'tokens'
require 'nodes'

class TestSubscriptToken < Test::Unit::TestCase #:nodoc:
  def test_node_class
    token = SubscriptToken.new( '~', 0 )
    assert_equal SubscriptNode, token.node_class
  end
end
