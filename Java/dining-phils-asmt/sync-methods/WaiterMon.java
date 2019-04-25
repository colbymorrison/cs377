/**
 * Colby Morrison
 * Waiter monitor class
 */
public class WaiterMon {
    private int seated;
    private final int MAX = 4; // maximum number of philosophers at the table

    /**
     * Sit down at the table
     */
    public synchronized void sitDown(int id){
        // Wait while there's 4 philosophers at the table
        while(seated == MAX) {
            try {
                wait();
            } catch (InterruptedException e) {}
        }
        // Sit down!
        seated++;
    }

    /**
     * Stand up method
     */
    public synchronized void standUp(int id){
        seated--;
        // Notify all waiting philosophers if there's now room
        if(seated < MAX)
            notifyAll();
    }
}
