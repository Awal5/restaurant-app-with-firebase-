import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:uas_rizkiawal_2042019/screen/pass.dart';
import 'package:uas_rizkiawal_2042019/screen/adm_profile.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  //firebase
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        children: [
          Pass(),
          Profile(),
        ],
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            inactiveColor: Colors.white,
            title: Text('Home'),
            activeColor: Colors.blue,
          ),

          BottomBarItem(
            icon: Icon(Icons.person),
            inactiveColor: Colors.white,
            title: Text('Profile'),
            activeColor: Colors.greenAccent.shade700,
          ),

        ],
      ),
    );
  }}