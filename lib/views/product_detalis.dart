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
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);

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
                  onPressed: () => provider.addToCart(coffee),
                  child: Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
        title: Text("Your Cart"),
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
            : ListView.builder(
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
                          "Price: \$${coffee.price} x ${coffee.quantity}",
                          style: const TextStyle(color: Colors.white70)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.red),
                            onPressed: () => value.removeFromCart(coffee),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.green),
                            onPressed: () => value.addToCart(coffee),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
