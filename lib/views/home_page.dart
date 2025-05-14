import 'package:coffee_shope/views/coffee_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFF212325),
        appBar: AppBar(
          backgroundColor: Color(0xFF212325),
          leading: Icon(Icons.menu, color: Colors.white, size: 30),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                "It's a Great Day For Coffee",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    hintText: "Find your coffee",
                    hintStyle: TextStyle(
                      color: Color(0xff575b5c),
                      fontSize: 17,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    fillColor: Color(0xff323638),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    focusColor: Color(0xff323638)),
              ),
              SizedBox(height: 10),
              TabBar(
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  indicatorWeight: 3,
                  unselectedLabelStyle: TextStyle(color: Color(0xff7e8284)),
                  dividerColor: Color(0xff323638),
                  tabs: [
                    Tab(text: "Hot Coffee"),
                    Tab(
                      text: "Cold Coffee",
                    ),
                    Tab(
                      text: "Cappuccino",
                    )
                  ]),
              Expanded(
                child: TabBarView(
                  children: [
                    CoffeeList(category: "Hot Coffee"),
                    CoffeeList(category: "Cold Coffee"),
                    CoffeeList(category: "Cappuccino"),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (_, value, __) => BottomNavigationBar(
            backgroundColor: Color(0xff212325),
            selectedItemColor: const Color(0xffbf6329),
            // Use 'const' for efficiency
            unselectedItemColor: Colors.white,
            currentIndex: value.selectedIndex,
            type: BottomNavigationBarType.fixed,
            // Ensures color applies correctly
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: 30), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications, size: 30), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30), label: ""),
            ],
            onTap: (index) {
              value.changeIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
