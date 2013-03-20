Project 2: Shopping Cart
========================

### Heroku URL

Please put it here: http://sheltered-ocean-2111.herokuapp.com

### Upgrades for phase 2.3
- Completely removed YAML. Introduced model "OrderItems" instead to replace what used to be done by YAML.
- Users can now construct shopping lists, save cart to a list, and import list to a cart.
- Introduced concept of Category. Users can search items by categories
- CartItemJoins has been refactored to CartItems
- Administrator status introduced. Apart from shoppers and shopkeepers, they are maintaining the site


### Notes

I have created few accounts & Item entries & orders for simulation

Here are account information (email,password,status)
1. (admin@mit.edu, 1234, administrator)
2. (a@mit.edu, 1234, shopper)
3. (b@mit.edu, 1234, shopper)
4. (c@mit.edu, 1234, shopper)
5. (d@mit.edu, 1234, shopkeeper)
6. (e@mit.edu, 1234, shopkeeper)
7. (f@mit.edu, 1234, shopkeeper)

- Shopkeepers can only modify & edit items through "Details" link
- When Shoppers want to remove items from the cart, just updating quantity to 0 will suffice


###PDF Deliverables

There are 3 deliverables for comparison. The most recent one (for Proj 2.3) is "Design Analysis for Shopping Cart Application_Andrew Song_final"
Almost the whole document was revised, especially "Shopping cart OMD", wireframes for UIs, and design challenges.
