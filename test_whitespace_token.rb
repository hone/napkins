require 'test/unit'

require 'tokens'

class TestWhitespaceToken < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_to_s
    token = WhitespaceToken.new " ", 0, 1
    assert_equal " @0,1", token.to_s
  end

  def test_equals
    assert WhitespaceToken.new( "  ", 0, 2 ) == WhitespaceToken.new( "  ", 0, 2 )
    assert !( WhitespaceToken.new( "  ", 0, 2 ) == WordToken.new( "  ", 0, 2 ) )
  end
end
