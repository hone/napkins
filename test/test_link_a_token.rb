require 'test/unit'

class TestLinkAToken < Test::Unit::TestCase # :nodoc:
  def test_node_class
    token = LinkAToken.new( '"', 0 )
    assert_equal LinkNode, token.node_class
  end
end
