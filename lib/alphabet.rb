class Alphabet
  attr_reader :guessed

  def initialize
    @unguessed = ("A".."Z").to_a
    @incorrect_letters_guessed = []
  end

  def guess(letter, is_correct)
    @unguessed.delete(letter)
    if is_correct
      puts 'Correct!'.green
      return
    else 
      @incorrect_letters_guessed.push(letter)
    end

  end 

  def display
    print "    Wrong Guesses: #{@incorrect_letters_guessed.join(',').red} | "
    puts "#{6 - @incorrect_letters_guessed.length} wrong guesses remaining.\n".red
  end

end

