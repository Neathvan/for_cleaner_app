import 'package:flutter/material.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/ui/screen/booking_history_widget.dart';
import 'package:clean_app/ui/screen/more_screen.dart';
import 'package:clean_app/ui/widget/home_widget.dart';
import 'package:clean_app/ui/widget/setting_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _title = "Home";
  List<Widget> screen = [HomeWidget(), BookingHistoryWidget(), MoreScreen()];
  List<String>  title = ["Home", "History", "More"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title[_selectedIndex], style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: screen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: defaultColor.appColor,
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
    );
  }
}
