require 'rinda/rinda'
 
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))
loop do
    puts "taker looping..."
      ops, a, b = ts.take([ %r{^[-+/*]$}, Numeric, Numeric])
        ts.write(["result", a.send(ops, b)])
end
