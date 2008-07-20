require 'test/unit'

require 'scanner'

class TestScanner < Test::Unit::TestCase
  def setup
  end

  def test_single_word
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "hello", 0 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\nhello", expected_tokens
  end

  def test_words
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      construct_word_token( "World!", 6 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\nHello World!", expected_tokens
  end

  def test_multiple_spaces
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

    test_helper "\nHello    World!", expected_tokens
  end

  def test_underline
    expected_tokens = [
      StartLineToken.new( 1 ),
      UnderlineToken.new( "+", 0 ),
      construct_word_token( "underline", 1 ),
      UnderlineToken.new( "+", 10 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n+underline+", expected_tokens
  end

  def test_underline_and_words
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      UnderlineToken.new( "+", 6 ),
      construct_word_token( "World", 7 ),
      UnderlineToken.new( "+", 12 ),
      WordToken.new( "!", 13, 14 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\nHello +World+!", expected_tokens
  end

  def test_italics
    expected_tokens = [
      StartLineToken.new( 1 ),
      ItalicsToken.new( "_", 0 ),
      construct_word_token( "italics", 1 ),
      ItalicsToken.new( "_", 8 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n_italics_", expected_tokens
  end

  def test_italics_words
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      ItalicsToken.new( "_", 6 ),
      construct_word_token( "World", 7 ),
      ItalicsToken.new( "_", 12 ),
      construct_word_token( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\nHello _World_!", expected_tokens
  end

  def test_bold
    expected_tokens = [
      StartLineToken.new( 1 ),
      BoldToken.new( "*", 0 ),
      construct_word_token( "bold", 1 ),
      BoldToken.new( "*", 5 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n*bold*", expected_tokens
  end

  def test_bold_words
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      BoldToken.new( "*", 6 ),
      construct_word_token( "World", 7 ),
      BoldToken.new( "*", 12 ),
      construct_word_token( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\nHello *World*!", expected_tokens
  end

  def test_subscript
    expected_tokens = [
      StartLineToken.new( 1 ),
      SubscriptToken.new( "~", 0 ),
      construct_word_token( "subscript", 1 ),
      SubscriptToken.new( "~", 10 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n~subscript~", expected_tokens
  end

  def test_subscript_words
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      SubscriptToken.new( "~", 6 ),
      construct_word_token( "World", 7 ),
      SubscriptToken.new( "~", 12 ),
      construct_word_token( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\nHello ~World~!", expected_tokens
  end

  def test_superscript
    expected_tokens = [
      StartLineToken.new( 1 ),
      SuperscriptToken.new( "^", 0 ),
      construct_word_token( "superscript", 1 ),
      SuperscriptToken.new( "^", 12 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n^superscript^", expected_tokens
  end

  def test_superscript_words
    expected_tokens = [
      StartLineToken.new( 1 ),
      construct_word_token( "Hello", 0 ),
      WhitespaceToken.new( " ", 5, 6 ),
      SuperscriptToken.new( "^", 6 ),
      construct_word_token( "World", 7 ),
      SuperscriptToken.new( "^", 12 ),
      construct_word_token( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\nHello ^World^!", expected_tokens
  end

  private
  def construct_word_token( word, start_position )
    WordToken.new word, start_position, start_position + word.length
  end

  def test_helper( string, expected_tokens )
    tokens = Scanner.scan string
    assert_equal expected_tokens, tokens
  end
end
