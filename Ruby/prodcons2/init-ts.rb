require 'rinda/rinda'
 
#
# cs377
# Producer-Consumer v2
# Solution
# Colby Morrison
# init-ts.rb
#

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# initialize tuple space
#   int buf;
#   sem empty = 1;
#   sem full = 0;


ts.write( ["sem", "empty"])
ts.write( ["buf", 0] )
puts "init-ts: tuple space initialized..."

