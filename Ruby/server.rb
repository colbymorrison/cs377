require 'rinda/tuplespace'
 
URI = "druby://localhost:67671"
DRb.start_service(URI, Rinda::TupleSpace.new)
DRb.thread.join

