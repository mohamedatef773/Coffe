import 'package:coffee_shope/model/coffee.dart';
import 'package:flutter/material.dart';

import '../model/data.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    loadCoffees();
  }

  List<Coffee> coffees = [];
  List<Coffee> cart = [];

  void addToCart(Coffee coffee, int quantity) {
    // Find if this coffee already exists in cart
    int index = cart.indexWhere((item) => item.id == coffee.id);

    if (index != -1) {
      cart[index].quantity += quantity;
    } else {
      Coffee newCoffee = Coffee(
        id: coffee.id,
        title: coffee.title,
        description: coffee.description,
        price: coffee.price,
        image: coffee.image,
        category: coffee.category,
        quantity: quantity,
        subTitle: coffee.subTitle ?? '',
      );
      cart.add(newCoffee);
    }
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    int index = cart.indexWhere((item) => item.id == coffee.id);
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

  // Method to calculate total price of all items in cart
  double getTotalPrice() {
    double total = 0.0;
    for (var coffee in cart) {
      total += coffee.price * coffee.quantity;
    }
    return total;
  }

  void incrementQuantity(Coffee coffee) {
    coffee.quantity++;
    notifyListeners();
  }

  void decrementQuantity(Coffee coffee) {
    if (coffee.quantity > 1) {
      coffee.quantity--;
      notifyListeners();
    }
  }

  void resetQuantity(Coffee coffee) {
    coffee.quantity = 1;
    notifyListeners();
  }
}
