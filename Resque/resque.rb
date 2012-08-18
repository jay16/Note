require "resque"
#require File.expand_path('../word_analysis', __FILE__)
#require File.dirname(__FILE__)+"/word_analysis"
require "./word_analysis"

idea = ARGV
puts "Analyzing your idea: #{idea.join(" ")}"
idea.each do |word|
  puts "Asking for a job to analyze:#{word}"
  Resque.enqueue(WordAnalyzer,word)
end





#jay@jay-virtual-machine:~/ruby/MetaRuby/Ruby$ resque --help
#Usage: resque [options] COMMAND

#Options:
#    -r, --redis [HOST:PORT]          Redis connection string
#    -N, --namespace [NAMESPACE]      Redis namespace
#    -h, --help                       Show this message

#Commands:
#  remove WORKER   Removes a worker
#  kill WORKER     Kills a worker
#  list            Lists known workers

