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
#   int buf[n];
#   int front =0;
#   int rear = 0;
#   sem empty = n;
#   sem full = 0;


# How do for
for i 1 to n do
    ts.write( ["sem", "empty"])
end
ts.write( ["front", 0] )
ts.write( ["rear", 0] )
puts "init-ts: tuple space initialized..."

