import 'package:api_parba/pages/Candidat.dart';
import 'package:flutter/material.dart';


class DetailMissionManager extends StatefulWidget {
  const DetailMissionManager({Key? key});

  @override
  State<DetailMissionManager> createState() => _DetailMissionManagerState();
}

class _DetailMissionManagerState extends State<DetailMissionManager> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _motifController = TextEditingController();
  TextEditingController _personneARemplacerNomController = TextEditingController();
  TextEditingController _personneARemplacerPrenomController = TextEditingController();
  TextEditingController _dateDebutController = TextEditingController();
  TextEditingController _heureDebutController = TextEditingController();
  TextEditingController _dateFinController = TextEditingController();
  TextEditingController _heureFinController = TextEditingController();

  String _selectedType = 'Vacation';
  String _selectedExpressType = 'Standard';
  String _selectedEtablissement = 'Etabl1';
  String _selectedProfil = 'Profil1';
  String _selectedMotif = 'Motif1';
  String _selectedRemplacant = 'Rempl1';
  String _selectedPersonne = 'Personne1';
  String _selectedService = 'Service1';

  List<String> _optionsEtablissement = ['Etabl1', 'Etabl2', 'Etabl3'];
  List<String> _optionsService = ['Service1', 'Service2'];
  List<String> _optionsType = ['Vacation', 'Autre'];
  List<String> _optionsProfil = ['Profil1', 'Autre'];
  List<String> _optionsMotif = ['Motif1', 'Autre'];
  List<String> _optionsRemplacant = ['Rempl1', 'Autre'];
  List<String> _optionsPersonne = ['Personne1', 'Autre'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détail Mission Manager',
          style: TextStyle(
            color: Color(0xff009de1),
          ),
        ),
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
              value: _selectedService,
              onChanged: (value) {
                setState(() {
                  _selectedService = value.toString();
                });
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
                    controller: _dateDebutController,
                    decoration: InputDecoration(labelText: 'Date Début'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _heureDebutController,
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
                    controller: _dateFinController,
                    decoration: InputDecoration(labelText: 'Date Fin'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _heureFinController,
                    decoration: InputDecoration(labelText: 'Heure Fin'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('Profil recherché :'),
            // Ajoutez ici le DropdownButton pour le profil
            SizedBox(height: 10),
            Text('Motif (non visible par les remplaçants) :'),
            // Ajoutez ici le DropdownButton pour le motif
            SizedBox(height: 10),
            Text('Remplaçant :'),
            // Ajoutez ici le DropdownButton pour le remplaçant
            SizedBox(height: 10),
            Text('Personne remplacée :'),
            // Ajoutez ici le DropdownButton pour la personne remplacée
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
                    // Gérer le bouton "Modifier"
                  },
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blue,
                  ),
                  child: Text("Modifier", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Candidat()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.yellow,
                  ),
                  child: Text("Candidat", style: TextStyle(color: Colors.black)),
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
                      child: Text(
                        "Envoyer ma candidature",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
                      child: Text(
                        "Annuler ma candidature",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
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
