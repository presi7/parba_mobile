import 'package:api_parba/pages/HomePage.dart';
import 'package:api_parba/pages/RegisterForm.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _loginMessage = ''; // Message de connexion

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Afficher un message d'erreur si les champs sont vides
      setState(() {
        _loginMessage = "Veuillez remplir tous les champs pour vous connecter.";
      });
    } else {
      // Simulation de la vérification des informations d'identification
      if (email == 'votre_email' && password == 'votre_mot_de_passe') {
        // Connexion réussie, afficher le message de succès
        setState(() {
          _loginMessage = "Connexion réussie. Bienvenue !";
        });

        // Naviguer vers la page d'accueil ou une autre page appropriée
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Remplacez HomePage par le nom de votre page d'accueil
        );
      } else {
        // Informations d'identification incorrectes, afficher le message d'erreur
        setState(() {
          _loginMessage = "Identifiants incorrects. Veuillez réessayer.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ParBa Sante',
          style: TextStyle(
            color: Color(0xff009de1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Image.asset(
                  'assets/images/parba_logo.png',
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 30.0),
                Text(
                  'Connexion',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff009de1),
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 30.0),
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                      color: Color(0xff009de1),
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _loginMessage,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 20),
                Text("Vous n'avez pas de compte?"),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterForm()),
                    );
                  },
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(
                      color: Color(0xff009de1),
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                    ),
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

void main() {
  runApp(MaterialApp(
    home: LoginForm(),
  ));
}
