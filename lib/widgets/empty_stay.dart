import 'package:flutter/material.dart';

class EmptyListStay extends StatelessWidget {

  const EmptyListStay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Il n’y a pas encore de séjour qui apparait ici.",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          fontSize: 18,
        ),
      ),
    );
  }
}