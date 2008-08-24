require 'test/unit'

require 'scanner'
require 'parser'

class TestParser < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_first_line
    text = <<TEXT
Hello World!
TEXT
    root = RootNode.new
    hello_text_node = TextNode.new( "Hello" )
    space_text_node = TextNode.new( " " )
    world_text_node = TextNode.new( "World!" )
    newline_text_node = TextNode.new( "\n" )

    hello_tag_node = TagNode.new( hello_text_node, space_text_node )
    world_tag_node = TagNode.new( world_text_node, newline_text_node )
    space_text_node.next_node = world_tag_node
    root.next_node = hello_tag_node

    tokens = Scanner.scan( text )

    assert_equal root, Parser.parse( tokens )
  end

  def test_process_tokens_simple
    text_node = TextNode.new( "Hello World!" )
    bold_node = BoldNode.new( text_node )
    tokens = Scanner.scan( "\n*Hello World!*" )
    # get rid of start/end line tokens for simple testing
    tokens.pop # EndLine 1 Token
    tokens.pop # second BoldToken
    tokens.shift # StartLine 0 Token
    tokens.shift # EndLine 0 Token
    tokens.shift # StartLine 1 Token
    tokens.each {|token| puts token.inspect }

    assert_equal bold_node, Parser.process_tokens( tokens )
  end
end
