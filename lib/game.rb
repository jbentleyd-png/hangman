class Game

  def initialize
    @word = Word.new 
    @alphabet = Alphabet.new
    @first_turn = true
    @save_number = nil
  end

  def to_hash
    {
    word: @word.to_hash,
    alphabet: @alphabet.to_hash,
    first_turn: @first_turn,
    save_number: @save_number
  }
  end

  def self.from_hash(game_hash)
    new_game = Game.allocate
    new_game.instance_variable_set(:@word, Word.from_hash(game_hash[:word]))
    new_game.instance_variable_set(:@alphabet, Alphabet.from_hash(game_hash[:alphabet]))
    new_game.instance_variable_set(:@first_turn, game_hash[:first_turn])
    new_game.instance_variable_set(:@save_number, game_hash[:save_number])
    new_game
  end

  def save
    save_dir = File.join(__dir__, "..", "saved_games")
    total_files = Dir.glob(File.join(save_dir, "*json")).length # length of array of all .jsons in that directory

    if @save_number == nil && total_files >= 3 
      puts "Insufficient space. May not save more than 3 games.".red
      return 'save_failed'
    end

    if @save_number == nil
      @save_number = total_files
      while File.exist?(File.join(save_dir, "save#{@save_number}.json"))
        @save_number += 1
      end
      puts "save_number increased to #{@save_number}"
    end # if @save_number != nil, it stays untouched
    
    save_string = JSON.generate(self.to_hash)
    File.write(File.join(save_dir, "save#{@save_number}.json"), save_string)
    print "Game saved. ".green
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
    puts "Type 'save' to save and exit the game, or 'exit' to quit without saving.".gray
    print 'Guess a letter: '
    letter = gets.chomp.upcase
    until @alphabet.unguessed.include?(letter) || letter == "SAVE" || letter == "EXIT"
      print 'Please choose a single, unchosen letter: '
    letter = gets.chomp.upcase
    end
    letter
  end

  def make_guess
    letter = grab_verified_letter
    case letter
    when "SAVE"
      if self.save == 'save_failed'
        return
      end
      puts "Exiting game.".red
      return 'exited'
    when "EXIT"
      puts "Exiting game.".red
      return 'exited'
    else
      is_correct = @word.guess(letter)
      @alphabet.guess(letter, is_correct)
    end
  end

  def play_round
    if make_guess == 'exited'
      return 'exited'
    end
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
    until @alphabet.incorrect_letters_guessed.length == 9 || @word.solved? do
      return if self.play_round == 'exited'
    end
    result_message
  end



end