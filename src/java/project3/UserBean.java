/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project3;

import java.io.Serializable;

/**
 *
 * @author stephen mottram
 */
public class UserBean implements Serializable {
   
    private boolean loggedIn;
    private int permissions;
    private String username;
    private String firstname;
    private String lastname;
    
    public UserBean() {
        this.loggedIn = false;
        this.permissions = 0;
        this.username = "Guest";
        this.firstname = "";
        this.lastname = "";
    }
    
    public UserBean(Users user) {
        this.loggedIn = true;
        this.username = user.getUsername();
        this.firstname = user.getFirstName();
        this.lastname = user.getLastName();
        this.permissions = user.getPermissions();
    }
    
    public void setLoggedIn(boolean b) {
        this.loggedIn = b;
    }
    
    public boolean isLoggedIn() {
        return this.loggedIn;
    }
    
    public void setPermissions(int i) {
        this.permissions = i;
    }
    
    public int getPermissions() {
        return this.permissions;
    }
    
    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String s) {
        this.username=s;
    }
    
    public void setFirstName(String s ) {
        this.firstname = s;
    }
    
    public String getFirstName() {
        return this.firstname;
    }
    
        public void setLastName(String s ) {
        this.lastname = s;
    }
    
    public String getLastName() {
        return this.lastname;
    }
}
