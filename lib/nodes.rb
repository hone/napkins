# represents a Node in the Syntax Tree
class Node
  attr_accessor :value, :next_node

  # constructor. sets up the value pointed to by the Node and the TextNode in the instruction
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

# is a Node in the Syntax Tree.  Contains all the text (words + spaces) to be processed.
class TextNode < Node
end

# is a Node in the Syntax Tree.  Denotes bold.
class BoldNode < Node
end

# is a Node in the Syntax Tree.  Denotes italics.
class ItalicsNode < Node
end

# is a Node in the Syntax Tree.  Denotes underline.
class UnderlineNode < Node
end

# is a Node in the Syntax Tree.  Denotes subscript.
class SubscriptNode < Node
end

# is a Node in the Syntax Tree.  Denotes superscript.
class SuperscriptNode < Node
end

# is a Node in the Syntax Tree. Denotes header.
class HeaderNode < Node
  # constructor. sets up the value pointed to by the Node and the TextNode in the instruction
  # Inputs:
  # [value] - the value that should be in the Header.  This is another Node.
  # [level] - what level the HeaderNode is.  This should be a Fixnum from 1 to 6.
  def initialize( value, level, next_node = nil )
    @value = value
    @level = level
    @next_node = next_node
  end
end

# is a Node in the Syntax Tree. Denotes a link.
class LinkNode < Node
end

# is a Node in the Syntax Tree. Parent Node of the whole tree.
class RootNode < Node
  # constructor. The RootNode contains no value.
  # Inputs:
  # [next_node] - Next Node in the tree
  def initialize( next_node = nil )
    @value = nil
    @next_node = next_node
  end
end

# is a Node in the Syntax Tree.  Represents a tag.
class TagNode < Node
end

# is a Node in the Syntax Tree.  Represents a NewLine.  This is a special kind of TextNode
class NewLineNode < Node
  # constructor. The NewLineNode contains a "\n" value.
  # Inputs:
  # [next_node] - Next Node in the tree
  def initialize( next_node = nil )
    @value = "\n"
    @next_node = next_node
  end
end

class ParagraphNode < Node
end
