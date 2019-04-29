#! /bin/bash
killall ruby
ruby ~/school/cs377/Ruby/server.rb &
sleep 10
ruby ~/school/cs377/Ruby/prodcons2/init-ts.rb
