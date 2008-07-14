# provide methods to easily tell classification of +String+ for the Scanner
module StringChecks
  # checks if the current +String+ is a whitespace
  def whitespace?
    regex_helper( /^\s+$/ )
  end

  # checks if the current +String+ is a number
  def number?
    regex_helper( /^[0-9]+$/ )
  end

  # checks if the current +String+ is a word
  def word?
    regex_helper( /^\w+$/ )
  end

  # checks for underscore
  def underscore?
    regex_helper( /^\+$/ )
  end

  # checks for italics
  def italics?
  end

  private
  def regex_helper( regex )
    not regex.match( self ).nil?
  end
end

class String
  include StringChecks
end
