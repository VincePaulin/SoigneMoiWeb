import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/home/homepage_body.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';
import 'package:soigne_moi_web/widgets/custom_app_bar.dart';
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
    final isSmallScreen = ScreenSizeUtil.isSmallScreen(context);

    return Scaffold(
      body: Row(
        children: [
          !isSmallScreen
              ? NavBar(
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomAppBar(),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      HomePageBody(),
                      BookStayPage(),
                      ProfilePage(),
                      SettingsPage(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: isSmallScreen
          ? NavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
    );
  }
}

// Todo: make BookStayPage simply
class BookStayPage extends StatelessWidget {
  const BookStayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the BookStay Page!'),
    );
  }
}

// Todo: make profile page simply
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Profile Page!'),
    );
  }
}

// Todo: make setting page simply
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Settings Page!'),
    );
  }
}
