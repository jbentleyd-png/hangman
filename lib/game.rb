class Game

  def initialize
    @word = Word.new 
    @alphabet = Alphabet.new
  end

  def make_guess
    print 'Guess a letter: '
    letter = gets.chomp.upcase
    @word.guess(letter)
    @alphabet.guess(letter)
    @word.display
  end
end