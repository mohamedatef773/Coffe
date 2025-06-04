import 'package:coffee_shope/model/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Coffee coffee;

  const ProductDetailsPage({
    super.key,
    required this.coffee,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xff212325),
      appBar: AppBar(
        backgroundColor: Color(0xff212325),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:
            Icon(Icons.arrow_back_ios, color: Color(0xff5f6163), size: 30),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(coffee.image, fit: BoxFit.cover),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Best Coffee",
                    style: TextStyle(color: Color(0xff46484a), fontSize: 20)),
                Text(
                  coffee.title,
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
                Text(
                  coffee.description,
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 10),
                Text(
                  "Price: \$${coffee.price}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    homeProvider.addToCart(coffee);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${coffee.title} added to cart!"),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decrease Button - only works if item is in cart
                      Consumer<HomeProvider>(
                        builder: (_, homeProvider, __) {
                          int cartQuantity = homeProvider.getCartQuantity(coffee);
                          return IconButton(
                            icon: const Icon(Icons.remove, size: 16, color: Colors.white),
                            onPressed: cartQuantity > 0 ? () {
                              homeProvider.removeFromCart(coffee);
                              if (cartQuantity == 1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${coffee.title} removed from cart!"),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${coffee.title} quantity decreased!"),
                                    backgroundColor: Colors.orange,
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            } : null, // Disabled if not in cart
                          );
                        },
                      ),
                      // Quantity Text - shows cart quantity
                      Consumer<HomeProvider>(
                        builder: (_, homeProvider, __) {
                          int cartQuantity = homeProvider.getCartQuantity(coffee);
                          return Text(
                            cartQuantity.toString(),
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          );
                        },
                      ),
                      // Increase Button - only works if item is in cart
                      Consumer<HomeProvider>(
                        builder: (_, homeProvider, __) {
                          int cartQuantity = homeProvider.getCartQuantity(coffee);
                          return IconButton(
                            icon: const Icon(Icons.add, size: 16, color: Colors.white),
                            onPressed: cartQuantity > 0 ? () {
                              homeProvider.addToCart(coffee);
                            } : null, // Disabled if not in cart
                          );
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212325),
      appBar: AppBar(
        backgroundColor: Color(0xff212325),
        title: Text("Your Cart", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 30,
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (_, value, __) => value.cart.isEmpty
            ? const Center(
          child: Text(
            "Cart is empty",
            style: TextStyle(color: Colors.white),
          ),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.cart.length,
                itemBuilder: (context, index) {
                  Coffee coffee = value.cart[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    color: Color(0xff2a2d30),
                    child: ListTile(
                      leading: Image.asset(coffee.image,
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(coffee.title,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                          "Price: \$${coffee.price} x ${coffee.quantity} = \$${(coffee.price * coffee.quantity).toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.white70)),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black26,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red, size: 18),
                              onPressed: () {
                                int currentQuantity = coffee.quantity;
                                value.removeFromCart(coffee);
                                if (currentQuantity == 1) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${coffee.title} removed from cart!"),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${coffee.title} quantity decreased!"),
                                      backgroundColor: Colors.orange,
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                coffee.quantity.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.green, size: 18),
                              onPressed: () {
                                value.addToCart(coffee);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${coffee.title} quantity increased!"),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Total Price Section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xff2a2d30),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${value.getTotalPrice().toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: value.cart.isNotEmpty ? () {
                      // Handle checkout
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Order placed successfully! Total: \$${value.getTotalPrice().toStringAsFixed(2)}"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } : null,
                    child: Text(
                      "Checkout (\$${value.getTotalPrice().toStringAsFixed(2)})",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
