import 'package:flutter/material.dart';
import 'package:soigne_moi_web/config/app_config.dart';
import 'package:soigne_moi_web/utils/app_colors.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:soigne_moi_web/widgets/logout_button.dart';

class AdminNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const AdminNavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.blueGrey.withOpacity(0.5),
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Text(
                        "Menu",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _buildNavItem('Plannings', Icons.calendar_month, 0),
                Divider(color: Colors.blueGrey.withOpacity(0.5)),
                _buildNavItem('Docteurs', Icons.medical_services, 1),
              ],
            ),
            const AdminLogoutButton(),
          ],
        ));
  }

  Widget _buildNavItem(String title, IconData iconData, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: selectedIndex == index ? Colors.white : null,
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          color: selectedIndex == index ? Colors.black : Colors.blueGrey,
        ),
        title: Text(
          title,
          style: montserratTextStyle(
            color: selectedIndex == index ? Colors.black : Colors.blueGrey,
          ),
        ),
        onTap: () => onItemTapped(index),
      ),
    );
  }
}
