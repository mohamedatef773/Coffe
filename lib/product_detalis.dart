import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String title, image, subTitle, price, description;

  ProductDetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
    required this.price,
    required this.description,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  void addToCart() {
    Cart.items.add({
      'title': widget.title,
      'image': widget.image,
      'price': widget.price,
      'quantity': 1,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.title} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: Icon(Icons.arrow_back_ios, color: Color(0xff5f6163), size: 30),
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
          Image.asset(widget.image, fit: BoxFit.cover),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Best Coffee", style: TextStyle(color: Color(0xff46484a), fontSize: 20)),
                Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 50)),
                Text(widget.description, style: TextStyle(color: Colors.white70)),
                SizedBox(height: 10),
                Text("Price: \$${widget.price}", style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: addToCart,
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

class Cart {
  static List<Map<String, dynamic>> items = [];
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(int index) {
    setState(() {
      Cart.items.removeAt(index);
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      Cart.items[index]['quantity'] += 1;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (Cart.items[index]['quantity'] > 1) {
        Cart.items[index]['quantity'] -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212325),
      appBar: AppBar(
        backgroundColor: Color(0xff212325),
        title: Text("Your Cart"),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },color: Colors.white, icon:Icon(Icons.arrow_back_ios_new_rounded) ,iconSize: 30,),
      ),
      body: Cart.items.isEmpty
          ? Center(child: Text("Cart is empty", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: Cart.items.length,
        itemBuilder: (context, index) {
          final item = Cart.items[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: Color(0xff2a2d30),
            child: ListTile(
              leading: Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(item['title'], style: TextStyle(color: Colors.white)),
              subtitle: Text("Price: \$${item['price']} x ${item['quantity']}",
                  style: TextStyle(color: Colors.white70)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.red),
                    onPressed: () => decreaseQuantity(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.green),
                    onPressed: () => increaseQuantity(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () => removeFromCart(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
