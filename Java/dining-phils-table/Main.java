/**
 * This is the main program to demonstrate 
 * a monitor solution to the Dining Philosophers 
 * problem in Java.  It uses threads and Java's
 * object synchronization mechanism.
 * 
 * @author Marc L. Smith
 * @version 1.0
 */
public class Main
{
    /*
     * The main method for the Main class
     */
    public static void main(String[] arg)
    {
      // Create the philosophers' table (the monitor)
      TableMon table = new TableMon();

      // Create and start the philosophers (threads)
      for (int i=1; i <= 5; i++) {
        new Philosopher(i, table).start();
      }
    }
}

