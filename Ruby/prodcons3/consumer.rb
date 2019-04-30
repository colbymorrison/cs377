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

tag, n = ts.read( ["n", Numeric] )

while true do
  ts.take( ["sem", "full"] )
  tag, front = ts.take( ["front", Numeric] )

  tag, index, result = ts.take(["buf", front, Numeric])
  puts "Consumer got #{result} at index #{front}"

  ts.write( ["front", (front+1)%n] )
  ts.write( ["sem", "empty"] )

end
