import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/admin/agendas/agendas.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';
import 'package:soigne_moi_web/widgets/admin_app_bar.dart';
import 'package:soigne_moi_web/widgets/admin_navigation_bar.dart';
import 'package:soigne_moi_web/widgets/navigation_bar.dart';
import 'admin_home.dart';
import 'doctors/doctors.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getPageName(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Planings";
      case 2:
        return 'Docteurs';
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
      body: Column(
        children: [
          const AdminAppBar(),
          Expanded(
              child: Row(
            children: [
              !isSmallScreen
                  ? AdminNavBar(
                      selectedIndex: _selectedIndex,
                      onItemTapped: _onItemTapped,
                    )
                  : Container(),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    AdminHome(),
                    AdminAgendas(),
                    AdminDoctors(),
                    SettingsPage(),
                  ],
                ),
              )
            ],
          ))
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
