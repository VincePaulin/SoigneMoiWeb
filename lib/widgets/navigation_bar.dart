import 'package:flutter/material.dart';
import 'package:soigne_moi_web/utils/app_colors.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const NavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      color: AppColors.primaryColor,
      child: Column(
        children: <Widget>[
          Container(
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Image.asset('assets/img/logo.png'),
                Text(
                  "Soigne Moi",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
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
          _buildNavItem("Vue d'ensemble", Icons.home, 0),
          _buildNavItem('réserver un séjour', Icons.local_hospital, 1),
          _buildNavItem('Profile', Icons.person, 2),
          _buildNavItem('Paramètres', Icons.settings, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, IconData iconData, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: selectedIndex == index ? Colors.white : null,
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          color: selectedIndex == index ? Colors.black : Colors.lightBlueAccent,
        ),
        title: Text(
          title,
          style: TextStyle(
            color:
                selectedIndex == index ? Colors.black : Colors.lightBlueAccent,
          ),
        ),
        onTap: () => onItemTapped(index),
      ),
    );
  }
}
