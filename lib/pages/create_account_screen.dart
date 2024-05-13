import 'package:api_parba/pages/ConnexionAdmin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();



  bool _validateEmail = false;
  bool _validatePassword = false;

  // Déclarez votre variable adminToken ici
  String adminToken = 'a32b590ec9fbfaf46405210072e76ff2';

  Future<void> createManagerAccount() async {
    // Utilisez votre propre URL API
    final String apiUrl = 'http://127.0.0.1:8000/api/create-manager-account';

    // final Map<String, dynamic> requestData = {
    //   'admin_token': 'a32b590ec9fbfaf46405210072e76ff2',
    //   'email': emailController.text,
    //   'password': passwordController.text,
    // };
      final Map<String, dynamic> requestData = {
  'admin_token': adminToken,
  'first_name': firstNameController.text,
  'last_name': lastNameController.text,
  'email': emailController.text,
  'password': passwordController.text,
};


print('Request Data: ${jsonEncode(requestData)}');


    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          'Content-Type': "application/json",
          
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 201) {
        print('Compte Manager créé avec succès');
        print('Email: ${emailController.text}');
        print('Mot de passe: ${passwordController.text}');

        // Vous pouvez afficher un message à l'utilisateur ici si nécessaire
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ConnexionAdmin()),
        );
      } else {
        print('Erreur lors de la création du compte Manager');
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        // Affichez un message d'erreur à l'utilisateur$2y$10$1crbAL0GXqW1hYvRCQDODuzOnKMXfi2Va0J5OqnPOVx
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la création du compte Manager'),
          ),
        );
      }
    } catch (e) {
      print('Erreur: $e');
      // Affichez un message d'erreur à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la création du compte Manager'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'Prénom',
                // Ajoutez d'autres propriétés de décoration si nécessaire
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Nom',
                // Ajoutez d'autres propriétés de décoration si nécessaire
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _validateEmail ? 'Veuillez entrer une adresse e-mail valide' : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: _validateEmail ? Colors.red : Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                errorText: _validatePassword ? 'Veuillez entrer un mot de passe valide' : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: _validatePassword ? Colors.red : Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _validateEmail = emailController.text.isEmpty || !isValidEmail(emailController.text);
                  _validatePassword = passwordController.text.isEmpty || !isValidPassword(passwordController.text);
                });

                if (!_validateEmail && !_validatePassword) {
                  await createManagerAccount();
                }
              },

              child: Text(
                'Créer le compte',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }
}
