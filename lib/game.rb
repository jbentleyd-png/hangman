class Game

  def initialize
    @word = Word.new 
    @alphabet = Alphabet.new
    @first_turn = true
  end

  def display
    if @first_turn 
      puts "\nNew Word:".green
      @word.display
      puts "\n\n"
      @first_turn = false
    else
      @word.display
      @alphabet.display
    end
  end

  def make_guess
    print 'Guess a letter: '
    letter = gets.chomp.upcase
    is_correct = @word.guess(letter)
    @alphabet.guess(letter, is_correct)
    self.display
  end
end