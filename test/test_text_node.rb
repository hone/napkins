require 'test/unit'

require 'nodes'

class TestTextNode < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_equals_class
    node = Node.new( "blah" )
    text_node = TextNode.new( "blah" )
    text_node2 = TextNode.new( "blah" )

    assert !( node == text_node )
    assert !( text_node == node )
    assert_equal text_node, text_node2
  end
end
