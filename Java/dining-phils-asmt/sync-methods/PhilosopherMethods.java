/**
 * This class implements a dining philosopher in the 
 * synchronized methods solution.
 * 
 * @author Marc L. Smith
 * @version 1.0
 */
public class PhilosopherMethods extends Thread
{
    // instance variables 
    private int id;          // PhilosopherMethods's unique identifier
    private WaiterMon waiter; // Waiter

    /**
     * Constructor for PhilosopherMethods objects
     */
    public PhilosopherMethods(int id, WaiterMon waiter)
    {
      // initialize instance variables
      this.id = id;
      this.waiter = waiter;
    }


    /*
     * A dining philosopher's behavior 
     * is to eat and think -- forever!
     */ 
    public void run()
    {
      // don't all start in order of creation!
      this.delay( this.randomInt() );
	  
      while (true) {

        // try and sit down
         waiter.sitDown(this.id);

        // eat
        System.out.println("Philosopher " + this.id + " eating...");
        this.delay( this.randomInt() ); // chew your food!

        // Finished eating, so stand up
        waiter.standUp(this.id);
        System.out.println("BURP! (Philosopher " + this.id + ")");

        // think
        System.out.println("Philosopher " + id + " thinking...");
        this.delay( this.randomInt() ); // can't rush genius!
      }
    }

    /**
     * Returns a random integer.
     */
    public int randomInt() {
      double r = Math.random();
      return (int) Math.floor( r * 100 ) + 1;
    }

    /**
     * Simulates a philosopher pausing for a given amount of time.
     */
    public void delay(int mSec) {
      try {
        Thread.sleep(mSec);
      } catch (InterruptedException ex) {}
    }
}

