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

tag, n = ts.read( ["n", Numeric] ) 

a = Array.new(n)
n.times do |i|
  a[i] = i*5
end

tag, p = ts.read( ["p", Numeric] )
while p < n do
  tag, c = ts.read( ["c", Numeric] )
  if p == c 
    ts.write( ["buf", a[p]] )
    puts "producer: value #{p} produced: #{a[p]}"
    tag, p = ts.take( ["p", Numeric]) 
    p += 1
    ts.write( ["p", p] ) 
  end
end
