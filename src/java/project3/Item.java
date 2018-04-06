package project3;

/**
 *
 * @author stephen mottram
 */
public class Item {
    
    private String name;
    private int price;
    
    public Item(String n, int p) {
        this.name = n;
        this.price = p;
    }
    
    public void setName(String n) {
        this.name = n;
    }
    
    public String getName() {
        return this.name;
    }
    
    public int getPrice() {
        return this.price;
    }
    
    public void setPrice(int p) {
        this.price = p;
    }
    
    
}
