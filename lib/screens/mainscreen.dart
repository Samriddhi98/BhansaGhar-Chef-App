import 'package:flutter/material.dart';

//screens
import 'package:BhansaGharChef/screens/menupage.dart';
import 'package:BhansaGharChef/screens/myorder.dart';
import 'package:BhansaGharChef/screens/myschedule.dart';
import 'package:BhansaGharChef/screens/profilepage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;

  MenuPage menuPage;
  OrderPage orderPage;
  SchedulePage schedulePage;
  ProfilePage profilePage;

  void initState() {
    super.initState();
    menuPage = MenuPage();
    schedulePage = SchedulePage();
    profilePage = ProfilePage();
    orderPage = OrderPage();
    pages = [menuPage, orderPage, schedulePage, profilePage];

    currentPage = menuPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('My Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('My Schedule'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('My Profile'),
          ),
        ],
      ),
      body: currentPage,
    );
  }
}
