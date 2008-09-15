require 'lib/tokens'
require 'lib/string_checks'

# Produces an +Array+ of +Token+s based on the source
class Scanner
  SYMBOL = {
    '+' => UnderlineToken,
    '_' => ItalicsToken,
    '*' => BoldToken,
    '"' => LinkAToken,
    '":' => LinkBToken,
    '~' => SubscriptToken,
    '^' => SuperscriptToken,
  }
  WHITESPACE = {
    ' ' => :whitespace,
    '\t' => :whitespace
  }
  HEADER = {
    'h1. ' => :header1,
    'h2. ' => :header2,
    'h3. ' => :header3,
    'h4. ' => :header4,
    'h5. ' => :header5,
    'h6. ' => :header6,
  }

  # Scans the source +String+ and produces an +Array+ of +Token+s
  # Inputs:
  # [string] - source file represented as a +String+
  def self.scan( string )
    tokens = Array.new

    lines = string.split( /\n\n/ )
    return tokens if lines.size == 0
    first_line = lines.shift

    # process first line for words and spaces
    tokens.push StartLineToken.new( 0 )
    word = ""
    start_position = 0
    first_line.split(//).each_with_index do |char, line_index|
      # end of word
      if /\s/.match char
        tokens.push WordToken.new( word, start_position ) if not word.empty?
        tokens.push WhitespaceToken.new( char, line_index )
        start_position = line_index + 1
        word = ""
      # construct word
      else
        word += char
      end
    end

    # construct remaining word left if it exists
    tokens.push WordToken.new( word, start_position ) if not word.empty?
    tokens.push EndLineToken.new( 0 )

    lines.each_with_index do |line, line_index|
      position = 0 # holds the position on the line
      line_index += 1
      start_position = position # holds the starting position of a token
      tokens.push StartLineToken.new( line_index )

      # remove surrounding whitespace on a line since we don't display it.
      line.strip!
      # need a whitespace character to know to end the last token
      line += "\n"
	
      # check for headers
      header_string = line[0..3]
      header = HEADER[header_string]
      if header
        tokens.push Header.new( header_string, position, position + 3 )
        tokens.push Whitespace.new( ' ', position + 3, position + 4 )
        position += 4
        line.slice!( 0, 4 )
      end

      position -= 1
      characters = line.split( // )
      characters.inject( '' ) do |fragment, character|
        position += 1

        klass = SYMBOL[character]
        # could be a special token
        if klass
          # start symbol
          if fragment.empty?
            if klass != LinkAToken
              tokens.push klass.new( character, position )
              start_position = position + 1
              ''
            else
              # need to build and see if it's a LinkA or LinkB token
              character
            end
          # used to construct linkb
          else
            # end of WordToken
            tokens.push WordToken.new( fragment, start_position )
            start_position = position + 1
            # check for LinkAToken, since it must be handled differently
            if klass == LinkAToken
              character
            else
              tokens.push klass.new( character, position )
              ''
            end
          end
        # must be a word or whitepsace or link
        else
          # puts "#{fragment.empty?} #{character.whitespace?} |#{fragment}| |#{character}|"
          # check for additional whitespace characters
          if fragment.empty? and character.whitespace?
            tokens.push WhitespaceToken.new( character, start_position )
            start_position = position + 1
            ''
          # end of WordToken
          elsif character.whitespace?
            tokens.push WordToken.new( fragment, start_position )
            if character == "\n"
              tokens.push NewLineToken.new( position )
            else
              tokens.push WhitespaceToken.new( ' ', position )
            end
            start_position = position + 1
            ''
          # check for LinkA/B Tokens
          elsif fragment == '"'
            # check for LinkBToken
            if character == ":"
              tokens.push LinkBToken.new( '":', start_position - 1 )
              start_position = position + 1
              ''
            # then is a stand alone ", so must be a LinkAToken
            else
              tokens.push LinkAToken.new( '"', start_position )
              start_position = position

              character
            end
          # keep building WordToken
          else
            fragment + character
          end # if whitespace?
        end # if klass
=begin
      # index of the last character in the last special token we read
      last_token_end_index = -1 
      in_link = false # are we inside the quote part of a link
      skip_to_index = -1 # won't care about characters until we reach this index
      characters.each_with_index do |character, index|
        position += 1
        if index < skip_to_index
          # TODO put here whatever the equivalent of continue is
          next
        end
        
        if SYMBOL.has_key? character
          token = SYMBOL[character]
          if in_link and line[index,2] == '":' # The close of the quoted part of a link
            tokens.push line[last_token_end_index + 1..index-1]
            tokens.push SYMBOLS['":']
            skip_to_index = index + 2
            in_link = false
          else if token == :link_a # this is gonna get ugly
            link_end_pos = line.index( '":', index + 1 )
            next_quote_pos = line.index( '"', index + 1 )
            
            # in case we have something like:   "not link" "link":http://...  :(
            if link_end_pos or ( link_end_pos == next_quote_pos )
              if index != 0
                tokens.push line[last_token_end_index + 1..index-1] #pish text
              end
              tokens.push :link_a
              last_token_end_index = index
              in_link = true
            end
          else #other 1-character token
            if index != 0
              tokens.push line[last_token_end_index + 1..index-1] # push text
            end
            tokens.push token
            last_token_end_index = index
          end
        end
=end
      end # character

      tokens.pop # remove last whitespace character
      tokens.push EndLineToken.new( line_index )
    end # line

    tokens
  end

  private
end
