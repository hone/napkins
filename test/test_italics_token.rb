require 'test/unit'

require 'tokens'
require 'nodes'

class TestItalicsToken < Test::Unit::TestCase # :nodoc:
  def test_node_class
    token = ItalicsToken.new( '_', 0 )
    assert_equal ItalicsNode, token.node_class
  end
end
