# frozen_string_literal: true

class Letter # :nodoc:
  attr_accessor :guessed
  attr_reader :name

  def initialize(letter)
    @name = letter
    @guessed = false
  end

  def guess(guessed_letter)
    return false unless guessed_letter == @name

    @guessed = true
    true
  end

  def to_hash
    {
      name: @name,
      guessed: @guessed
    }
  end

  def self.from_hash(letter_hash)
    new_letter = Letter.allocate
    new_letter.instance_variable_set(:@name, letter_hash[:name])
    new_letter.instance_variable_set(:@guessed, letter_hash[:guessed])
    new_letter
  end
end
