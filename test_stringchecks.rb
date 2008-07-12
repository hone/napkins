require 'test/unit'
require 'string_checks'

class TestStringChecks < Test::Unit::TestCase # :nodoc:
    STRING_TESTS = [
      " ",
      "              ",
      " blah",
      "blah ",
      "blah",
      "9 ",
      "9",
      "947123",
      "+",
      " + "
    ]

  def setup
  end

  def test_whitespace
    true_index = [0, 1]
    test_helper true_index, :whitespace?
  end

  def test_number
    true_index = [6, 7]
    test_helper true_index, :number?
  end

  def test_word
    true_index = [4]
    test_helper true_index, :word?
  end

  private
  def test_helper( true_index, method )
    true_tests = true_index.collect {|index| STRING_TESTS[index] }
    false_tests = STRING_TESTS - true_tests

    true_tests.each {|test| assert test.send( method ), "Expected to be a #{method}:#{test}" }
    false_tests.each {|test| assert !test.send( method ), "Was not supposed to be a #{method}:#{test}" }
  end
end
