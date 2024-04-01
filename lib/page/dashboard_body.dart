import 'package:flutter/material.dart';
import 'package:soigne_moi_web/widgets/navigation_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Row(
        children: <Widget>[
          NavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ), // Navigation bar on the left
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                HomePage(),
                ProfilePage(),
                SettingsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Home Page!'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Profile Page!'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Settings Page!'),
    );
  }
}
