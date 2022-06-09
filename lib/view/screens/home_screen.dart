import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/view/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  void selectedPage(int page) {
    setState(() {
      pageIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: selectedPage,
        currentIndex: pageIndex,
        selectedItemColor: Colors.white,
        backgroundColor: backgroundColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: CustomIcon(), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: 'messaging'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      body: page[pageIndex],
    );
  }
}
