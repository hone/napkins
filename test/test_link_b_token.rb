require 'test/unit'

require 'tokens'
require 'nodes'

class TestLinkBToken < Test::Unit::TestCase # :nodoc:
  def test_node_class
    token = LinkBToken.new( '":', 0 )
    assert_equal LinkNode, token.node_class
  end
end
