import 'package:flutter/material.dart';

import 'monitor_home_page.dart';
import 'profile/monitor_profile_page.dart';
import 'store/monitor_store_page.dart';

class MonitorNavigation extends StatefulWidget {
  const MonitorNavigation({super.key, required this.title});

  final String title;

  @override
  _MonitorNavigationState createState() => _MonitorNavigationState();
}

class _MonitorNavigationState extends State<MonitorNavigation> {
  int pageIndex = 0; // active index

  // event when button is tapped
  void onItemTap(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        body: pages(pageIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          selectedItemColor: const Color(0xffDD7402),
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          onTap: onItemTap, // event when button is tapped
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card), label: "Store"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile"),
          ]
        ),
      )
    );
  }

  pages(int pageIndex) {
    switch (pageIndex) {
      case 0:
        {
          return const MonitorHomePage(title: 'Home');
        }
      case 1:
        {
          return const MonitorStorePage(title: 'Store');
        }
      case 2:
        {
          return const MonitorProfilePage(title: 'Profile');
        }
    }
  }

}