package project3;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author stephen mottram
 */
public class CartBean implements Serializable {
    private ArrayList<Item> cart;
    

    public CartBean() {
        cart = new ArrayList();
    }
    
    public void addToCart(Item i) {
        if (cart == null) {
            System.out.println("cart is null within CartBean");
        }
        cart.add(i);
    }
    
    public void removeFromCart(Item item) {
        for (int i = 0; i<= cart.size(); i++)
        {
            if (cart.get(i).getName().equals(item.getName())) //removes first instance of item from cart
            {
                cart.remove(i);
                break;
            }
        }
    }
    
    public ArrayList<Item> getCart()
    {
        return this.cart;
    }
    
}
