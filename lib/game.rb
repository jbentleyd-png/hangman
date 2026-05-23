class Game

  def initialize
    @word = Word.new 
    @alphabet = Alphabet.new
    @first_turn = true
  end

  def display
    if @first_turn 
      puts "\nNew Word (#{@word.word_array.length} letters):".green
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

  def result_message
    if @word.solved? 
      print "YOU WIN!!!!".green
    else  
      print "GAME OVER.".red 
    end
    puts "  Word: '#{@word.word_from_file}'\n\n"
  end

  def play_game
    self.display
    self.make_guess until @alphabet.incorrect_letters_guessed.length == 6 || @word.solved?
    result_message
  end
end