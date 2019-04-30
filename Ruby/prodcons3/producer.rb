require 'rinda/rinda'

#
# cs377
# fall 2016
# Producer-Consumer v1
# Solution
# Marc Smith
# producer.rb
#
#
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

count = 0
tag, n = ts.read(["n", Numeric])

while true do
  ts.take(["sem", "empty"])
  tag, rear = ts.take(["rear", Numeric])

  puts "producer produced: #{count} at index #{rear}"

  ts.write(["buf", rear, count])

  ts.write(["rear",(rear+1)%n]) 

  ts.write(["sem", "full"])
  count += 1
end
