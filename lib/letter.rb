class Letter
  attr_accessor :guessed
  attr_reader :name

  def initialize(letter)
    @name = letter
    @guessed = false
  end

  def guess(guessed_letter)
    return false unless guessed_letter == @name
    @guessed = true
    p @guessed
    return true
  end
end