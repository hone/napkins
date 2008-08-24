require 'test/unit'

require 'tokens'

class TestWhitespaceToken < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_to_s
    token = WhitespaceToken.new " ", 0
    assert_equal " @0,1", token.to_s
  end

  def test_equals
    assert WhitespaceToken.new( "  ", 0 ) == WhitespaceToken.new( "  ", 0 )
    assert !( WhitespaceToken.new( "  ", 0 ) == WordToken.new( "  ", 0 ) )
  end

  def test_node_class
    token = WhitespaceToken.new( " ", 0 )
    assert_equal TextNode, token.node_class
  end
end
