import 'package:api_parba/pages/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


class ConnexionAdmin extends StatefulWidget {
  const ConnexionAdmin({Key? key}) : super(key: key);

  @override
  State<ConnexionAdmin> createState() => _ConnexionAdminState();
}

class _ConnexionAdminState extends State<ConnexionAdmin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _loginMessage = '';

//   Future<void> _login() async {
//   String email = _emailController.text;
//   String password = _passwordController.text;

//   if (email.isEmpty || password.isEmpty) {
//     setState(() {
//       _loginMessage = "Veuillez remplir tous les champs pour vous connecter.";
//     });
//   } else {
//     try {
//       final response = await http.post(
//         Uri.parse('http://127.0.0.1:8000/api/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'email': email,
//           'password': sha256.convert(utf8.encode(password)).toString(), // Hacher le mot de passe
//         }),
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> userData = jsonDecode(response.body);

//         // // Vérification du mot de passe
//         // if (userData['password'] == sha256.convert(utf8.encode(password)).toString()) {
//         //   // Mot de passe correct

//         //   // Gérez la réponse de l'API et le stockage du token ou des informations de l'utilisateur si nécessaire

//         //   setState(() {
//         //     _loginMessage = "Connexion réussie. Bienvenue, ${userData['name']} !";
//         //   });
//         // } else {
//         //   // Mot de passe incorrect
//         //   setState(() {
//         //     _loginMessage = "Identifiants incorrects. Veuillez réessayer.";
//         //   });
//         // }
//       } else {
//         setState(() {
//           _loginMessage = "Identifiants incorrects. Veuillez réessayer.";
//         });
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         _loginMessage = "Erreur de connexion. Veuillez réessayer.";
//       });
//     }
//   }
// }
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
        Uri.parse('http://127.0.0.1:8000/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': sha256.convert(utf8.encode(password)).toString(), // Hacher le mot de passe
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);

        // Vérification du mot de passe
        if (userData['message'] == 'Connexion réussie') {
          // Mot de passe correct
          setState(() {
            _loginMessage = "Connexion réussie. Bienvenue, ${userData['name']} !";
          });
        } else {
          // Mot de passe incorrect
          setState(() {
            _loginMessage = "Identifiants incorrects. Veuillez réessayer.";
          });
        }
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
                'Administrateur: Page de connexion',
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
                    // color: Color(0xff009de1),
                    color: Colors.white,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                  );
                },
                child: Text('Créer un compte',
                style: TextStyle(color: Colors.white,),),
              )

            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConnexionAdmin(),
  ));
}
