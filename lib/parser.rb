require 'nodes'
require 'scanner'

# Parses the tokens from the Scanner
class Parser
  class << self
    # parse the Token stream and create a Syntax Tree.
    def parse( tokens )
      # add tokens to keep track of what's been processed
      stack = Array.new
      # keeps track of what token classes we have come across
      # key: Token class name
      # value: index in the token_stack
      tokens_occured_hash = Hash.new 

      root_node  = RootNode.new
      # process tokens into nodes
      tokens.each do |token|
        # if end of line, clear buffer
        # parse rest of process_stack
        # put in a newline
        if token.is_a? EndLineToken
          node = process_stack( stack )
          stack.clear
          stack.push node
        elsif token.is_a? StartLineToken
        # check for words
        elsif token.is_a? WordToken
          stack.push token
        # handle whitespace differently because of links
        elsif token.is_a? WhitespaceToken
          stack.push token
        # handle links differently from rest of modifiers
        elsif token.is_a? LinkAToken or token.is_a? LinkBToken
        # modifier token
        else
          # if queue is empty, can just add to the stack
          if stack.empty?
            stack.push token
          else
            tokens = stack.reject {|item| not item.is_a? token.class }
            # if can't find token class in the stack, can just add to the stack
            if tokens.empty?
              stack.push token
            # found token in stack, must sift through from start symbol 
            else
              index = stack.rindex( tokens.first )
              # process from index to top of the stack
              self.process_stack( stack[index..( stack.size - 1 )] )
            end
          end
        end
      end.compact

      root_node.next_node = stack.first
      root_node
    end

    # will process a stack of tokens and return the appropriate nodes. Expects Token class matching only on start token.  The second matched token is NOT on the tokens param.
    # Inputs:
    # [tokens] - an Array of Tokens
    def process_stack( tokens )
      tokens.reverse.inject( nil ) do |last_node, stack_item|
        # process header token differently, since only 1 header token to represent different types of headers

        # handle nodes on the stack
        if stack_item.is_a? Node
          # combine TextNodes, don't need 50 consecutive +TextNode+s
          if last_node.class == stack_item.class and stack_item.is_a? TextNode
            last_node.value = "#{stack_item.value}#{last_node.value}"
            last_node
          end
        else
          klass = stack_item.node_class

          if klass == TextNode
            # combine TextNodes, don't need 50 consecutive +TextNode+s
            if last_node.is_a? TextNode
              last_node.value = "#{stack_item.value}#{last_node.value}"
              last_node
            else
              #unless last_node.nil?
              #  raise ParserException.new( "TextNode should not have a next Node @ #{token.start_position}, #{token.end_position}" )
              #end
              klass.new( stack_item.value )
            end
          else
            klass.new( last_node )
          end # klass == TextNode
        end # if stack_item.is_a? Node
      end # do
    end

  end
end
