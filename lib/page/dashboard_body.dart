import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/create_stay.dart';
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

  String getPageName(int index) {
    switch (index) {
      case 0:
        return "Vue d'ensemble";
      case 1:
        return "Réservation d'un séjour";
      case 2:
        return 'Profile';
      case 3:
        return 'Settings';
      default:
        return '';
    }
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
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/homepage.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8),
                    BlendMode.color,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomAppBar(titlePage: getPageName(_selectedIndex)),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: [
                        HomePageBody(),
                        CreateStayPage(),
                        ProfilePage(),
                        SettingsPage(),
                      ],
                    ),
                  ),
                ],
              ),
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
