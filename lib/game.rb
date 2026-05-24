class Game

  def initialize
    @word = Word.new 
    @alphabet = Alphabet.new
    @first_turn = true
  end

  def to_hash
    {
    word: @word.to_hash,
    alphabet: @alphabet.to_hash,
    first_turn: @first_turn
  }
  end

  def save
    save_string = JSON.generate(self.to_hash)
    save_dir = File.join(__dir__, "..", "saved_games")
    save_number = Dir.glob(File.join(save_dir, "*json")).length # length of array of all .jsons in that directory
    while File.exist?(File.join(save_dir, "save#{save_number}.json"))
      save_number += 1
    end
    File.write(File.join(save_dir, "save#{save_number}.json"), save_string)
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
    puts "Type 'save' to save and exit the game.".gray
    print 'Guess a letter: '
    letter = gets.chomp.upcase
    until @alphabet.unguessed.include?(letter) || letter == "SAVE"
      print 'Please choose a single, unchosen letter: '
    letter = gets.chomp.upcase
    end
    letter
  end

  def make_guess
    letter = grab_verified_letter
    if letter == "SAVE"
      self.save
      print "Game saved. ".green
      puts "Exiting game.".red
      return 'saved'
    end
    is_correct = @word.guess(letter)
    @alphabet.guess(letter, is_correct)
  end

  def play_round
    make_guess
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
    self.play_round until @alphabet.incorrect_letters_guessed.length == 9 || @word.solved?
    result_message
  end



end