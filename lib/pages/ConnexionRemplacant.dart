import 'package:api_parba/pages/ConnexionManager.dart';
import 'package:api_parba/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ConnexionRemplacant extends StatefulWidget {
  const ConnexionRemplacant({Key? key}) : super(key: key);

  @override
  State<ConnexionRemplacant> createState() => _ConnexionRemplacantState();
}

class _ConnexionRemplacantState extends State<ConnexionRemplacant> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  int _currentIndex = 0;
  String _loginMessage = '';

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _loginMessage = "Veuillez remplir tous les champs pour vous connecter.";
      });
    } else {
      try {
        final response = await http.post(
          Uri.parse('https://parba.defarsci.fr/api/login'), // Remplacez par l'URL de votre endpoint de connexion
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> userData = jsonDecode(response.body);

          // Gérez la réponse de l'API et le stockage du token ou des informations de l'utilisateur si nécessaire

          setState(() {
            _loginMessage = "Connexion réussie. Bienvenue, ${userData['name']} !";
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          setState(() {
            _loginMessage = "Identifiants incorrects. Veuillez réessayer.";
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          _loginMessage = "Erreur de connexion. Veuillez réessayer.";
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
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Image.asset('assets/images/parba_logo.png',
                height: 50.0,
                width: 50.0,
              ),
              SizedBox(height: 30.0),
              Text(
                'Remplaçant : Page de connexion',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff009de1),
                  fontSize: 18.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Si vous êtes un manager, la connexion c'est par",
                    style: TextStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConnexionManager()),
                      );
                    },
                    child: Text(
                      ' ici',
                      style: TextStyle(
                        color: Color(0xff009de1),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Connexion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Inscription Remplaçant',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConnexionRemplacant(),
  ));
}
