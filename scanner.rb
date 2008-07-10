require 'link_token'

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
    '^' => :super
  }

  def self.scan( string )
    tokens = Array.new

    lines = string.split( "\n" )
    first_line = lines.shift

    lines.each do |line|
      # check for headers
      header = SYMBOL[line[0..2]]
      if header and line[3] == ' '
        tokens.push header
        line.slice!( 0, 3 )
      end

      characters = line.split(//)
      characters.each_with_index do |character, index|
      end # character

      tokens.push :newline
    end # line
  end
end
