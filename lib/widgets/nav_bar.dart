import 'package:flutter/material.dart';
import 'package:flutter_lasttime/widgets/screens/complete_screen.dart';
import 'package:flutter_lasttime/widgets/screens/overlate_screen.dart';
import 'package:flutter_lasttime/widgets/screens/todo_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ToDoScreen(),
    const OverlateScreen(),
    const Completedscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Demo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 26, 25, 25),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: const Color.fromARGB(255, 7, 82, 245).withOpacity(0.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              iconSize: 30,
              gap: 20,
              curve: Curves.ease,
              rippleColor: const Color.fromARGB(176, 52, 150, 231),
              tabBackgroundColor: const Color.fromARGB(176, 52, 150, 231),
              activeColor: Colors.orange,
              tabs: const [
                GButton(
                    icon: Icons.home,
                    iconColor: Colors.white,
                    text: 'สิ่งที่ต้องทำ'),
                GButton(
                    icon: Icons.home,
                    iconColor: Colors.white,
                    text: 'เลยกำหนดเวลา'),
                GButton(
                    icon: Icons.home,
                    iconColor: Colors.white,
                    text: 'เสร็จสมบูรณ์'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
