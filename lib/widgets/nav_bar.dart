import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';
import 'package:flutter_lasttime/widgets/screens/complete_scren.dart';
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
    const CompleteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastTimeBloc, BlocState>(builder: (context, state) {
      return state is LoadingState
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: const Text(
                  'TODO App',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 197, 178, 8),
              ),
              body: _widgetOptions.elementAt(_selectedIndex),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 25, 25),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: const Color.fromARGB(255, 7, 82, 245)
                          .withOpacity(0.1),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: GNav(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      iconSize: 35,
                      gap: 30,
                      curve: Curves.ease,
                      rippleColor: const Color.fromARGB(172, 241, 132, 6),
                      tabBackgroundColor: const Color.fromARGB(174, 0, 0, 0),
                      activeColor: Colors.orange,
                      tabs: const [
                        GButton(
                          icon: Icons.list,
                          iconColor: Colors.white,
                          text: 'สิ่งที่ต้องทำ',
                        ),
                        GButton(
                            icon: Icons.assignment_turned_in,
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
    });
  }
}
