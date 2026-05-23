require_relative 'word_list'

class Word
  def initialize
    @word_from_file = WORD_LIST[rand(WORD_LIST.length)]
    p @word_from_file
    @word_to_chars = @word_from_file.upcase.chars
    #take word and trun into word array of hashes
    @word_arrray = []
    @word_to_chars.each do |letter|
      @word_arrray.push Letter.new(letter)
    end
    p @word_arrray
  end
end