/**
 * This is the main program to demonstrate 
 * a monitor solution to the Dining Philosophers 
 * problem in Java.  It uses threads and Java's
 * synchronized methods.
 * 
 * @author Colby Morrison
 * @version 1.0
 */
public class MainMethods
{
    /*
     * The main method for the MainMethods class
     */
    public static void main(String[] arg)
    {
      // Create the philosophers' waiter monitor
      WaiterMon waiter = new WaiterMon();

      // Create and start the philosophers (threads)
      for (int i=1; i <= 5; i++) {
        new PhilosopherMethods(i, waiter).start();
      }
    }
}

