import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/auth/login.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;
  const LoginView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                // Titre de la page
                Text(
                  'Soigne Moi',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Phrase de connexion
                Text(
                  'Connexion',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextField(
                  readOnly: controller.loading,
                  autocorrect: false,
                  autofocus: true,
                  controller: controller.emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.account_box_outlined),
                    errorText: controller.usernameError,
                    errorMaxLines: 3,
                    errorStyle: const TextStyle(color: Colors.orange),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  readOnly: controller.loading,
                  autocorrect: false,
                  autofillHints:
                      controller.loading ? null : [AutofillHints.password],
                  controller: controller.passwordController,
                  textInputAction: TextInputAction.go,
                  obscureText: !controller.showPassword,
                  onSubmitted: (_) => controller.login(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outlined),
                    errorText: controller.passwordError,
                    errorMaxLines: 3,
                    errorStyle: const TextStyle(color: Colors.orange),
                    suffixIcon: IconButton(
                      onPressed: controller.toggleShowPassword,
                      icon: Icon(
                        controller.showPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    ),
                    hintText: 'Mot de passe',
                  ),
                ),
                const SizedBox(height: 10),
                // Todo: forgotten password function
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10),
                // Todo: create account function
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Je n\'ai pas encore de compte',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton.icon(
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: Theme.of(context).colorScheme.primary,
                    //   foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    // ),
                    onPressed: controller.loading ? null : controller.login,
                    icon: const Icon(Icons.login_outlined),
                    label: controller.loading
                        ? const LinearProgressIndicator()
                        : Text("Connexion"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
