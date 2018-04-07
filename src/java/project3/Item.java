package project3;

/**
 *
 * @author stephen mottram
 */
public class Item {
    
    private String name;
    private int quantity;
    
    public Item(String n, int q) {
        this.name = n;
        this.quantity = q;
    }
    
    public void setName(String n) {
        this.name = n;
    }
    
    public String getName() {
        return this.name;
    }
    
    public int getQuantity() {
        return this.quantity;
    }
    
    public void setQuantity(int q) {
        this.quantity = q;
    }
    
    
}
