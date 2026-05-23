require_relative 'word_list'

class Word
  
  attr_accessor :word_array
  attr_reader :word_from_file
  
  def initialize
    @word_from_file = WORD_LIST[rand(WORD_LIST.length)]
    @word_to_chars = @word_from_file.upcase.chars
    #take word and trun into word array of hashes
    @word_array = []
    @word_to_chars.each do |letter|
      @word_array.push Letter.new(letter)
    end
  end

  def guess(letter)
    is_correct = false
    @word_array.each do |space|
      if space.guess(letter)
        is_correct = true
      end
    end
    is_correct
  end

  def display
    display_word = []
    @word_array.each do |space|
      if space.guessed
        display_word.push space.name
      else
        display_word.push '_'
      end
    end
    print "\n\t#{display_word.join('')}"
  end

  def solved?
    solved_status = @word_array.all? { |space| space.guessed }
    solved_status
  end

end