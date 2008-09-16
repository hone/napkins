require 'test/unit'

require 'scanner'
require 'parser'

class TestParser < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_parse_simple_first_line
    world_tag_node = TagNode.new( TextNode.new( "World" ) )
    hello_tag_node = TagNode.new( TextNode.new( "Hello" ), world_tag_node )
    paragraph_node = ParagraphNode.new( hello_tag_node )
    root_node = RootNode.new( paragraph_node )
    tokens = Scanner.scan( "Hello World" )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_parse_simple_hello_world
    hello_world_text_node = TextNode.new( "Hello World!" )
    paragraph_node = ParagraphNode.new( hello_world_text_node )
    root_node = RootNode.new( paragraph_node )
    tokens = Scanner.scan( "\n\nHello World!" )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_parse_two_lines
    world_paragraph_node = ParagraphNode.new( TextNode.new( "world" ) )
    hello_paragraph_node = ParagraphNode.new( TagNode.new( TextNode.new( "hello" ) ), world_paragraph_node )
    root_node = RootNode.new( hello_paragraph_node )
    tokens = Scanner.scan( "hello\n\nworld" )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_parse_three_lines
    line3_paragraph_node = ParagraphNode.new( TextNode.new( "line3 line3" ) )
    line2_paragraph_node = ParagraphNode.new( TextNode.new( "line2 line2" ), line3_paragraph_node )
    line1_paragraph_node = ParagraphNode.new(
      TagNode.new(
        TextNode.new( "line1" ),
        TagNode.new( TextNode.new( "line1" ) )
      ), line2_paragraph_node
    )
    root_node = RootNode.new( line1_paragraph_node )
    tokens = Scanner.scan( "line1 line1\n\nline2 line2\n\nline3 line3" )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_parse_two_lines_with_bold
    line2 = ParagraphNode.new(
      BoldNode.new( TextNode.new( "bold1" ),
        TextNode.new( " text ",
          BoldNode.new( TextNode.new( "bold2" ) )
        )
      )
    )
    line1 = ParagraphNode.new(
      TagNode.new(
        TextNode.new( "tag1" ),
        TagNode.new( TextNode.new( "tag2" ) )
      ),
      line2
    )
    root_node = RootNode.new( line1 )
    tokens = Scanner.scan( "tag1 tag2\n\n*bold1* text *bold2*" )

    assert_equal root_node, Parser.parse( tokens )
  end

  def test_process_stack_simple_hello_world
    paragraph_node = ParagraphNode.new( TextNode.new( "Hello World!" ) )
    stack = Scanner.scan( "\n\nHello World!" )
    clean_stack( stack )

    assert_equal paragraph_node, Parser.process_stack( stack, true )
  end

  def test_process_stack_bold_hello_world
    text_node = TextNode.new( "Hello World!" )
    bold_node = BoldNode.new( text_node )
    tokens = Scanner.scan( "\n\n*Hello World!*" )
    # get rid of start/end line tokens for simple testing
    clean_stack( tokens )
    tokens.pop # second BoldToken

    assert_equal bold_node, Parser.process_stack( tokens, false )
  end

  # handles the case where there's a node on the stack before processing it
  def test_process_stack_previous_text_node
    text_node = TextNode.new( "Hi BobHello World!" )

    stack = Scanner.scan( "\n\nHello World!" )
    clean_stack( stack )
    stack.unshift TextNode.new( "Hi Bob" ) # insert node onto top of the stack

    assert_equal text_node, Parser.process_stack( stack, false )
  end

  def test_process_stack_previous_node
    hi_annie_text_node = TextNode.new( "Hi Annie" )
    hello_world_text_node = TextNode.new( "Hello World!" )
    bold_node = BoldNode.new( hi_annie_text_node )
    bold_node_result = BoldNode.new( hi_annie_text_node, hello_world_text_node )

    stack = Scanner.scan( "\n\nHello World!" )
    clean_stack( stack )
    stack.unshift bold_node

    assert_equal bold_node_result, Parser.process_stack( stack, false )
  end

  def test_process_stack_newline
    world_text_node = TextNode.new( "World" )
    new_line_node = NewLineNode.new( world_text_node )
    hello_text_node = TextNode.new( "Hello", new_line_node )
    stack = Scanner.scan( "\n\nHello\nWorld" )
    clean_stack( stack )

    assert_equal hello_text_node, Parser.process_stack( stack, false )
  end

  def test_process_first_line_simple_hello_world
    world_tag_node = TagNode.new( TextNode.new( "World!" ) )
    hello_tag_node = TagNode.new( TextNode.new( "Hello" ), world_tag_node )
    paragraph_node = ParagraphNode.new( hello_tag_node )
    stack = Scanner.scan( "Hello World!" )
    # clean the stack of the start/end line
    stack.pop
    stack.shift

    assert_equal paragraph_node, Parser.process_first_line( stack )
  end

  def test_process_stack_previous_paragraph_node
    world_paragraph_node = ParagraphNode.new( TextNode.new( "World!" ) )
    result_node = ParagraphNode.new( TagNode.new( TextNode.new( "Hello" ) ), world_paragraph_node )
    stack = Scanner.scan( "\n\nWorld!" )
    clean_stack( stack )
    hello_paragraph_node = ParagraphNode.new( TagNode.new( TextNode.new( "Hello" ) ) )
    stack.unshift hello_paragraph_node

    assert_equal result_node, Parser.process_stack( stack, true )
  end

  def test_process_stack_with_two_previous_paragraph_nodes
    line3_paragraph_node_result = ParagraphNode.new( TextNode.new( "line3 line3" ) )
    line2_paragraph_node_result = ParagraphNode.new( TextNode.new( "line2 line2" ), line3_paragraph_node_result )
    line1_paragraph_node_result = ParagraphNode.new(
      TagNode.new(
        TextNode.new( "line1" ),
        TagNode.new( TextNode.new( "line1" ) )
      ), line2_paragraph_node_result
    )

    line2_paragraph_node = ParagraphNode.new( TextNode.new( "line2 line2" ) )
    line1_paragraph_node = ParagraphNode.new(
      TagNode.new(
        TextNode.new( "line1" ),
        TagNode.new( TextNode.new( "line1" ) )
      ), line2_paragraph_node
    )

    stack = Scanner.scan( "\n\nline3 line3" )
    clean_stack( stack )
    stack.unshift line1_paragraph_node

    assert_equal line1_paragraph_node_result, Parser.process_stack( stack, true )
  end

  def test_process_stack_previous_node_root_node_endline
    result_node = RootNode.new( ParagraphNode.new( TextNode.new( "hello" ) ) )
    stack = Scanner.scan( "\n\nhello" )
    clean_stack( stack )
    stack.unshift RootNode.new

    assert_equal result_node, Parser.process_stack( stack, true )
  end

  def test_process_stack_bold_text_bold_nodes
    root_node = RootNode.new(
      ParagraphNode.new(
        BoldNode.new(
          TextNode.new( "bold1" ),
          TextNode.new(
            " text ",
            BoldNode.new( TextNode.new( "bold2" ) )
          )
        )
      )
    )
    stack = [
      RootNode.new,
      BoldNode.new( TextNode.new( "bold1" ) ),
      TextNode.new( " text " ),
      BoldNode.new( TextNode.new( "bold2" ) )
    ]

    assert_equal root_node, Parser.process_stack( stack, true )
  end

  def test_process_stack_header
    root_node = RootNode.new(
      HeaderNode.new( TextNode.new( "Header 1" ), 1 )
    )
    stack = Scanner.scan( "\n\nh1. Header 1" )
    clean_stack( stack )
    stack.unshift RootNode.new

    assert_equal root_node, Parser.process_stack( stack, true )
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
