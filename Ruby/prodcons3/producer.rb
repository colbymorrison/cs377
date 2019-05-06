require 'rinda/rinda'

#
# cs377
# Producer-Consumer v3
# Solution
# Colby Morrison
# producer.rb
#
#
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

count = 0
tag, n = ts.read(["n", Numeric])

while true do
    # P(empty);
    # buf[rear] = data;
    # rear = (rear+1)%n;
    # V(full); 
    #
    ts.take(["sem", "empty"])
    tag, rear = ts.take(["rear", Numeric])

    puts "producer produced: #{count} at index #{rear}"

    ts.write(["buf", rear, count])

    ts.write(["rear",(rear+1)%n]) 

    ts.write(["sem", "full"])
    count += 1
end
