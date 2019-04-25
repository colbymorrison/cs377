/**
 * This class implements a dining philosopher in the synchronized
 * code blocks solution.
 *
 * @author Colby Morrison
 * @version 1.0
 */
public class Philosopher extends Thread {
    // instance variables 
    private int id;          // PhilosopherMethods's unique identifier
    private Chopsticks chopsticks;

    /**
     * Constructor for PhilosopherMethods objects
     */
    public Philosopher(int id, Chopsticks chopsticks) {
        // initialize instance variables
        this.id = id;
        this.chopsticks = chopsticks;
    }


    /*
     * A dining philosopher's behavior
     * is to eat and think -- forever!
     */
    public void run() {
        // don't all start in order of creation!
        this.delay(this.randomInt());

        while (true) {
            // Even number philosophers pick up left right
            if(this.id % 2 == 0){
                synchronized (chopsticks.getLeft(this.id)) {
                    // Has left chopstick
                    synchronized (chopsticks.getRight(this.id)) {
                        // Has both chopsticks, eat!
                        System.out.println("Philosopher " + this.id + " eating...");
                        this.delay(this.randomInt()); // chew your food!
                    }
                }
            }
            // Odd number philosophers pick up right left
            else{
                synchronized (chopsticks.getRight(this.id)) {
                    // Has right chopstick
                    synchronized (chopsticks.getLeft(this.id)) {
                        // Has both chopsticks, eat!
                        System.out.println("Philosopher " + this.id + " eating...");
                        this.delay(this.randomInt()); // chew your food!
                    }
                }
            }
            System.out.println("BURP! (Philosopher " + this.id + ")");
            // Done eating, think!
            System.out.println("Philosopher " + id + " thinking...");
            this.delay( this.randomInt() ); // can't rush genius!
        }
    }

    /**
     * Returns a random integer.
     */
    public int randomInt() {
        double r = Math.random();
        return (int) Math.floor(r * 100) + 1;
    }

    /**
     * Simulates a philosopher pausing for a given amount of time.
     */
    public void delay(int mSec) {
        try {
            Thread.sleep(mSec);
        } catch (InterruptedException ex) {
        }
    }
}

