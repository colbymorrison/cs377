#
# cs377
# S'mores Problem
# Colby Morrison
# select.rb
#
# Select process, this is the child that doesn't eat

require 'rinda/rinda'

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

ingredients = Array["chocolate", "graham", "marshmallow"]

while true do 
    # Grab select semaphore
    ts.take(["sem", "select"])

    #Get 2 random ingredients
    ig1, ig2 = ingredients.sample(2)
    
    # ig3 is the ingredient we didn't get
    ig3 = (ingredients - Array[ig1, ig2])[0]

    # Put first 2 ingredients on the table
    puts "putting #{ig1} and #{ig2} on the table"
    ts.write(["table", ig1])
    ts.write(["table", ig2])

    # Signal correct process its time to eat
    puts "Signaling #{ig3} to eat"
    ts.write(["eat", ig3])
end

