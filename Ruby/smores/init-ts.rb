require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# Start off by selecting 2 random ingredients
ts.write(["sem", "select"])

puts "Tuple space successfully initialized"