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

while true do
  ts.take(["sem", "empty"])
  puts "producer produced: #{count}"
  ts.take(["buf", Numeric])
  ts.write(["buf", count ])
  ts.write(["sem", "full"])
  count += 1
end
