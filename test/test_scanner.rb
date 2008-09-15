require 'test/unit'

require 'scanner'

class TestScanner < Test::Unit::TestCase # :nodoc:
  def test_scan_single_word
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "hello", 0 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\nhello"
  end

  def test_scan_words
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "Hello", 0 ),
      WhitespaceToken.new( " ", 5 ),
      WordToken.new( "World!", 6 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\nHello World!"
  end

  def test_scan_multiple_spaces
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

    test_scan_helper expected_tokens, "\n\nHello    World!"
  end

  def test_scan_underline
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      UnderlineToken.new( "+", 0 ),
      WordToken.new( "underline", 1 ),
      UnderlineToken.new( "+", 10 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\n+underline+"
  end

  def test_scan_underline_and_words
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

    test_scan_helper expected_tokens, "\n\nHello +World+!"
  end

  def test_scan_italics
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      ItalicsToken.new( "_", 0 ),
      WordToken.new( "italics", 1 ),
      ItalicsToken.new( "_", 8 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\n_italics_"
  end

  def test_scan_italics_words
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

    test_scan_helper expected_tokens, "\n\nHello _World_!"
  end

  def test_scan_bold
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      BoldToken.new( "*", 0 ),
      WordToken.new( "bold", 1 ),
      BoldToken.new( "*", 5 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\n*bold*"
  end

  def test_scan_bold_words
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

    test_scan_helper expected_tokens, "\n\nHello *World*!"
  end

  def test_scan_subscript
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      SubscriptToken.new( "~", 0 ),
      WordToken.new( "subscript", 1 ),
      SubscriptToken.new( "~", 10 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\n~subscript~"
  end

  def test_scan_subscript_words
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

    test_scan_helper expected_tokens, "\n\nHello ~World~!"
  end

  def test_scan_superscript
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      SuperscriptToken.new( "^", 0 ),
      WordToken.new( "superscript", 1 ),
      SuperscriptToken.new( "^", 12 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\n^superscript^"
  end

  def test_scan_superscript_words
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

    test_scan_helper expected_tokens, "\n\nHello ^World^!"
  end

  def test_scan_link
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

    test_scan_helper expected_tokens, "\n\n\"link\":http://www.link.com"
  end

  def test_scan_link_words
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

    test_scan_helper expected_tokens, "\n\nHello \"Rodwitt Lai\":http://www.helloworld.com !"
  end

  def test_scan_first_line_text
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

    test_scan_helper expected_tokens, "link cool awesome\n\n\"link\":http://www.link.com"
  end

  def test_scan_first_line_with_bold_token
    expected_tokens = [
      StartLineToken.new( 0 ),
      WordToken.new( "Hello+", 0 ),
      WhitespaceToken.new( " ", 6 ),
      WordToken.new( "World!+", 7 ),
      EndLineToken.new( 0 )
    ]

    test_scan_helper expected_tokens, "Hello+ World!+"
  end

  def test_scan_newline_token
    expected_tokens = [
      StartLineToken.new( 0 ),
      EndLineToken.new( 0 ),
      StartLineToken.new( 1 ),
      WordToken.new( "hello", 0 ),
      NewLineToken.new( 5 ),
      WordToken.new( "world", 6 ),
      EndLineToken.new( 1 )
    ]

    test_scan_helper expected_tokens, "\n\nhello\nworld"
  end

  def test_scan_empty_string
  end

  private
  def test_scan_helper( expected_tokens, string )
    tokens = Scanner.scan string
    assert_equal expected_tokens, tokens
  end
end
