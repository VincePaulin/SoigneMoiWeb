import 'package:flutter/material.dart';
import 'package:soigne_moi_web/config/app_config.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? trailing;

  const AdminAppBar({
    super.key,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Text(
                      AppConfig.applicationName,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Admin",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Image.asset(
                        'assets/img/logo.png',
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(), // Flexible space for separating elements
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nom de l\'utilisateur'),
                  const SizedBox(
                    width: 6.0,
                  ),
                  CircleAvatar(
                    // Avatar
                    radius: 20,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
