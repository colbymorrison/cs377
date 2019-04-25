require 'rinda/tuplespace'
 
#
# cs377
# fall 2016
# Producer-Consumer v1
# Solution
# Marc Smith
# consumer.rb
#

URI = "druby://localhost:67671"
DRb.start_service(URI, Rinda::TupleSpace.new)
DRb.thread.join

