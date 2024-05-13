import 'package:api_parba/pages/AccueilPage.dart';
import 'package:api_parba/pages/ConnexionRemplacant.dart';
import 'package:api_parba/pages/HomePage.dart';
import 'package:api_parba/pages/MissionsManager.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnexionManager extends StatefulWidget {
  const ConnexionManager({Key? key}) : super(key: key);

  @override
  State<ConnexionManager> createState() => _ConnexionManagerState();
}

class _ConnexionManagerState extends State<ConnexionManager> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  int _currentIndex = 0;
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
//           'password': password,
//         }),
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> userData = json.decode(response.body);

//         if (userData['message'] == 'Identifiants incorrects') {
//           setState(() {
//             _loginMessage = "Identifiants incorrects. Veuillez réessayer.";
//           });
//         } else {
//           String role = userData['role'];
//           if (role == 'manager') {
//             setState(() {
//               _loginMessage = "Connexion réussie. Bienvenue, ${userData['name']} !";
//             });
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => MissionsManager(missions: [],)),
//             );
//           } else {
//             setState(() {
//               _loginMessage = "Vous n'êtes pas autorisé à vous connecter en tant que gestionnaire.";
//             });
//           }
//         }
//       } else {
//         setState(() {
//           _loginMessage = "Erreur de connexion. Veuillez réessayer.";
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
          // Remplacez par l'URL de votre endpoint de connexion
          // Uri.parse('http://127.0.0.1:8000/api/create-manager-account'),
          Uri.parse('http://127.0.0.1:8000/api/login'),
          // Uri.parse('https://parba.defarsci.fr/api/login'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'password': password,
            'role': 'manager', // Remplacez 'manager' par le rôle souhaité
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> userData = json.decode(response.body);
            
          // Vérifiez le rôle de l'utilisateur
          if (userData['role'] != 'manager') {
            setState(() {
              
              _loginMessage =
                  "Vous n'êtes pas autorisé à vous connecter en tant que gestionnaire.";
            });
          } else {
            setState(() {
             
              _loginMessage =
                  "Connexion réussie. Bienvenue, ${userData['name']} !";
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MissionsManager(
                        missions: [],
                      )),
            );
          }
        } else {
          setState(() {
            //  print(email );
            // print(password);
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
              Image.asset(
                'assets/images/parba_logo.png',
                height: 50.0,
                width: 50.0,
              ),
              SizedBox(height: 30.0),
              Text(
                'Gestionnaire : Page de connexion',
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
                    "Si vous êtes un remplaçant, la connexion c'est par",
                    style: TextStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConnexionRemplacant()),
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
    home: ConnexionManager(),
  ));
}
