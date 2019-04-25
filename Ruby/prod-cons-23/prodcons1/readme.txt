cs377
Spring 2013
Assign6
Ruby/Rinda Producer-Consumer v1
Solution by: Marc Smith

Description:
One producer, one consumer, single buffer

Caution: 
Do not run on mote, or your programs could interfere with each other!

Individual scripts:
* server.rb - creates the Rinda Tuple Space for other rinda processes
* init-ts.rb - process to initialize tuples in TS
* producer.rb - implementation of the producer process
* consumer.rb - implementation of the consumer process

How to run/test:
Run each script in a separate shell on the same workstation
(not mote!). You may find it convenient to use multiple tabs in 
the terminal program, as I demo'd in class.
Run the scripts using the 'ruby' command, in this order:
1. $ ruby server.rb
2. $ ruby init-ts.rb
3. $ ruby producer.rb
4. $ ruby consumer.rb

Advice:
When getting your program to work, you may find that you have to kill
your programs in various tabs. To do this, use the <Ctrl> <c> keystroke
combination.

Kill and restart the server.rb each time you want to retest your program.