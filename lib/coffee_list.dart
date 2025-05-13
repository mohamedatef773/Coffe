import 'package:coffee_shope/product_detalis.dart';
import 'package:flutter/material.dart';

var fakeData = {
  "data": [
    {
      "title": "Latte",
      "image": "Latte.png",
      "subTitle": "Best coffee",
      "description":
          "Hot coffee is a steaming beverage brewed from roasted coffee beans. The dark, aromatic liquid offers a stimulating caffeine kick and a rich, slightly bitter taste.",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
    {
      "title": "Espresso",
      "image": "Espresso.png",
      "description":
          "Hot coffee is a steaming beverage brewed from roasted coffee beans. The dark, aromatic liquid offers a stimulating caffeine kick and a rich, slightly bitter taste.",
      "subTitle": "Best coffee",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
    {
      "title": "BlackCoffee",
      "image": "BlackCoffee.png",
      "description":
          "Hot coffee is a steaming beverage brewed from roasted coffee beans. The dark, aromatic liquid offers a stimulating caffeine kick and a rich, slightly bitter taste.",
      "subTitle": "Best coffee",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
    {
      "title": "Cold Coffee",
      "description":
          "Cold coffee is a delicious iced beverage brewed from coffee beans.",
      "image": "ColdCoffee.png",
      "subTitle": "Best coffee",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
    {
      "title": "Latte",
      "image": "Latte.png",
      "subTitle": "Best coffee",
      "description":
      "Hot coffee is a steaming beverage brewed from roasted coffee beans. The dark, aromatic liquid offers a stimulating caffeine kick and a rich, slightly bitter taste.",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
    {
      "title": "Espresso",
      "image": "Espresso.png",
      "description":
      "Hot coffee is a steaming beverage brewed from roasted coffee beans. The dark, aromatic liquid offers a stimulating caffeine kick and a rich, slightly bitter taste.",
      "subTitle": "Best coffee",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
    {
      "title": "BlackCoffee",
      "image": "BlackCoffee.png",
      "description":
      "Hot coffee is a steaming beverage brewed from roasted coffee beans. The dark, aromatic liquid offers a stimulating caffeine kick and a rich, slightly bitter taste.",
      "subTitle": "Best coffee",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
    {
      "title": "Cold Coffee",
      "description":
      "Cold coffee is a delicious iced beverage brewed from coffee beans.",
      "image": "ColdCoffee.png",
      "subTitle": "Best coffee",
      "quantity": 0,
      "isFav": false,
      "price": "30",
    },
  ]
};

class CoffeeList extends StatelessWidget {
  const CoffeeList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> coffeeList =
        List<Map<String, dynamic>>.from(fakeData["data"] ?? []);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8, // Ensures a better proportion
        crossAxisSpacing: 10, // Adds spacing between grid items
        mainAxisSpacing: 10, // Adds spacing between rows
      ),
      itemCount: coffeeList.length,
      itemBuilder: (context, index) {
        var item = coffeeList[index];
        return CoffeeCard(
          title: item["title"] ?? "",
          image: item["image"] ?? "",
          price: item["price"] ?? "",
          subTitle: item["subTitle"] ?? "",
          description: item["description"] ?? "",
        );
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String title, image, subTitle, price ,description;

  const CoffeeCard({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10), // Adds spacing around each card
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(title: title, image: image, subTitle: subTitle, price: price, description: description,),));
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff212325),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: const Offset(3, 3),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Allows the image to take available space
                child: Center(
                  child: Image.asset(
                    image,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(subTitle,
                        style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$$price",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.add, color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
