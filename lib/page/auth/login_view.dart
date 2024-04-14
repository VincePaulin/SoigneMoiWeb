import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  decoration: InputDecoration(
                    labelText: 'Adresse e-mail',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                  ),
                  obscureText: true,
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
                // Bouton de connexion
                ElevatedButton(
                  onPressed: () {
                    // Todo: login function
                  },
                  child: Text('Connexion'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
