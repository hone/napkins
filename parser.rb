# Parses the tokens from the Scanner
class Parser
  # constructor.
  # Inputs:
  # [tokens] - +Array+ of +String+s representing 
  def initialize( tokens )
    @tokens = tokens
  end

  def parse
    document
  end

  private
  def match
  end

  def document
    title
    instructions
  end

  def title
    begin_line
    word_list
    end_line
  end

  def begin_line
  end
end
