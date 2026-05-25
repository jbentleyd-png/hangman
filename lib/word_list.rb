WORD_LIST = File.readlines(File.join(__dir__, 'english_words.txt'), chomp: true).select do |w|
              w.length >= 3 && w.match?(/[aeiou]/i)
            end


