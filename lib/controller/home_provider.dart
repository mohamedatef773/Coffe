import 'package:coffee_shope/model/coffee.dart';
import 'package:flutter/material.dart';

import '../model/data.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    loadCoffees();
  }

  List<Coffee> coffees = [];
  List<Coffee> cart = [];

  void addToCart(Coffee coffee) {
    // Find if this coffee already exists in cart
    int index = cart.indexWhere((item) => item.title == coffee.title);

    if (index != -1) {
      // If coffee exists in cart, increase its quantity
      cart[index].quantity++;
    } else {
      // If coffee doesn't exist in cart, create a copy with quantity 1
      Coffee newCoffee = Coffee(
        title: coffee.title,
        description: coffee.description,
        price: coffee.price,
        image: coffee.image,
        category: coffee.category,
        quantity: 1,
        subTitle: coffee.subTitle ?? '', // Start with quantity 1
      );
      cart.add(newCoffee);
    }
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    int index = cart.indexWhere((item) => item.title == coffee.title);
    if (index != -1) {
      if (cart[index].quantity == 1) {
        cart.removeAt(index);
      } else {
        cart[index].quantity--;
      }
    }
    notifyListeners();
  }

  void loadCoffees() {
    List data = fakeData["data"] ?? [];

    for (var itemMap in data) {
      Coffee coffee = Coffee.fromMap(itemMap);
      // Ensure initial quantity is 0 for display items
      coffee.quantity = 0;
      coffees.add(coffee);
    }
    notifyListeners();
  }

  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List<Coffee> filterCoffees(String category) {
    List<Coffee> filteredCoffees = [];

    for (var coffee in coffees) {
      if (coffee.category == category) {
        filteredCoffees.add(coffee);
      }
    }

    return filteredCoffees;
  }

  // Helper method to get cart quantity for a specific coffee
  int getCartQuantity(Coffee coffee) {
    int index = cart.indexWhere((item) => item.title == coffee.title);
    return index != -1 ? cart[index].quantity : 0;
  }

  // Method to calculate total price of all items in cart
  double getTotalPrice() {
    double total = 0.0;
    for (var coffee in cart) {
      total += coffee.price * coffee.quantity;
    }
    return total;
  }


}