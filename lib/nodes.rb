# represents a node in the Syntax Tree
class Node
  attr_reader :value, :next_node

  # constructor. sets up the value pointed to by the Node and the next node in the instruction
  def initialize( value, next_node = nil )
    @value = value
    @next_node = next_node
  end

  # equals method.
  # Inputs:
  # [other_node] - Object of type Node.  Used to compare against current node
  def ==( other_node )
    other_node.is_a? self.class and
      self.is_a? other_node.class and
      other_node.value == @value and
      other_node.next_node == next_node
  end
end

# is a node in the Syntax Tree.  Contains all the text (words + spaces) to be processed.
class TextNode < Node
end

# is a node in the Syntax Tree.  Denotes bold.
class BoldNode < Node
end

# is a node in the Syntax Tree.  Denotes italics.
class ItalicsNode < Node
end

# is a node in the Syntax Tree.  Denotes underscore.
class UnderscoreNode < Node
end

# is a node in the Syntax Tree.  Denotes subscript.
class SubscriptNode < Node
end

# is a node in the Syntax Tree.  Denotes superscript.
class SuperscriptNode < Node
end

# is a node in the Syntax Tree. Denotes header1.
class Header1Node < Node
end

# is a node in the Syntax Tree. Denotes header2.
class Header2Node < Node
end
