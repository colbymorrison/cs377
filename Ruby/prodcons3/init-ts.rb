require 'rinda/rinda'
 
#
# cs377
# Producer-Consumer v3
# Solution
# Colby Morrison
# init-ts.rb
#

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))
n = 20

# initialize tuple space
#   int n = 20;
#   int buf[n];
#   int front =0;
#   int rear = 0;
#   sem empty = n;
#   sem full = 0;

ts.write( ["n", n] )
ts.write( ["front", 0] )
ts.write( ["rear", 0] )

for i in 1..n do
    ts.write(["sem", "empty"])
end

puts "init-ts: tuple space initialized..."

