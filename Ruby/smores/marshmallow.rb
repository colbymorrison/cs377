require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

for i in 0..10 do
    # Wait to be signaled by the select process
    puts "Waiting for chocoalte and graham to be put on the table"
    ts.take(["eat", "marshmallow"])
    
    # Grab ingredients off table
    ts.take(["table", "chocolate"])
    ts.take(["table", "graham"])
    puts "Adding marshmallow to make s'more"
    
    # Signal select process to select 2 more ingredients
    puts "Marshmallow is done eating, select more ingredients!"
    ts.write(["sem", "select"])
end