class Game

  def initialize
    @word = Word.new 
    @alphabet = Alphabet.new
  end

  def display
    @word.display
    @alphabet.display
  end

  def make_guess
    print 'Guess a letter: '
    letter = gets.chomp.upcase
    is_correct = @word.guess(letter)
    @alphabet.guess(letter, is_correct)
    self.display
  end
end