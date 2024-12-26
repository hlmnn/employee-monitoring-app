import 'package:employee_monitoring_app/ui/screen/member/member_home_page.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_profile_page.dart';
import 'package:employee_monitoring_app/ui/screen/member/member_store_page.dart';
import 'package:flutter/material.dart';

class MemberNavigation extends StatefulWidget {
  const MemberNavigation({super.key, required this.title});

  final String title;

  @override
  _MemberNavigationState createState() => _MemberNavigationState();
}

class _MemberNavigationState extends State<MemberNavigation> {
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
          return const MemberHomePage(title: 'Home');
        }
      case 1:
        {
          return const MemberStorePage(title: 'Store');
        }
      case 2:
        {
          return const MemberProfilePage(title: 'Profile');
        }
    }
  }
}