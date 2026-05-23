require_relative 'word_list'

class Word
  def initialize
    @word_string = WORD_LIST[rand(WORD_LIST.length)]
    p @word_string
    #take word and trun into word array of hashes
    @word_arrray = []
    @word_string.each do |letter|
      @word_arrray.push Letter.new(letter)
    end
    p word_arrray
  end
end