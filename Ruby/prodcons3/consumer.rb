require 'rinda/rinda'

#
# cs377
# Producer-Consumer v3
# Solution
# Colby Morrison
# consumer.rb
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

tag, n = ts.read( ["n", Numeric] )

while true do
    # P(full);
    # result = buf[front];
    # front = (front+1)%n;
    # V(empty);  
    
    ts.take( ["sem", "full"] )
    tag, front = ts.take( ["front", Numeric] )

    tag, index, result = ts.take(["buf", front, Numeric])
    puts "Consumer got #{result} at index #{front}"

    ts.write( ["front", (front+1)%n] )
    ts.write( ["sem", "empty"] )

end
