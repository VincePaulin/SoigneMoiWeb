import 'package:flutter/material.dart';
import 'package:soigne_moi_web/datas_demo.dart';
import 'package:soigne_moi_web/function/data_future.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/model/user.dart';
import 'package:soigne_moi_web/page/create_stay.dart';
import 'package:soigne_moi_web/page/home/homepage_body.dart';
import 'package:soigne_moi_web/page/profile/profile_view.dart';
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

    return FutureBuilder(
        future: Future.wait([fetchUser(), fetchStays()]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<dynamic> data = snapshot.data as List<dynamic>;
          final User user = data[0] as User;
          final List<Stay> stays = data[1] as List<Stay>;

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
                        image: const AssetImage('assets/img/homepage.png'),
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
                        CustomAppBar(
                            titlePage: getPageName(_selectedIndex), user: user),
                        Expanded(
                          child: IndexedStack(
                            index: _selectedIndex,
                            children: [
                              HomePageBody(),
                              CreateStayPage(),
                              ProfilePage(
                                user: user,
                                stays: staysDemo, doctors: doctorsDemo,
                              ),
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
