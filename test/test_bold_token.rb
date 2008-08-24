require 'test/unit'

class TestBoldToken < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_module
    bold = BoldToken.new( "blah", 0 )
    assert_equal "ModifierToken", bold.module
  end

  def test_node_class
    token = BoldToken.new( '*', 0 )
    assert_equal BoldNode, token.node_class
  end
end
