/*
* CMPU-377 - Parallel Programming
* Spring 2019
*
* water.go
* Colby Morrison
*
* Solution to the water molecules problem.
 */

package main

import "fmt"
import "sync"

// Infinitley creates hydrogen atoms
func hydrogen(water chan<- bool, log chan<- string) {
	for {
		// Signal the molecule process a hydrogen has been created
		// and send a message to the waterlog
		water <- true
		log <- "Hydrogen created"
	}
}

// Infinitley creates oxygen atoms
func oxygen(water chan<- bool, log chan<- string) {
	for {
		// Signal the molecule process an oxygen has been created
		// and send a message to the waterlog
		water <- true
		log <- "Oxygen created"
	}
}

// Creates water molecules as hydrogen and oxygen are created
func molecule(h1 <-chan bool, h2 <-chan bool, o <-chan bool, log chan<- string) {
	// Keep a count of how many hydrogens and oxygens we currently have
	hCount := 0
	oCount := 0
	for {
		// Increment the counts whenever a new atom is created
		select {
		case <-h1:
			hCount++
		case <-h2:
			hCount++
		case <-o:
			oCount++
		}
		// If we have enough H and O, create water and decrement the counters
		if hCount >= 2 && oCount >= 1 {
			log <- fmt.Sprintf("Created Water, hCount %d, oCount %d", hCount, oCount)
			hCount -= 2
			oCount--
		}
	}
}

// Multiplexes the log messages from the other processes, printing the messages
// as they are recieved
func waterLog(h1 <-chan string, h2 <-chan string, o <-chan string, molecule <-chan string) {
	var message string

	for {
		// Print the messages as they come in
		select {
		case message = <-h1:
			fmt.Println(message, "from hydrogen process 1")
		case message = <-h2:
			fmt.Println(message, "from hydrogen process 2")
		case message = <-o:
			fmt.Println(message)
		case message = <-molecule:
			fmt.Println(message)
		}
	}
}

// Creates process pipeline
func makeWater() {
	// Get a WaitGroup object so we don't return before our goroutines
	var wg sync.WaitGroup
	// Add 1 to the wg counter
	wg.Add(1)

	// Make channels for the hydrogen and oxygen to signal the molecule process
	makeH1 := make(chan bool)
	makeH2 := make(chan bool)
	makeO := make(chan bool)

	// Make channels for the processes to send messages to the waterlog
	outH1 := make(chan string)
	outH2 := make(chan string)
	outO := make(chan string)
	outMol := make(chan string)

	// Start the goroutines with the correct channels
	go hydrogen(makeH1, outH1)
	go hydrogen(makeH2, outH2)
	go oxygen(makeO, outO)
	go molecule(makeH1, makeH2, makeO, outMol)
	go waterLog(outH1, outH2, outO, outMol)

	// Wait until counter is 0, but none of the goroutines decrement the counter,
	// so the program runs infinitley
	wg.Wait()
}

// Main method
func main() {
	makeWater()
}
