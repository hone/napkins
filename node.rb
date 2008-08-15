# represents a node in the Syntax Tree
class Node
  attr_reader :value, :next_node

  # constructor. sets up the value pointed to by the Node and the next node in the instruction
  def initialize( value, next_node = nil )
    @value = value
    @next_node = next_node
  end
end
