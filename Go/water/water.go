package main

import "fmt"
import "sync"


func hydrogen(water chan<- bool, log chan<- string){
	for {
		// Infinitley create new hydrogen atoms
		water <- true
		log <- "Hydrogen created"
	}
}

func oxygen(water chan<- bool, log chan<- string){
	for {
		// Infinitley create new oxygen atoms
		water <- true
		log <- "Oxygen created"
	}
}

func molecule(h1 <-chan bool, h2 <-chan bool, o <-chan bool, log chan<- string){
	hCount := 0
	oCount := 0
	for {
		select{
		case <-h1:
			hCount++
		case <-h2:
			hCount++;
		case <-o:
			oCount++;
		}
		if(hCount >= 2 && oCount >= 1){
			log <- fmt.Sprintf("Created Water, hCount %d, oCount%d", hCount, oCount)
			hCount -= 2
			oCount -= 1
		}
	}
}

func waterLog(h1 <-chan string, h2 <-chan string, o <-chan string, molecule <-chan string){
	var message string

	for{
		select{
		case message = <- h1:
			fmt.Println(message, "from hydrogen process 1")
		case message = <- h2:
			fmt.Println(message, "from hydrogen process 2")
		case message = <- o:
			fmt.Println(message)
		case message = <- molecule:
			fmt.Println(message)
		}
	}
}

/*
* Create process pipeline
*/
func makeWater(){
	var wg sync.WaitGroup
	wg.Add(4) 

	makeH1 := make(chan bool)
	makeH2 := make(chan bool)
	makeO := make(chan bool)

	outH1 := make(chan string)
	outH2 := make(chan string)
	outO := make(chan string)
	outMol := make(chan string)

	go hydrogen(makeH1, outH1)
	go hydrogen(makeH2, outH2)
	go oxygen(makeO, outO)
	go molecule(makeH1, makeH2, makeO, outMol)
	go waterLog(outH1, outH2, outO, outMol)

	wg.Wait() // wait until counter is 0, but none of the goroutines decrement it so we let them run
}

func main(){
	makeWater()
}