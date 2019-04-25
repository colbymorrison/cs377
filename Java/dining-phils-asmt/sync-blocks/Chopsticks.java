/**
 * Chopsticks class for synchornized code block solution.
 * Colby Morrison
 */
public class Chopsticks {
    private final int PHILS = 5; // Number of philosophers
    private Chopstick[] sticks = new Chopstick[PHILS];

    // Initialize chopstick array in constructor
    public Chopsticks(){
        for(int i = 0; i < PHILS; i++)
            sticks[i] = new Chopstick();
    }

    public Chopstick getLeft(int id){
        return sticks[(id-1) % PHILS];
    }

    public Chopstick getRight(int id){
        return sticks[(id+1) % PHILS];
    }

    // Empty inner class. Objects of this type are synchronized on. 
    public class Chopstick{}
}
