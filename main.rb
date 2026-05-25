require 'colorize'
require 'json'

require_relative 'lib/alphabet'
require_relative 'lib/game'
require_relative 'lib/letter'
require_relative 'lib/word'
require_relative 'lib/word_list'


GAME_MODES = %w[L N EXIT].freeze

def ask_game_mode
  puts "\nLet's play HANGMAN!!".blue
  puts 'New Game ("N") or Load Game ("L")?'
  puts 'Type "exit" to quit the game.'.gray
  print 'Game Mode: '
  gets.chomp.upcase
end


def show_save_files(save_file_array)
  display_files = save_file_array.map { |path| path[-10...-5]}
  allowed_game_numbers = display_files.map { |title| title[4..]} # grabs whatever follows "save"
  puts "\nSaved Game Files:".green
  puts display_files
  puts"\nChoose a save file by typing its number."
  puts "  e.g. to access save0, type '0'".gray
  print "Choose save file: ".green
  allowed_game_numbers
end

def select_file(allowed_game_numbers)
    chosen_file_number = gets.chomp
  until allowed_game_numbers.include?(chosen_file_number)
    print "Please choose a valid file number:".red
    chosen_file_number = gets.chomp
  end
  chosen_file_number
end

def load_game
  save_dir = File.join(__dir__, "saved_games")
  save_file_array = Dir.glob(File.join(save_dir, "*json"))
  allowed_game_numbers = show_save_files(save_file_array)
  select_file(allowed_game_numbers)
end

def new_game
  game = Game.new
  game.play_game
end



def play_hagman
  
  
  game_mode = ask_game_mode
  until GAME_MODES.include?(game_mode)
    puts "Bad input. Please try again.".red
    game_mode = ask_game_mode
  end
  
  case game_mode
  when "L"
    load_game
  when "N"
    new_game
  else 
    puts "Exiting game.".red
    return
  end
    
end

play_hagman