class WordAnalyzer
  @queue = :word_analysis
  
  def self.perform(word)
    puts "About to do heavy duty analysis on #{word}"
    sleep 3
    puts "Finished with analysis on #{word}"
  end
end
