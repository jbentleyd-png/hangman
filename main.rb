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

def load_game
  puts "Sorry, fool, we can't do that yet.".red
  play_hagman
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