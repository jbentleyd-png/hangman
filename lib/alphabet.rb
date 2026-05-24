class Alphabet
  attr_reader :guessed, :incorrect_letters_guessed, :unguessed

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
    guesses_message = "    Wrong Guesses: #{@incorrect_letters_guessed.join(',').red} | "
    guesses_message = "    Wrong Guesses: none | "if @incorrect_letters_guessed.length == 0
    print guesses_message
    puts "#{9 - @incorrect_letters_guessed.length} wrong guesses remaining.\n".red
  end

  def to_hash
    {
      unguessed: @unguessed, 
      incorrect_letters_guessed: @incorrect_letters_guessed 
    }
  end

end

