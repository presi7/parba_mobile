import 'package:api_parba/pages/RegisterFormR.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _structureCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _onSignUpPressed() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String email = _emailController.text.trim();
    String structureCode = _structureCodeController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        structureCode.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showValidationDialog("Veuillez remplir tous les champs");
    } else if (password != confirmPassword) {
      _showValidationDialog("Les mots de passe ne correspondent pas");
    } else {
      // Création d'un objet userData avec les valeurs du formulaire
      Map<String, dynamic> userData = {
        'Prenom': firstName,
        'Nom': lastName,
        'N° Telephone': phoneNumber,
        'Email': email,
        'Code Structure': structureCode,
        'Mot de passe': password,
        'Confirmer mot de passe': confirmPassword,
      };

      // Envoi des données au serveur
      try {
        final response = await http.post(
          // Uri.parse('https://parba.defarsci.fr/api/utilisateurs'), 
           Uri.parse('http://127.0.0.1:8000/api/utilisateurs'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userData),
        );
        if (response.statusCode == 201) {
          // Inscription réussie
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterFormR()),
          );
        } else {
          // Gérer les erreurs de l'API
          print('Erreur d\'inscription : ${response.statusCode}');
          _showValidationDialog('Erreur d\'inscription : ${response.statusCode}');
        }
      } catch (e) {
        // Gérer les erreurs de connexion
        print('Erreur de connexion : $e');
        _showValidationDialog('Erreur de connexion : $e');
      }
    }
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Erreur de validation"),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParBa Sante'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.0),
                Image.asset(
                  'assets/images/parba_logo.png',
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Inscription Nouvel Utilisateur',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 2.0),
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Prénom',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.0),
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.0),
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'N° Téléphone',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.0),
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
                SizedBox (height: 1.0),
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: _structureCodeController,
                      decoration: InputDecoration(
                        labelText: 'Code Structure',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.0),
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
                SizedBox(height: 1.0),
                Center(
                  child: Container(
                    width: 250,
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmer mot de passe',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _onSignUpPressed();
                  },
                  child: Text("S'inscrire"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}