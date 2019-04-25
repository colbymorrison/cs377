/**
 * This is the main program to demonstrate 
 * a monitor solution to the Dining Philosophers 
 * problem in Java.  It uses threads and Java's
 * syncrhonized code blocks. 
 * 
 * @author Colby Morrison
 * @version 1.0
 */
public class Main
{
    /*
     * The main method for the MainMethods class
     */
    public static void main(String[] arg)
    {
      // Create the philosophers' chopstick object
      Chopsticks chopsticks = new Chopsticks();

      // Create and start the philosophers (threads)
      for (int i=1; i <= 5; i++) 
        new Philosopher(i, chopsticks).start();
    }
}

