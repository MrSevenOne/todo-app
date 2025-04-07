import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/calendar/calendar_screen.dart';
import 'package:todo_app/presentation/screens/done/done_screen.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/presentation/screens/profile/profile_screen.dart';
import 'package:todo_app/presentation/screens/task/task_edit_screen.dart';

class NavigationBarWidget extends StatefulWidget {
  @override
  _BottomNavigatoinBarState createState() => _BottomNavigatoinBarState();
}

class _BottomNavigatoinBarState extends State<NavigationBarWidget> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CalendarScreen(),
    DoneScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Index",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Done",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.outline,
        onTap: _onItemTapped,
      ),
    );
  }
}
