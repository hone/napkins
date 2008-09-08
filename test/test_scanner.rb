require 'test/unit'

require 'scanner'

class TestScanner < Test::Unit::TestCase # :nodoc:
  def setup
  end

  def test_single_word
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "hello", 0 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nhello", expected_tokens
  end

  def test_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      WordToken.new( "World!", 6 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello World!", expected_tokens
  end

  def test_multiple_spaces
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      WhitespaceToken.new( " ", 6 ),
      WhitespaceToken.new( " ", 7 ),
      WhitespaceToken.new( " ", 8 ),
      WordToken.new( "World!", 9 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello    World!", expected_tokens
  end

  def test_underline
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      UnderlineToken.new( "+", 0 ),
      WordToken.new( "underline", 1 ),
      UnderlineToken.new( "+", 10 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\n+underline+", expected_tokens
  end

  def test_underline_and_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      UnderlineToken.new( "+", 6 ),
      WordToken.new( "World", 7 ),
      UnderlineToken.new( "+", 12 ),
      WordToken.new( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello +World+!", expected_tokens
  end

  def test_italics
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      ItalicsToken.new( "_", 0 ),
      WordToken.new( "italics", 1 ),
      ItalicsToken.new( "_", 8 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\n_italics_", expected_tokens
  end

  def test_italics_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      ItalicsToken.new( "_", 6 ),
      WordToken.new( "World", 7 ),
      ItalicsToken.new( "_", 12 ),
      WordToken.new( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello _World_!", expected_tokens
  end

  def test_bold
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      BoldToken.new( "*", 0 ),
      WordToken.new( "bold", 1 ),
      BoldToken.new( "*", 5 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\n*bold*", expected_tokens
  end

  def test_bold_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      BoldToken.new( "*", 6 ),
      WordToken.new( "World", 7 ),
      BoldToken.new( "*", 12 ),
      WordToken.new( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello *World*!", expected_tokens
  end

  def test_subscript
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      SubscriptToken.new( "~", 0 ),
      WordToken.new( "subscript", 1 ),
      SubscriptToken.new( "~", 10 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\n~subscript~", expected_tokens
  end

  def test_subscript_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      SubscriptToken.new( "~", 6 ),
      WordToken.new( "World", 7 ),
      SubscriptToken.new( "~", 12 ),
      WordToken.new( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello ~World~!", expected_tokens
  end

  def test_superscript
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      SuperscriptToken.new( "^", 0 ),
      WordToken.new( "superscript", 1 ),
      SuperscriptToken.new( "^", 12 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\n^superscript^", expected_tokens
  end

  def test_superscript_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      SuperscriptToken.new( "^", 6 ),
      WordToken.new( "World", 7 ),
      SuperscriptToken.new( "^", 12 ),
      WordToken.new( "!", 13 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello ^World^!", expected_tokens
  end

  def test_link
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      LinkAToken.new( '"', 0 ),
      WordToken.new( "link", 1 ),
      LinkBToken.new( '":', 5 ),
      WordToken.new( "http://www.link.com", 7 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\n\"link\":http://www.link.com", expected_tokens
  end

  def test_link_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      LinkAToken.new( '"', 6 ),
      WordToken.new( "Rodwitt", 7 ),
      WhitespaceToken.new( " ", 14 ),
      WordToken.new( "Lai", 15 ),
      LinkBToken.new( '":', 18 ),
      WordToken.new( "http://www.helloworld.com", 20 ),
      WhitespaceToken.new( " ", 45 ),
      WordToken.new( "!", 46 ),
      EndLineToken.new( 1 )
    ]

    test_helper "\n\nHello \"Rodwitt Lai\":http://www.helloworld.com !", expected_tokens
  end

  def test_first_line
    expected_tokens = [
      StartLineToken.new( 0 ),
      WordToken.new( "link", 0 ),
      WhitespaceToken.new( " ", 4 ),
      WordToken.new( "cool", 5 ),
      WhitespaceToken.new( " ", 9 ),
      WordToken.new( "awesome", 10 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      LinkAToken.new( '"', 0 ),
      WordToken.new( "link", 1 ),
      LinkBToken.new( '":', 5 ),
      WordToken.new( "http://www.link.com", 7 ),
      EndLineToken.new( 1 )
    ]

    test_helper "link cool awesome\n\n\"link\":http://www.link.com", expected_tokens
  end

#  def test_newline_token
#    expected_tokens = [
#    ]
#
#    test_helper "\n\nhello\nworld", expected_tokens
#  end

  private
  def test_helper( string, expected_tokens )
    tokens = Scanner.scan string
    assert_equal expected_tokens, tokens
  end
end
