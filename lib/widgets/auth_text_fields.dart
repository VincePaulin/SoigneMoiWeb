import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/login/login.dart';
import 'package:soigne_moi_web/page/register/register.dart';

Widget buildLoginEmailTextField(LoginController controller) {
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
        Icons.email_outlined,
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

Widget buildLoginPasswordTextField(LoginController controller) {
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

// Register TextFields
Widget buildRegisterEmailTextField(RegisterController controller) {
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
        Icons.email_outlined,
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

Widget buildRegisterPasswordTextField(RegisterController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofillHints: controller.loading ? null : [AutofillHints.password],
    controller: controller.passwordController,
    textInputAction: TextInputAction.go,
    obscureText: !controller.showPassword,
    onSubmitted: (_) => controller.register(),
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

Widget buildRegisterNameTextField(RegisterController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofocus: true,
    controller: controller.nameController,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.text,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.person_outline,
      ),
      prefixIconColor: Colors.white,
      hintText: 'Nom',
      hintStyle: const TextStyle(color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}

Widget buildRegisterAddressTextField(RegisterController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofocus: true,
    controller: controller.addressController,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.text,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.location_on_outlined,
      ),
      prefixIconColor: Colors.white,
      hintText: 'Adresse postale',
      hintStyle: const TextStyle(color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}

Widget buildRegisterConfirmPasswordTextField(RegisterController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofillHints: controller.loading ? null : [AutofillHints.password],
    controller: controller.confirmPasswordController,
    textInputAction: TextInputAction.go,
    obscureText: !controller.showConfirmPassword,
    onSubmitted: (_) => controller.register(),
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      errorText: controller.confirmPasswordError,
      errorMaxLines: 3,
      errorStyle: const TextStyle(color: Colors.red),
      prefixIcon: const Icon(
        Icons.lock_outlined,
      ),
      prefixIconColor: Colors.white,
      suffixIcon: IconButton(
        onPressed: controller.toggleShowConfirmPassword,
        icon: Icon(
          controller.showConfirmPassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
      suffixIconColor: Colors.white,
      hintText: 'Confirmer le mot de passe',
      hintStyle: const TextStyle(color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}
