/*
 * CMPU-377
 * 
 * Go implementation of Dining Philosophers
 * This and more example Go programs found at: 
 * https://godoc.org/github.com/thomas11/csp
 * (last accessed: 4/1/2019)
 */

package main

import (
  "fmt"
  "time"
)

// 5.3 Dining Philosophers (Problem due to E.W. Dijkstra)
//
// > "Problem: Five philosophers spend their lives thinking and eating. The
// philosophers share a common dining room where there is a circular table
// surrounded by five chairs, each belonging to one philosopher. In the
// center of the table there is a large bowl of spaghetti, and the table is
// laid with five forks (see Figure 1). On feeling hungry, a philosopher
// enters the dining room, sits in his own chair, and picks up the fork on
// the left of his place. Unfortunately, the spaghetti is so tangled that
// he needs to pick up and use the fork on his right as well. When he has
// finished, he puts down both forks, and leaves the room. The room should
// keep a count of the number of philosophers in it."
//
// The dining philosophers are famous in Computer Science because they
// illustrate the problem of deadlock. As Hoare explains, "The solution
// given above does not prevent all five philosophers from entering the
// room, each picking up his left fork, and starving to death because he
// cannot pick up his right fork."

func S53_DiningPhilosophers(runFor time.Duration) {

	// The room is a goroutine that listens on a channel to signal "enter"
	// and one to signal "exit".
	enterRoom := make(chan int)
	exitRoom := make(chan int)
	room := func() {
		occupancy := 0
		for {
			select {
			case i := <-enterRoom:
				if occupancy < 4 {
					occupancy++
				} else {
					// If all philosophers sit down to eat, they starve.
					// Wait for someone to leave.
					fmt.Printf("%v wants to enter, but must wait.\n", i)
					<-exitRoom
					// Enter the room, occupancy stays the same.
					fmt.Printf("%v can finally enter!\n", i)
				}
			case <-exitRoom:
				occupancy--
			}
		}
	}

	// The forks are goroutines listening to pickup and putdown channels
	// like the room, but we need one channel per philosopher to
	// distinguish them so that we can match pickup and putdown of a fork.
	pickup := make([]chan int, 5)
	putdown := make([]chan int, 5)
	for i := 0; i < 5; i++ {
		pickup[i] = make(chan int)
		putdown[i] = make(chan int)
	}
	fork := func(i int) {
		for {
			select {
			case <-pickup[i]:
				<-putdown[i]
			case <-pickup[abs(i-1)%5]:
				<-putdown[abs(i-1)%5]
			}
		}
	}

	// Thinking and eating are sleeps followed by a log message so we know
	// what's going on.
	think := func(i int) {
		time.Sleep(2 * time.Second)
		fmt.Printf("%v thought.\n", i)
	}
	eat := func(i int) {
		time.Sleep(1 * time.Second)
		fmt.Printf("%v ate.\n", i)
	}

	// A philosopher leads a simple life.
	philosopher := func(i int) {
		for {
			think(i)
			enterRoom <- i
			pickup[i] <- i
			pickup[(i+1)%5] <- i
			eat(i)
			putdown[i] <- i
			putdown[(i+1)%5] <- i
			exitRoom <- i
		}
	}

	// Launch the scenario.
	go room()
	for i := 0; i < 5; i++ {
		go fork(i)
	}
	for i := 0; i < 5; i++ {
		go philosopher(i)
	}

	time.Sleep(runFor)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func main() {
  S53_DiningPhilosophers(time.Minute)
}
