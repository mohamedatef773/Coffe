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
    // indexOf: return index value of coffee if it exist or return -1 if it doesn't exist
    int index = cart.indexOf(coffee);
    if (index != -1) {
      cart[index].quantity++;
    } else {
      cart.add(coffee);
    }
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    int index = cart.indexOf(coffee);
    if (cart[index].quantity == 1) {
      cart.removeAt(index);
    } else {
      cart[index].quantity--;
    }
    notifyListeners();
  }

  void loadCoffees() {
    List data = fakeData["data"] ?? [];

    for (var itemMap in data) {
      Coffee coffee = Coffee.fromMap(itemMap);
      coffees.add(coffee);
    }
    notifyListeners(); // notifyListeners() == update() (in GetX)
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
}
