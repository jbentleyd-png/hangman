class Alphabet
  def initialize
    @unguessed = ("A".."Z").to_a
    @guessed = []
  end

  def guess(letter)
    @unguessed.pop(letter)
    @guessed.push(letter)
    p @guessed
  end
end