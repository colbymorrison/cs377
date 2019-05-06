#! /bin/bash
killall ruby
ruby ~/cs377/Ruby/server.rb &
# Let server get started
sleep 1
ruby ~/cs377/Ruby/prodcons3/init-ts.rb
