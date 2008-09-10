require 'test/unit'

require 'scanner'
require 'parser'

class TestParser < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_parse_simple_first_line
    world_tag_node = TagNode.new( TextNode.new( "World" ) )
    hello_tag_node = TagNode.new( TextNode.new( "Hello" ), world_tag_node )
    root_node = RootNode.new( hello_tag_node )
    tokens = Scanner.scan( "Hello World" )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_parse_simple_hello_world
    hello_world_text_node = TextNode.new( "Hello World!" )
    root_node = RootNode.new hello_world_text_node
    tokens = Scanner.scan( "\n\nHello World!" )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_process_stack_bold_hello_world
    text_node = TextNode.new( "Hello World!" )
    bold_node = BoldNode.new( text_node )
    tokens = Scanner.scan( "\n\n*Hello World!*" )
    # get rid of start/end line tokens for simple testing
    clean_stack( tokens )
    tokens.pop # second BoldToken

    assert_equal bold_node, Parser.process_stack( tokens )
  end

  # handles the case where there's a node on the stack before processing it
  def test_process_stack_previous_text_node
    text_node = TextNode.new( "Hi BobHello World!" )

    stack = Scanner.scan( "\n\nHello World!" )
    clean_stack( stack )
    stack.unshift TextNode.new( "Hi Bob" ) # insert node onto top of the stack

    assert_equal text_node, Parser.process_stack( stack )
  end

  def test_process_stack_previous_node
    hi_annie_text_node = TextNode.new( "Hi Annie" )
    hello_world_text_node = TextNode.new( "Hello World!" )
    bold_node = BoldNode.new( hi_annie_text_node )
    bold_node_result = BoldNode.new( hi_annie_text_node, hello_world_text_node )

    stack = Scanner.scan( "\n\nHello World!" )
    clean_stack( stack )
    stack.unshift bold_node

    assert_equal bold_node_result, Parser.process_stack( stack )
  end

  def test_process_stack_newline
    world_text_node = TextNode.new( "World" )
    new_line_node = NewLineNode.new( world_text_node )
    hello_text_node = TextNode.new( "Hello", new_line_node )
    stack = Scanner.scan( "\n\nHello\nWorld" )
    clean_stack( stack )

    assert_equal hello_text_node, Parser.process_stack( stack )
  end

  def test_process_first_line_simple_hello_world
    world_tag_node = TagNode.new( TextNode.new( "World!" ) )
    hello_tag_node = TagNode.new( TextNode.new( "Hello" ), world_tag_node )
    stack = Scanner.scan( "Hello World!" )
    # clean the stack of the start/end line
    stack.pop
    stack.shift

    assert_equal hello_tag_node, Parser.process_first_line( stack )
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
