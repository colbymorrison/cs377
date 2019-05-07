require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

while true do
    # Wait to be signaled by the select process
    puts "Waiting for graham and marshmallow to be put on the table"
    ts.take(["eat", "chocolate"])

    # Grab ingredients off table
    ts.take(["table", "graham"])
    ts.take(["table", "marshmallow"])
    puts "Adding chocolate to make s'more"

    # Signal select process to select 2 more ingredients
    puts "Chocolate is done eating, select more ingredients!"
    ts.write(["sem", "select"])
end



