require 'test/unit'
require 'lib/nodes'
require 'lib/scanner'
require 'lib/parser'
require 'lib/walk_tree_shoes'

class TestWalkTreeShoes < Test::Unit::TestCase # :nodoc:
  def test_walk_root_first_line_testing
    testing_tree_helper( "para( \"Testing\" )", "Testing" )
  end

  def test_walk_root_two_lines_hello_world
    testing_tree_helper( "para( \"Hello\" )\npara( \"World\" )", "Hello\n\nWorld" )
  end

  def test_walk_root_first_line_multiple_tags
    testing_tree_helper( "para( \"Hello\", \" \", \"World\" )", "Hello World" )
  end

  def test_walk_root_empty
    testing_tree_helper( "", "" )
  end

  def test_walk_root_bold
    testing_tree_helper( "para( strong( \"bold\" ) )", "\n\n*bold*" )
  end

  def test_walk_root_italics
    testing_tree_helper( "para( em( \"italics\" ) )", "\n\n_italics_" )
  end

  def test_walk_root_underscore
    testing_tree_helper( "para( ins( \"underscore\" ) )", "\n\n+underscore+" )
  end

  def test_walk_root_subscript
    testing_tree_helper( "para( sub( \"subscript\" ) )", "\n\n~subscript~" )
  end

  def test_walk_root_superscript
    testing_tree_helper( "para( sup( \"superscript\" ) )", "\n\n^superscript^" )
  end

  def test_walk_root_header1
    testing_tree_helper( "banner( \"hello\" )", "\n\nh1. hello" )
  end

  def test_walk_root_header2
    testing_tree_helper( "title( \"hello\" )", "\n\nh2. hello" )
  end

  def test_walk_root_header3
    testing_tree_helper( "tagline( \"hello\" )", "\n\nh3. hello" )
  end

  def test_walk_root_header4
    testing_tree_helper( "caption( \"hello\" )", "\n\nh4. hello" )
  end

  def test_walk_root_header5
    testing_tree_helper( "para( \"hello\" )", "\n\nh5. hello" )
  end

  def test_walk_root_header6
    testing_tree_helper( "inscription( \"hello\" )", "\n\nh6. hello" )
  end

  def test_walk_root_subsequent_header_paragraph_nodes
    testing_tree_helper( "para( \"para1\" )\nbanner( \"banner1\" )\npara( \"para2\" )", "\n\npara1\n\nh1. banner1\n\npara2" )
  end

  private
  def testing_tree_helper( expected, input )
    assert_equal expected, WalkTreeShoes.walk_root( Parser.parse( Scanner.scan( input ) ) )
  end
end
