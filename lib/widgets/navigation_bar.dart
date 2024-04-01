import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const NavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      color: const Color(0xFF0072BB),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Home'),
            selected: selectedIndex == 0,
            onTap: () => onItemTapped(0),
          ),
          ListTile(
            title: Text('Profile'),
            selected: selectedIndex == 1,
            onTap: () => onItemTapped(1),
          ),
          ListTile(
            title: Text('Settings'),
            selected: selectedIndex == 2,
            onTap: () => onItemTapped(2),
          ),
        ],
      ),
    );
  }
}