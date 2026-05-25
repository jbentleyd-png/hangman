# frozen_string_literal: true

require_relative 'word_list'

class Word # :nodoc:
  attr_accessor :word_array
  attr_reader :word_from_file

  def initialize
    @word_from_file = WORD_LIST[rand(WORD_LIST.length)]
    @word_to_chars = @word_from_file.upcase.chars
    # take word and trun into word array of hashes
    @word_array = []
    @word_to_chars.each do |letter|
      @word_array.push Letter.new(letter)
    end
  end

  def guess(letter)
    is_correct = false
    @word_array.each do |space|
      is_correct = true if space.guess(letter)
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
    @word_array.all? { |space| space.guessed } # rubocop:disable Style/SymbolProc
  end

  def to_hash
    {
      word_from_file: @word_from_file,
      word_to_chars: @word_to_chars,
      word_array: @word_array.map { |letter| letter.to_hash } # rubocop:disable Style/SymbolProc
    }
  end

  def self.from_hash(word_hash)
    new_word = Word.allocate
    new_word.instance_variable_set(:@word_from_file, word_hash[:word_from_file])
    new_word.instance_variable_set(:@word_to_chars, word_hash[:word_to_chars])
    new_word.instance_variable_set(:@word_array, word_hash[:word_array])
    # we have an attr_accessor for word_array, so we can mess with it:
    new_word.word_array.map! { |letter| Letter.from_hash(letter) } # bang because we need to modify it in-place
    new_word
  end
end
