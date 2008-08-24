require 'nodes'
require 'scanner'

# Parses the tokens from the Scanner
class Parser
  class << self
    # parse the Token stream and create a Syntax Tree.
    def parse( tokens )
      # add tokens to keep track of what's been processed
      process_stack = Array.new 
      # keeps track of what token classes we have come across
      # key: Token class name
      # value: index in the process_stack
      tokens_occured_hash = Hash.new 

      root = RootNode.new
      tokens.each do |token|
        # if end of line, clear buffer
        # parse rest of process_stack
        # put in a newline
        if token.is_a? EndLineToken
        # check for words
        elsif token.is_a? WordToken
        # handle whitespace differently because of links
        elsif token.is_a? WhitespaceToken
        # handle links differently from rest of modifiers
        elsif token.is_a? LinkAToken or token.is_a? LinkBToken
        # modifier token
        else
          # if queue is empty, can just add to the stack
          if process_stack.empty?
            process_stack.push token
          else
            tokens = process_stack.reject {|item| not item.is_a? token.class }.empty?
            # if can't find token class in the stack, can just add to the stack
            if tokens.empty?
              process_stack.push token
            # found token in stack, must sift through from start symbol 
            else
              index = process_stack.rindex( tokens.first )
              # process from index to top of the stack
              self.process_tokens( process_stack[index..( process_stack.size - 1 )] )
            end
          end
        end
      end
    end

    # will process a stack of tokens and return the appropriate nodes. Expects Token class matching only on start token.  The second matched token is NOT on the tokens param.
    # Inputs:
    # [tokens] - an Array of Tokens
    def process_tokens( tokens )
      tokens.reverse.inject( nil ) do |last_node, token|
        # process header token differently, since only 1 header token to represent different types of headers

        klass = token.node_class

        if klass == TextNode
          if last_node.is_a? TextNode
            last_node.value = "#{token.value}#{last_node.value}"
            last_node
          else
            #unless last_node.nil?
            #  raise ParserException.new( "TextNode should not have a next Node @ #{token.start_position}, #{token.end_position}" )
            #end
            klass.new( token.value )
          end
        else
          klass.new( last_node )
        end
      end
    end
  end
end
