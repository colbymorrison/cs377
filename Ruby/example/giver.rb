require 'rinda/rinda'

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI)) # ts object at the URI
tuples = [["*", 2, 2 ], [ "+", 2, 5 ], [ "-", 9, 3 ]]
tuples.each do |t|
    puts "giver: looping..."
    ts.write(t)
    res = ts.take(["result", nil]) # Blocks if there is no "result" tuple in ts
    puts "#{res[1]} = #{t[1]} #{t[0]} #{t[2]}"
end
