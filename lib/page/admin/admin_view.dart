import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/patient_api.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/model/user.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';
import 'package:soigne_moi_web/widgets/admin_app_bar.dart';
import 'package:soigne_moi_web/widgets/admin_navigation_bar.dart';
import 'package:soigne_moi_web/widgets/navigation_bar.dart';

import 'admin_doctors.dart';
import 'admin_home.dart';
import 'admin_planning.dart';

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

    return FutureBuilder(
        future: Future.wait([Api().fetchUser(), Api().fetchStays()]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<dynamic> data = snapshot.data as List<dynamic>;
          final User user = data[0] as User;
          final List<Stay> stays = data[1] as List<Stay>;

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
                          AdminPlanning(),
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
        });
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
