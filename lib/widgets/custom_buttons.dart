import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/login/login.dart';

Widget buildLoginButton(LoginController controller) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: controller.loading ? null : controller.login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 54.0),
        ),
        child: controller.loading
            ? const LinearProgressIndicator()
            : Text(
                "Connexion",
                style: const TextStyle(color: Colors.white),
              ),
      ),
    ),
  );
}
