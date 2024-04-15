import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/page/register/register.dart';
import 'package:soigne_moi_web/widgets/auth_text_fields.dart';
import 'package:soigne_moi_web/widgets/custom_buttons.dart';

class RegisterForm extends StatelessWidget {
  final RegisterController controller;

  const RegisterForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Creation de compte',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vous avez déjà un compte ? ',
                  style: TextStyle(color: Colors.white),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Text(
                      "Se connecter ici",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            buildRegisterEmailTextField(controller),
            const SizedBox(height: 10),
            buildRegisterNameTextField(controller),
            const SizedBox(height: 10),
            buildRegisterAddressTextField(controller),
            const SizedBox(height: 10),
            buildRegisterPasswordTextField(controller),
            const SizedBox(height: 10),
            buildRegisterConfirmPasswordTextField(controller),
            const SizedBox(height: 20),
            buildRegisterButton(controller),
          ],
        ),
      ),
    );
  }
}
