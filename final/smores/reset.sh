#! /bin/bash
killall ruby
ruby ~/school/cs377/Ruby/server.rb &
# Let server get started
sleep 1
ruby ~/school/cs377/final/smores/init-ts.rb
