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
end

# Token class representing whitespaces
class WhitespaceToken
  include Token

  #--
  # TODO include checks in the constructor for checking for whitespaces
  #++
end
