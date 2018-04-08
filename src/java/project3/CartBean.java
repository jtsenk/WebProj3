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
    
    public void addToCart(Item item) {
        int quantity = item.getQuantity();
        for (int i = 0; i< cart.size(); i++)
        {
            if (cart.get(i).getName().equals(item.getName())) //gets quantities from other instances of item in cart, removes old instances
            {
                quantity += cart.get(i).getQuantity();
                cart.remove(i);
            }
        }
        Item newItem = new Item(item.getName(),quantity);   //new object with all old quantities added together so there aren't like 3 of the same item with different quantities
        cart.add(newItem);
    }
    
    public void removeFromCart(String name) {
        for (int i = 0; i<= cart.size(); i++)
        {
            if (cart.get(i).getName().equals(name)) //removes first instance of item from cart
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
    
    public void clearCart() {
        this.cart.clear();
    }
    
}
