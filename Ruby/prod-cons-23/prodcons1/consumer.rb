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
b = Array.new(n)
tag, c = ts.read( ["c", Numeric] )

while c < n do
  tag, p = ts.read( ["p", Numeric] )
  if p > c 
    tag, b[c] = ts.take( ["buf", Numeric] )
    puts "consumer: value #{c} consumed: #{b[c]}" 
    tag, c = ts.take( ["c", Numeric] )
    c += 1
    ts.write( ["c", c] ) 
  end
end
