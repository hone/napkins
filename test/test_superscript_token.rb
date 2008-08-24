require 'test/unit'

require 'tokens'
require 'nodes'

class TestSuperscriptToken < Test::Unit::TestCase # :nodoc:
  def test_node_class
    token = SuperscriptToken.new( '~', 0 )
    assert_equal SuperscriptNode, token.node_class
  end
end
