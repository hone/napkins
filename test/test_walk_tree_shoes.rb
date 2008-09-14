require 'test/unit'
require 'lib/nodes'
require 'lib/walk_tree_shoes'

class TestWalkTreeShoes < Test::Unit::TestCase # :nodoc:
  def test_walk_root_first_line_testing
    root_node = RootNode.new( ParagraphNode.new( TagNode.new( TextNode.new( "Testing" ) ) ) )

    assert_equal "para( \"Testing\" )", WalkTreeShoes.walk_root( root_node )
  end

  def test_walk_root_two_lines_hello_world
    tokens = Scanner.scan( "Hello\n\nWorld" )
    root_node = Parser.parse( tokens )
    
    assert_equal "para( \"Hello\" )\npara( \"World\" )", WalkTreeShoes.walk_root( root_node )
  end

  def test_walk_root_first_line_multiple_tags
    tokens = Scanner.scan( "Hello World" )
    root_node = Parser.parse( tokens )

    assert_equal "para( \"Hello\", \" \", \"World\" )", WalkTreeShoes.walk_root( root_node )
  end

  def test_walk_root_empty
    tokens = Scanner.scan( "" )
    root_node = Parser.parse( tokens )

    assert_equal "", WalkTreeShoes.walk_root( root_node )
  end

  def test_walk_root_bold
    tokens = Scanner.scan( "\n\n*bold*" )
    root_node = Parser.parse( tokens )

    assert_equal "para( strong( \"bold\" ) )", WalkTreeShoes.walk_root( root_node )
  end

  def test_walk_root_italics
    tokens = Scanner.scan( "\n\n_italics_" )
    root_node = Parser.parse( tokens )

    assert_equal "para( em( \"italics\" ) )", WalkTreeShoes.walk_root( root_node )
  end

  def test_walk_root_underscore
    tokens = Scanner.scan( "\n\n+underscore+" )
    root_node = Parser.parse( tokens )

    assert_equal "para( ins( \"underscore\" ) )", WalkTreeShoes.walk_root( root_node )
  end
end
