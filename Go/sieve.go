/*
 * Sieve of Eratosthenes (Prime Number Sieve)
 * Source: https://golang.org/ref/spec#An_example_package
 *
 * This is a concurrent implementation of a prime number sieve.
 */

package main

import "fmt"

// Send the sequence 2, 3, 4, ... to channel 'ch'.
// (this function will be launched as a goroutine/process)
// chan<- means we're writing to the channel
func generate(ch chan<- int) {
  for i := 2; ; i++ {
    ch <- i  // Send 'i' to channel 'ch'.
  }
}

// Copy the values from channel 'src' to channel 'dst',
// removing those divisible by 'prime'.
// (many instances of this function will be launched as goroutines,
//  as sieves representing each successive prime number)
func filter(src <-chan int, dst chan<- int, prime int) {
  for i := range src {  // Loop over values received from 'src', the last filter, i.e. all numbers not a multiple
                        // of all previous primes
    if i%prime != 0 {
      dst <- i  // Send 'i' to channel 'dst'.
    }
  }
}

// The prime sieve: Daisy-chain filter processes together.
func sieve() {
  ch := make(chan int)  // Create a new channel.
  go generate(ch)       // Start generate() as a subprocess.
  for {
    prime := <-ch
    fmt.Print(prime, "\n")
    ch1 := make(chan int)
    go filter(ch, ch1, prime) // goroutine to filter multiples of prime
    ch = ch1
  }
}

func main() {
  sieve()
}
