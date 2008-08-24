# this is the base abstract class for all Tokens
module Token
  attr_reader :value, :start_position, :end_position

  # constructor.
  # Inputs:
  # [value]           +String+ representing the value of Token
  # [start_position]  +Fixnum+ representing the starting position in the source of the Token
  def initialize( value, start_position )
    @value = value
    @start_position = start_position
    @end_position = start_position + @value.length
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

  # Returns the name of the module included
  def module
    "Token"
  end
end

# base abstract class for start/end of lines
module LineToken
  include Token
  # constructor.  Only need to store one position.
  # Inputs:
  # [position] - +Fixnum+ representing the line number in the source string
  def initialize( position )
    @value = nil
    @start_position = position
    @end_position = position
  end
  
  # Returns the name of the module included
  def module
    "LineToken"
  end
end

# Token class representing whitespaces
class WhitespaceToken
  include Token

  # Returns appropriate Syntax Node class
  def node_class
    TextNode
  end
end

# Token class representing the underscore function
module ModifierToken
  include Token

  # Returns the name of the module included
  def module
    "ModifierToken"
  end
end

# Token class representing a word
class WordToken
  include Token

  # Returns appropriate Syntax Node class
  def node_class
    TextNode
  end
end

# Token class representing a header
class HeaderToken
  include Token

  attr_reader :level

  # constructor. Pulls the header number/level based off of the incoming value.
  def initialize( value, start_position )
    @level = value[1].chr.to_i
    super( value, start_position )
  end

  # Returns appropriate Syntax Node class
  def node_class
    Object.const_get( "Header#{@level}Node" )
  end
end

# Token class representing the start of a link
class LinkAToken
  include Token
  
  # Returns appropriate Syntax Node class
  def node_class
    LinkNode
  end
end

# Token class representing the middle of a link
class LinkBToken
  include Token
  
  # Returns appropriate Syntax Node class
  def node_class
    LinkNode
  end
end

# Token class representing underscore modifier
class UnderlineToken
  include ModifierToken

  # Returns appropriate Syntax Node class
  def node_class
    UnderlineNode
  end
end

# Token class representing italics modifier
class ItalicsToken
  include ModifierToken

  # Returns appropriate Syntax Node class
  def node_class
    ItalicsNode
  end
end

# Token class representing bold modifier
class BoldToken
  include ModifierToken

  # Returns appropriate Syntax Node class
  def node_class
    BoldNode
  end
end

# Token class representing subscript modifier
class SubscriptToken
  include ModifierToken

  # Returns appropriate Syntax Node class
  def node_class
    SubscriptNode
  end
end

# Token class representing superscript modifier
class SuperscriptToken
  include ModifierToken

  # Returns appropriate Syntax Node class
  def node_class
    SuperscriptNode
  end
end

# Token class representing a end of the line
class EndLineToken
  include LineToken 
end

# Token class representing the beginning of the line
class StartLineToken
  include LineToken
end
