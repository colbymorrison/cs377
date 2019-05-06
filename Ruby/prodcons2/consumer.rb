require 'rinda/rinda'

#
# cs377
# Producer-Consumer v2
# Solution
# Colby Morrison
# consumer.rb
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

while true do
    # P(full);
    # result = buf;
    # V(empty); 
    ts.take( ["sem", "full"] )
    tag, result = ts.read(["buf", Numeric])
    puts "Consumer got #{result}"
    ts.write( ["sem", "empty"] )
end
