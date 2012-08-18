module Codebreaker
		class Game
		  def initialize(output)
		    @output = output
		  end
		  
				def start(secret)
				  @secret = secret
				  @output.puts "Welcome to Codebreaker!"
				  @output.puts "Enter guess:"
				end
				
				def guess(guess)
				  maker = Marker.new(@secret, guess)
				  @output.puts '+'*maker.exact_match_count + '-'*maker.number_match_count
				end	
		end
end
