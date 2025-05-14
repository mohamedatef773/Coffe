import 'package:coffee_shope/views/product_detalis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_provider.dart';
import '../model/coffee.dart';

class CoffeeList extends StatelessWidget {
  final String category;

  const CoffeeList({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    List<Coffee> coffees = Provider.of<HomeProvider>(context, listen: false)
        .filterCoffees(category);
    // Consumer == GetBuilder in GetX
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8, // Ensures a better proportion
        crossAxisSpacing: 10, // Adds spacing between grid items
        mainAxisSpacing: 10, // Adds spacing between rows
      ),
      itemCount: coffees.length,
      itemBuilder: (context, index) {
        var coffee = coffees[index];
        return CoffeeCard(
          coffee: coffee,
        );
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;

  const CoffeeCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10), // Adds spacing around each card
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  coffee: coffee,
                ),
              ));
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
                    coffee.image,
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
                      coffee.title,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(coffee.subTitle,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${coffee.price}",
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
