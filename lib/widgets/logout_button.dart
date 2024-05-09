import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () async {
          // Delete token from secure storage
          const secureStorage = FlutterSecureStorage();
          await secureStorage.delete(key: 'access_token');

          // Navigate to the login page
          if (context.mounted) context.go('/');
        },
        child: const Text(
          'Se déconnecter',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class AdminLogoutButton extends StatelessWidget {
  const AdminLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () async {
          // Delete token from secure storage
          const secureStorage = FlutterSecureStorage();
          await secureStorage.delete(key: 'access_token');

          // Navigate to the login page
          if (context.mounted) context.go('/');
        },
        child: const Text(
          'Se déconnecter',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
