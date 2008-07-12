# provide methods to easily tell classification of +String+ for the Scanner
module StringChecks
  # checks if the current +String+ is a whitespace
  def whitespace?
    not /^\s+$/.match( self ).nil?
  end

  # checks if the current +String+ is a number
  def number?
    not /^[0-9]+$/.match( self ).nil?
  end

  # checks if the current +String+ is a word
  def word?
    not /^[a-zA-Z]+$/.match( self ).nil?
  end
end

class String
  include StringChecks
end
