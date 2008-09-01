require 'test/unit'

require 'scanner'
require 'parser'

class TestParser < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_parse_simple_first_line
  end

  def test_parse_simple_line_hello_world
    text = <<TEXT

Hello World!
TEXT
    root_node = RootNode.new
    hello_text_node = TextNode.new( "Hello" )
    space_text_node = TextNode.new( " " )
    world_text_node = TextNode.new( "World!" )
    newline_text_node = TextNode.new( "\n" )

    hello_tag_node = TagNode.new( hello_text_node, space_text_node )
    world_tag_node = TagNode.new( world_text_node, newline_text_node )
    space_text_node.next_node = world_tag_node
    root_node = RootNode.new( hello_text_node )

    tokens = Scanner.scan( text )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_process_stack_simple_hello_world
    text_node = TextNode.new( "Hello World!" )
    bold_node = BoldNode.new( text_node )
    tokens = Scanner.scan( "\n*Hello World!*" )
    # get rid of start/end line tokens for simple testing
    clean_stack( tokens )
    tokens.pop # second BoldToken

    assert_equal bold_node, Parser.process_stack( tokens )
  end

  # handles the case where there's a node on the stack before processing it
  def test_process_stack_previous_text_node
    text_node = TextNode.new( "Hi BobHello World!" )

    stack = Scanner.scan( "\nHello World!" )
    clean_stack( stack )
    stack.unshift TextNode.new( "Hi Bob" ) # insert node onto top of the stack

    assert_equal text_node, Parser.process_stack( stack )
  end

  def test_process_stack_previous_node
    hi_annie_text_node = TextNode.new( "Hi Annie" )
    hello_world_text_node = TextNode.new( "Hello World!" )
    bold_node = BoldNode.new( hi_annie_text_node )
    bold_node_result = BoldNode.new( hi_annie_text_node, hello_world_text_node )

    stack = Scanner.scan( "\nHello World!" )
    clean_stack( stack )
    stack.unshift bold_node

    assert_equal bold_node_result, Parser.process_stack( stack )
  end

  private
  def clean_stack( stack )
    stack.pop # EndLine 1 Token
    stack.shift # StartLine 0 Token
    stack.shift # EndLine 0 Token
    stack.shift # EndLine 1 Token

    stack
  end
end
