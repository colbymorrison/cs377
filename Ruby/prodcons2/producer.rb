require 'rinda/rinda'

#
# cs377
# Producer-Consumer v2
# Solution
# Colby Morrison
# producer.rb
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

count = 0

while true do
    #P(empty);
    # buf = data;
    # V(full); 
    
    ts.take(["sem", "empty"])
    puts "producer produced: #{count}"
    ts.take(["buf", Numeric])
    ts.write(["buf", count ])
    ts.write(["sem", "full"])
    count += 1
end
