require 'test/unit'
require 'lib/nodes'
require 'lib/walk_tree_shoes'

class TestWalkTreeShoes < Test::Unit::TestCase # :nodoc:
  def test_walk_root_first_line_testing
    root_node = RootNode.new( ParagraphNode.new( TagNode.new( TextNode.new( "Testing" ) ) ) )

    assert_equal "\npara( \"Testing\"\" \" ) ", WalkTreeShoes.walk_root( root_node )
  end

  def test_walk_root_two_lines_hello_world
    tokens = Scanner.scan( "Hello\n\nWorld" )
    root_node = Parser.parse( tokens )
    
    assert_equal "\npara( \"Hello\"\" \" ) \npara( \"World\" ) ", WalkTreeShoes.walk_root( root_node )
  end
end
