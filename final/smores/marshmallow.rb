require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

count = 0

while true do
    # Wait to be signaled by the select process
    puts "Waiting for chocoalte and graham to be put on the table"
    ts.take(["eat", "m"])
    
    # Grab ingredients off table
    ts.take(["table", "c"])
    ts.take(["table", "g"])
    count += 1
    puts "Adding marshmallow to make s'more"
    puts "Ate s'more! I've eaten #{count} s'mores"
    
    # Signal select process to select 2 more ingredients
    puts "Marshmallow is done eating, select more ingredients!"
    ts.write(["sem", "select"])
end
