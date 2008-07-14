require 'test/unit'

require 'scanner'

class TestScanner < Test::Unit::TestCase
  def setup
  end

  def test_single_word
    tokens = Scanner.scan( "\nhello" )
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "hello", 0 ),
      EndLineToken.new( 1 )
    ]

    assert_equal expected_tokens, tokens
  end

  def test_words
    tokens = Scanner.scan( "\nHello World!" )
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      construct_word_token( "World!", 6 ),
      EndLineToken.new( 1 )
    ]

    assert_equal expected_tokens, tokens
  end

  def test_multiple_spaces
    tokens = Scanner.scan( "\nHello    World!" )
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      WhitespaceToken.new( " ", 6, 7 ),
      WhitespaceToken.new( " ", 7, 8 ),
      WhitespaceToken.new( " ", 8, 9 ),
      construct_word_token( "World!", 9 ),
      EndLineToken.new( 1 )
    ]

    assert_equal expected_tokens, tokens
  end

  def test_underline
    tokens = Scanner.scan( "\n+underline+" )
    expected_tokens = [
      StartLineToken.new( 1 ),
      UnderlineToken.new( "+", 0 ),
      construct_word_token( "underline", 1 ),
      UnderlineToken.new( "+", 10 ),
      EndLineToken.new( 1 )
    ]

    assert_equal expected_tokens, tokens
  end

  private
  def construct_word_token( word, start_position )
    WordToken.new word, start_position, start_position + word.length
  end
end
