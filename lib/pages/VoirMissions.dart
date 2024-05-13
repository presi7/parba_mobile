import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VoirMissions extends StatefulWidget {
  const VoirMissions({Key? key}) : super(key: key);

  @override
  State<VoirMissions> createState() => _VoirMissionsState();
}

class _VoirMissionsState extends State<VoirMissions> {
  // Contrôleurs pour les champs de texte
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _motifController = TextEditingController();
  TextEditingController _personneARemplacerNomController = TextEditingController();
  TextEditingController _personneARemplacerPrenomController = TextEditingController();

  // Variables pour stocker les valeurs sélectionnées
  String _selectedType = 'Vacation';
  String _selectedExpressType = 'Standard';
  String _selectedEtablissement = 'Etabl1';
  String _selectedProfil = 'Profil1';
  String _selectedMotif = 'Motif1';
  String _selectedRemplacant = 'Rempl1';
  String _selectedPersonne = 'Personne1';

  // Listes d'options pour les menus déroulants
  List<String> _optionsEtablissement = ['Etabl1', 'Etabl2', 'Etabl3'];
  List<String> _optionsService = ['Service1', 'Service2'];
  List<String> _optionsType = ['Vacation', 'Autre'];
  List<String> _optionsProfil = ['Profil1', 'Autre'];
  List<String> _optionsMotif = ['Motif1', 'Autre'];
  List<String> _optionsRemplacant = ['Rempl1', 'Autre'];
  List<String> _optionsPersonne = ['Personne1', 'Autre'];

@override
void initState() {
  super.initState();
  fetchMissions(); // Appel de la fonction pour récupérer les missions
}

Future<void> fetchMissions() async {
  final url = Uri.parse('https://parba.defarsci.fr/api/voirs');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Traitement des données de réponse ici
    final missions = jsonDecode(response.body);
    // Vous pouvez mettre à jour l'interface utilisateur avec les données récupérées.
  } else {
    throw Exception('Échec de la requête API');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text('Type :'),
            DropdownButton(
              isExpanded: true,
              value: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value.toString();
                });
              },
              items: _optionsType.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: RadioListTile(
                title: Text('Standard'),
                value: 'Standard',
                groupValue: _selectedExpressType,
                onChanged: (value) {
                  setState(() {
                    _selectedExpressType = value.toString();
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: RadioListTile(
                title: Text('Express'),
                value: 'Express',
                groupValue: _selectedExpressType,
                onChanged: (value) {
                  setState(() {
                    _selectedExpressType = value.toString();
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Text('Etablissement :'),
            DropdownButton(
              isExpanded: true,
              value: _selectedEtablissement,
              onChanged: (value) {
                setState(() {
                  _selectedEtablissement = value.toString();
                });
              },
              items: _optionsEtablissement.map((etablissement) {
                return DropdownMenuItem(
                  value: etablissement,
                  child: Text(etablissement),
                );
              }).toList(),
            ),
            // ... (ajoutez le reste du code pour les champs et boutons)
          ],
        ),
      ),
    );
  }
}
