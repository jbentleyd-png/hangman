# frozen_string_literal: true

class Game # :nodoc:
  def initialize
    @word = Word.new
    @alphabet = Alphabet.new
    @first_turn = true
    @save_number = nil
    @game_over = false
  end

  def to_hash
    {
      word: @word.to_hash,
      alphabet: @alphabet.to_hash,
      first_turn: @first_turn,
      save_number: @save_number,
      game_over: @game_over
    }
  end

  def self.from_hash(game_hash)
    new_game = Game.allocate
    new_game.instance_variable_set(:@word, Word.from_hash(game_hash[:word]))
    new_game.instance_variable_set(:@alphabet, Alphabet.from_hash(game_hash[:alphabet]))
    new_game.instance_variable_set(:@first_turn, game_hash[:first_turn])
    new_game.instance_variable_set(:@save_number, game_hash[:save_number])
    new_game.instance_variable_set(:@game_over, game_hash[:game_over])
    new_game
  end

  def save(game_over)
    save_dir = File.join(__dir__, '..', 'saved_games')
    total_files = Dir.glob(File.join(save_dir, '*json')).length # length of array of all .jsons in that directory

    if @save_number.nil? && total_files >= 3
      puts 'Insufficient space. May not save more than 3 games.'.red
      return 'save_failed'
    end

    if @save_number.nil?
      @save_number = total_files
      @save_number += 1 while File.exist?(File.join(save_dir, "save#{@save_number}.json"))
    end

    save_string = JSON.generate(to_hash)
    save_path = File.join(save_dir, "save#{@save_number}.json")
    File.write(save_path, save_string)
    print 'Game saved. '.green unless game_over
    save_path
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
    until @alphabet.unguessed.include?(letter) || letter == 'SAVE' || letter == 'EXIT'
      print 'Please choose a single, unchosen letter: '
      letter = gets.chomp.upcase
    end
    letter
  end

  def make_guess
    letter = grab_verified_letter
    case letter
    when 'SAVE'
      return if save(@game_over) == 'save_failed'

      puts 'Exiting game.'.red
      'exited'
    when 'EXIT'
      puts 'Exiting game.'.red
      'exited'
    else
      is_correct = @word.guess(letter)
      @alphabet.guess(letter, is_correct)
    end
  end

  def play_round
    return 'exited' if make_guess == 'exited'

    display
  end

  def result_message
    if @word.solved?
      print 'YOU WIN!!!!'.blue
    else
      print 'GAME OVER.'.red
    end
    puts "  Word: '#{@word.word_from_file}'\n\n"
  end

  def play_game
    display
    until @alphabet.incorrect_letters_guessed.length == 9 || @word.solved?
      return if play_round == 'exited'
    end
    @game_over = true
    result_message
    File.delete(save(@game_over))
  end
end
