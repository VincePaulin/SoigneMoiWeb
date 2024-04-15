import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/register/register.dart';
import 'package:soigne_moi_web/page/register/register_form.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';

class RegisterView extends StatelessWidget {
  final RegisterController controller;
  const RegisterView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ScreenSizeUtil.isSmallScreen(context);

    return Scaffold(
      backgroundColor: const Color(0xFF385568),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !isSmallScreen
                ? Flexible(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                      child: Image.asset(
                        'assets/img/login_img.png',
                        height:
                            double.infinity, // Takes up all available height
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
            RegisterForm(controller: controller)
          ],
        ),
      ),
    );
  }
}
