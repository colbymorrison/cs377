require 'rinda/rinda'
 
#
# cs377
# fall 2016
# Producer-Consumer v1
# Solution
# Marc Smith
# init-ts.rb
#

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# initialize tuple space
#   int buf;
#   int n = 80;
#   int p = 0;
#   int c = 0;

ts.write( ["n", 80] )
ts.write( ["p", 0] )
ts.write( ["c", 0] )
puts "init-ts: tuple space initialized..."

