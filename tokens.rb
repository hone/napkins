# this is the base abstract class for all Tokens
module Token
  attr_reader :value, :start_position, :end_position

  # constructor.
  # Inputs:
  # [value]           +String+ representing the value of Token
  # [start_position]  +Fixnum+ representing the starting position in the source of the Token
  # [end_position]    +Fixnum+ representing the ending position in the source of the Token
  def initialize( value, start_position, end_position )
    @value = value
    @start_position = start_position
    @end_position = end_position
  end

  # to string method. generates a string representation of the Token
  def to_s
    "#{@value}@#{@start_position},#{@end_position}"
  end

  # Equality operator.  Tests if two tokens are the same.
  # Inputs:
  # [other] - Token to be compared against.
  def ==( other )
    self.class == other.class and
      @value == other.value and
      @start_position == other.start_position and
      @end_position == other.end_position
  end
end

# Token class representing whitespaces
class WhitespaceToken
  include Token

  #--
  # TODO include checks in the constructor for checking for whitespaces
  #++
end

# Token class representing the underscore function
module ModifierToken
  include Token

  # constructor.  Calculates the end position.
  # Inputs:
  # [value]     +String+ representing the value of Token
  # [position]  +Fixnum+ representing the starting position in the source of the Token
  def initialize( value, position )
    super( value, position, position + 1 )
  end
end

# Token class representing a word
class WordToken
  include Token
end

# Token class representing a header
class HeaderToken
  include Token

  attr_reader :level

  # constructor. Pulls the header number/level based off of the incoming value.
  def initialize( value, start_position, end_position )
    @level = value[1].chr.to_i
    super( value, start_position, end_position )
  end
end

# Token class representing the start of a link
class LinkAToken
  include Token
end

# Token class representing the middle of a link
class LinkBToken
  include Token
end

# Token class representing a title
class TitleToken
  include Token
end

# Token class representing underscore modifier
class UnderlineToken
  include ModifierToken
end

# Token class representing italics modifier
class ItalicsToken
  include ModifierToken
end

# Token class representing bold modifier
class BoldToken
  include ModifierToken
end

# Token class representing subscript modifier
class SubscriptToken
  include ModifierToken
end

# Token class representing superscript modifier
class SuperscriptToken
  include ModifierToken
end

# Token class representing a end of the line
class EndLineToken
  include Token 

  # constructor.  Only need to store one position.
  # Inputs:
  # [position] - +Fixnum+ representing the line number in the source string
  def initialize( position )
    super( nil, position, position )
  end
end

# Token class representing the beginning of the line
class StartLineToken
  include Token

  # constructor.  Only need to store one position.
  # Inputs:
  # [position] - +Fixnum+ representing the line number in the source string
  def initialize( position )
    super( nil, position, position )
  end
end
