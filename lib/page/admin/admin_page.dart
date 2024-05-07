import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Center(
        child: Text(
          'Bienvenue dans le panneau d\'administration !',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
