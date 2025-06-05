import 'package:coffee_shope/model/coffee.dart';
import 'package:coffee_shope/views/cart_screen.dart';
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
                MaterialPageRoute(builder: (context) => CartScreen()),
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
                    homeProvider.addToCart(coffee, coffee.quantity);
                    homeProvider.resetQuantity(coffee);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decrease Button - only works if item is in cart
                      IconButton(
                        icon: const Icon(Icons.remove,
                            size: 16, color: Colors.white),
                        onPressed: () {
                          homeProvider.decrementQuantity(coffee);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content:
                          //         Text("${coffee.title} removed from cart!"),
                          //     backgroundColor: Colors.red,
                          //     duration: Duration(seconds: 2),
                          //     behavior: SnackBarBehavior.floating,
                          //   ),
                          // );
                        }, // Disabled if not in cart
                      ),
                      // Quantity Text - shows cart quantity
                      Consumer<HomeProvider>(
                        builder: (_, __, ___) {
                          return Text(
                            coffee.quantity.toString(),
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          );
                        },
                      ),
                      // Increase Button - only works if item is in cart
                      IconButton(
                        icon: const Icon(Icons.add,
                            size: 16, color: Colors.white),
                        onPressed: () {
                          homeProvider.incrementQuantity(coffee);
                        }, // Disabled if not in cart
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
