require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# Write a select semaphore 
ts.write(["sem", "select"])

puts "Tuple space successfully initialized"
