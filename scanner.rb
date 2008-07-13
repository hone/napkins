class Scanner
  SYMBOL = {
    '+' => :underscore,
    '_' => :italics,
    '*' => :bold,
    '"' => :link_a,
    '":' => :link_b,
    'h1. ' => :header1,
    'h2. ' => :header2,
    'h3. ' => :header3,
    'h4. ' => :header4,
    'h5. ' => :header5,
    'h6. ' => :header6,
    '~', => :sub,
    '^' => :super,
    ' ' => :whitespace,
    '\t' => :whitespace
  }

  def self.scan( string )
    tokens = Array.new

    lines = string.split( "\n" )
    first_line = lines.shift

    lines.each do |line|
      str.strip!
	
      # check for headers
      header = SYMBOL[line[0..2]]
      if header and line[3] == ' '
        tokens.push header
        line.slice!( 0, 3 )
      end

      characters = line.split(//)
      #index of the last character in the last special token we read
      last_token_end_index = -1 
      in_link = false #are we inside the quote part of a link
      skip_to_index = -1 # won't care about characters until we reach this index
      characters.each_with_index do |character, index|
        if index < skip_to_index
          # TODO put here whatever the equivalent of continue is
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
      end # character

      tokens.push :newline
    end # line
  end
end
