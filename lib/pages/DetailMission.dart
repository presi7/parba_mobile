import 'package:api_parba/pages/CreerMission.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailMission extends StatefulWidget {
  const DetailMission({Key? key, required MissionData mission}) : super(key: key);

  @override
  State<DetailMission> createState() => _DetailMissionState();
}

class _DetailMissionState extends State<DetailMission> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _motifController = TextEditingController();
  TextEditingController _personneARemplacerNomController =
      TextEditingController();
  TextEditingController _personneARemplacerPrenomController =
      TextEditingController();

  String _selectedType = 'Vacation';
  String _selectedExpressType = 'Standard';
  String _selectedEtablissement = 'Etabl1';
  String _selectedProfil = 'Profil1';
  String _selectedMotif = 'Motif1';
  String _selectedRemplacant = 'Rempl1';
  String _selectedPersonne = 'Personne1';

  List<String> _optionsEtablissement = ['Etabl1', 'Etabl2', 'Etabl3'];
  List<String> _optionsService = ['Service1', 'Service2'];
  List<String> _optionsType = ['Vacation', 'Autre'];
  List<String> _optionsProfil = ['Profil1', 'Autre'];
  List<String> _optionsMotif = ['Motif1', 'Autre'];
  List<String> _optionsRemplacant = ['Rempl1', 'Autre'];
  List<String> _optionsPersonne = ['Personne1', 'Autre'];

Future<void> envoyerDetailMission() async {
  final url = Uri.parse('https://parba.defarsci.fr/api/details-missions');

  // Construisez le corps de la requête avec les données de détail de la mission
  final Map<String, dynamic> detailMissionData = {
    'type': _selectedType,
    'express_type': _selectedExpressType,
    'etablissement': _selectedEtablissement,
    'service': _optionsService[0], // Remarque : à modifier en fonction de l'interaction de l'utilisateur
    'nom': _nomController.text,
    'prenom': _prenomController.text,
    'motif': _motifController.text,
    'personne_a_remplacer_nom': _personneARemplacerNomController.text,
    'personne_a_remplacer_prenom': _personneARemplacerPrenomController.text,
    'profil_recherche': _selectedProfil,
    'motif_non_visible': _selectedMotif,
    'remplacant_recherche': _selectedRemplacant,
    'personne_recherchee': _selectedPersonne,
  };

  final response = await http.post(
    url,
    body: detailMissionData,
  );

  if (response.statusCode == 200) {
    // Les détails de la mission ont été envoyés avec succès, vous pouvez afficher un message à l'utilisateur
  } else {
    // Gérer les erreurs ici en fonction de la réponse de l'API
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
            SizedBox(height: 10),
            Text('Service :'),
            DropdownButton(
              isExpanded: true,
              value: _optionsService[0],
              onChanged: (value) {
                // Gérer le changement de valeur du menu déroulant
              },
              items: _optionsService.map((service) {
                return DropdownMenuItem(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nomController,
                    decoration: InputDecoration(labelText: 'Date Début'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _prenomController,
                    decoration: InputDecoration(labelText: 'Heure Début'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _motifController,
                    decoration: InputDecoration(labelText: 'Date Fin'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _personneARemplacerNomController,
                    decoration: InputDecoration(labelText: 'Heure Fin'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('Profil recherché :'),
            DropdownButton(
              isExpanded: true,
              value: _selectedProfil,
              onChanged: (value) {
                setState(() {
                  _selectedProfil = value.toString();
                });
              },
              items: _optionsProfil.map((profil) {
                return DropdownMenuItem(
                  value: profil,
                  child: Text(profil),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Motif (non visible par les remplaçants) :'),
            DropdownButton(
              isExpanded: true,
              value: _selectedMotif,
              onChanged: (value) {
                setState(() {
                  _selectedMotif = value.toString();
                });
              },
              items: _optionsMotif.map((motif) {
                return DropdownMenuItem(
                  value: motif,
                  child: Text(motif),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Remplaçant :'),
            DropdownButton(
              isExpanded: true,
              value: _selectedRemplacant,
              onChanged: (value) {
                setState(() {
                  _selectedRemplacant = value.toString();
                });
              },
              items: _optionsRemplacant.map((remplacant) {
                return DropdownMenuItem(
                  value: remplacant,
                  child: Text(remplacant),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Personne remplacée :'),
            DropdownButton(
              isExpanded: true,
              value: _selectedPersonne,
              onChanged: (value) {
                setState(() {
                  _selectedPersonne = value.toString();
                });
              },
              items: _optionsPersonne.map((personne) {
                return DropdownMenuItem(
                  value: personne,
                  child: Text(personne),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Gérer le bouton "Retour"
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue),
                  ),
                  child: Text("Retour", style: TextStyle(color: Colors.blue)),
                ),
                ElevatedButton(
                  onPressed: () {
                    envoyerDetailMission(); // Appel de la fonction pour envoyer les détails de la mission
                  },
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.purple,
                  ),
                  
                  child:
                      Text("Valider", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    envoyerDetailMission(); // Appel de la fonction pour envoyer les détails de la mission
                  },
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blue,
                  ),
                  child:
                      Text("Modifier", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MissionsPage()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.yellow,
                  ),
                  child: Text("Candidat",
                      style: TextStyle(color: Colors.black)),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Gérer le bouton "Annuler"
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                  ),
                  child: Text("Annuler", style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Gérer le bouton "Supprimer"
                  },
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.red,
                  ),
                  child:
                      Text("Supprimer", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      // Gérer le bouton "Envoyer ma candidature"
                    },
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.green,
                    ),
                    child: Center(
                      child: Text("Envoyer ma candidature",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      // Gérer le bouton "Annuler ma candidature"
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green),
                    ),
                    child: Center(
                      child: Text("Annuler ma candidature",
                          style: TextStyle(
                            color: Colors.green,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
