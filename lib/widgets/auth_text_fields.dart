import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/login/login.dart';

Widget buildEmailTextField(LoginController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofocus: true,
    controller: controller.emailController,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.account_box_outlined,
      ),
      prefixIconColor: Colors.white,
      errorText: controller.emailError,
      errorMaxLines: 3,
      errorStyle: const TextStyle(color: Colors.red),
      hintText: 'Email',
      hintStyle: const TextStyle(color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}

Widget buildPasswordTextField(LoginController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofillHints: controller.loading ? null : [AutofillHints.password],
    controller: controller.passwordController,
    textInputAction: TextInputAction.go,
    obscureText: !controller.showPassword,
    onSubmitted: (_) => controller.login(),
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.lock_outlined,
      ),
      prefixIconColor: Colors.white,
      errorText: controller.passwordError,
      errorMaxLines: 3,
      errorStyle: const TextStyle(color: Colors.red),
      suffixIconColor: Colors.white,
      suffixIcon: IconButton(
        onPressed: controller.toggleShowPassword,
        icon: Icon(
          controller.showPassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      hintText: 'Mot de passe',
      hintStyle: const TextStyle(color: Colors.white),
    ),
  );
}
