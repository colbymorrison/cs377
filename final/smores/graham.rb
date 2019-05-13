require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

count = 0

while true do
    # Wait to be signaled by the select process
    puts "Waiting for marshmallow and chocolate to be put on the table"
    ts.take(["eat", "g"])
    
    # Grab ingredients off table
    ts.take(["table", "m"])
    ts.take(["table", "c"])
    count += 1
    puts "Adding graham cracker to make s'more"
    puts "Ate s'more! I've eaten #{count} s'mores"

    # Signal select process to select 2 more ingredients
    puts "Graham is done eating, select more ingredients!"
    ts.write(["sem", "select"])
end
