class Game

  def initialize
    @word = Word.new 
    @alphabet = Alphabet.new
  end

  def make_guess
    print 'Guess a letter: '
    letter = gets.chomp.upcase
    is_correct = @word.guess(letter)
    @alphabet.guess(letter, is_correct)
    @word.display
    @alphabet.display
  end
end