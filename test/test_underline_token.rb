require 'test/unit'

require 'tokens'
require 'nodes'

class TestUnderlineToken < Test::Unit::TestCase # :nodoc:
  def test_node_class
    token = UnderlineToken.new( '+', 0 )
    assert_equal UnderlineNode, token.node_class
  end
end
