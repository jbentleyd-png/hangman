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

  def grab_verified_letter
    print 'Guess a letter: '
    letter = gets.chomp.upcase
    until @alphabet.unguessed.include?(letter)
      print 'Please choose a single, unchosen letter: '
    letter = gets.chomp.upcase
    end
    letter
  end

  def make_guess
    letter = grab_verified_letter
    is_correct = @word.guess(letter)
    @alphabet.guess(letter, is_correct)
    self.display
  end

  def result_message
    if @word.solved? 
      print "YOU WIN!!!!".blue
    else  
      print "GAME OVER.".red 
    end
    puts "  Word: '#{@word.word_from_file}'\n\n"
  end

  def play_game
    self.display
    self.make_guess until @alphabet.incorrect_letters_guessed.length == 9 || @word.solved?
    result_message
  end

  def to_hash
    {
    word: @word.to_hash,
    alphabet: @alphabet.to_hash,
    first_turn: @first_turn
  }
  end
end