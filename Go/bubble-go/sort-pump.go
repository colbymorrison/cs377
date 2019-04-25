/*
* CMPU-377 - Parallel Programming
* Spring 2019
* 
* sort-pump.go
* Colby Morrison
*
* This sort pump is a concurrent implementation of bubble sort.
*/

package main

import "fmt"
import "os"
import "strconv"
import "math/rand"

/* 
* Generate and send sequence of random numbers [0..num]  to channel 'ch'.
* (to be run as a goroutine/process)
*
* Parameters:
* - ch: output channel for random numbers
* - kill: output channel to indicate end of random number stream
* - num: length of list and range of random numbers to generate
*/
func randNums(ch chan<- int, kill chan<- bool, num int) {
    rand.Seed(42) // Consistent random numbers
    for i := 0; i < num ; i++{
        i := rand.Intn(num)
        ch <- i
    }
    kill <- true
}

/*
* Pump the values from channel 'src' to channel 'dst',
* holding back the larger of the last two numbers read.
* Terminate when kill signal received / pass along to next cell
* (run as concurrent goroutines / as many as numbers being sorted)
*
* Parameters:
* - src:     read numbers from this channel
* - killIn:  check this channel for kill signal
* - dst:     write smaller number to this channel
* - killOut: pass along kill signal on this channel
*/
func cell(src <-chan int, killIn <-chan bool,
dst chan<- int, killOut chan<- bool) {
    // Get the first number from the channel
    hold := <-src
    var in int
    for{
        select{
        case in = <-src:
            // Compare the number we just recieved with the number we were holding onto
            // and send the larger of the two 
            if in <= hold{
                dst <- in
            }else {
                dst <- hold
                hold = in
            }
        case done := <-killIn:
            // If we've got a kill signal, send out remaining number,
            // pass on the signal, and break the loop
            dst <- hold
            killOut <-done
            break
    }
    }


}

/*
* print out numbers in sorted order
* (to be run as a goroutine/process)
* 
* Parameters:
* - src:     read numbers to be printed from this channel
* - killIn:  check this channel for kill signal
* - killOut: pass along kill signal on this channel
*/
func printSorted(src <-chan int, killIn <-chan bool, killOut chan<- bool) {
    var read int;
    for{
        select{
        case read = <-src:
            // Print out numbers (in sorted order) as we get them
            fmt.Println(read)
        case done := <-killIn:
            // If we get a kill signal, pass it on and break the loop
            killOut <- done
            break
        }
    }
}

/*
* Create the sort pump pipeline consisting of:
* - randNums() process: to generate random numbers into pipeline
* - 'num' cell() processes: to pump numbers through from one cell to next
* - printSorted(): last process in pipeline connected to last cell
*/
func sortPump() {
    src := make(chan int)
    killIn := make(chan bool)
    var dest chan int
    var killOut chan bool

    // You can specify the number of elements to sort as a command line argument,
    // defaults to 1000
    num := 1000
    if(len(os.Args) > 1){
      arg, err := strconv.Atoi(os.Args[1])
      if(err == nil){
        num = arg
      }
    }

    fmt.Printf("Sorting %d elt list\n", num)

    // Make rand num process
    go randNums(src, killIn, num);

    // Make cell processes
    for i:=0; i < num; i++{

       dest = make(chan int)
       killOut = make(chan bool)
       go cell(src, killIn, dest, killOut)
       src = dest
       killIn = killOut
    }

    // Make the last output & printSorted process
    killOut = make(chan bool)
    go printSorted(src, killIn, killOut)

    // Block until we're killed
    <-killOut
}

func main() {
    sortPump()
}
