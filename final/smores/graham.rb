#
# cs377
# S'mores Problem
# Colby Morrison
# graham.rb
#
# Graham cracker process

require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# Count of how many s'mores we've eaten
count = 0

while true do
    # Wait to be signaled by the select process
    puts "Waiting for marshmallow and chocolate to be put on the table"
    ts.take(["eat", "graham"])
    
    # Grab ingredients off table
    ts.take(["table", "marshmallow"])
    ts.take(["table", "chocolate"])

    # Increment count
    count += 1

    puts "Adding graham cracker to make s'more"
    puts "Ate s'more! I've eaten #{count} s'mores"

    # Signal select process to select 2 more ingredients
    puts "Graham is done eating, select more ingredients!"
    ts.write(["sem", "select"])
end
