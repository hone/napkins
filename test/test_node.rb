require 'test/unit'

require 'nodes'

class TestNode < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_initialize
  end

  def test_equals_value
    n1 = Node.new( "blah" )
    n2 = Node.new( 1 )
    n3 = Node.new( "blah" )

    assert !( n1 == n2 )
    assert_equal n1, n3
  end

  def test_equals_next_node
    n4 = Node.new( "bar" )
    n3 = Node.new( "bar", n4 )
    n2 = Node.new( "foo", n3 )
    n1 = Node.new( "foo", n3 )

    assert !( n3 == n4 )
    assert_equal n1, n2
  end
end
