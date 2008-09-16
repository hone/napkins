require 'test/unit'
require 'lib/nodes'
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

  private
  def testing_tree_helper( expected, input )
    assert_equal expected, WalkTreeShoes.walk_root( Parser.parse( Scanner.scan( input ) ) )
  end
end
