require 'rinda/rinda'

#
# cs377
# fall 2016
# Producer-Consumer v1
# Solution
# Marc Smith
# consumer.rb
#
 
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

while true do
  ts.take( ["sem", "full"] )
  tag, result = ts.read(["buf", Numeric])
  puts "Consumer got #{result}"
  ts.write( ["sem", "empty"] )
end
