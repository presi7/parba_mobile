import 'dart:developer';

import 'package:api_parba/pages/MissionsManager.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// class MissionData {
//   String etablissement;
//   String type;
//   String service;
//   String date_debut;
//   String date_fin;
//   String heure_debut;
//   String heure_fin;
//   String profil_recherche;
//   String motif_non_visible;
//   String remplacant_recherche;

//   MissionData({
//     required this.etablissement,
//     required this.type,
//     required this.service,
//     required this.date_debut,
//     required this.date_fin,
//     required this.heure_debut,
//     required this.heure_fin,
//     required this.profil_recherche,
//     required this.motif_non_visible,
//     required this.remplacant_recherche,
//   });

//   // Ajoutez cette méthode pour convertir les données JSON en instance de MissionData
//   factory MissionData.fromJson(Map<String, dynamic> json) {
//     return MissionData(
//       etablissement: json['etablissement'],
//       type: json['type'],
//       service: json['service'],
//       date_debut: json['date_debut'],
//       date_fin: json['date_fin'],
//       heure_debut: json['heure_debut'],
//       heure_fin: json['heure_fin'],
//       profil_recherche: json['profil_recherche'],
//       motif_non_visible: json['motif_non_visible'],
//       remplacant_recherche: json['remplacant_recherche'],
//     );
//   }


//   get pourvue => null;
//   get annule => null;
//   get annuleounon => null;
//   get pourvueounon => null;
//   get remplacant => null;
//   get journuit => null;
//   get choixdumetier => null;
//   get metier => null;
//   get administrateur => null;
  
// }

class DeclarerMission extends StatefulWidget {
  DeclarerMission({Key? key}) : super(key: key);
  
  // final List<MissionData> missions = [];

  @override
  State<DeclarerMission> createState() => _DeclarerMissionState();
  
  // void onMissionCreated(MissionData newMission) {}
}

class _DeclarerMissionState extends State<DeclarerMission> {
  TextEditingController _etablissementController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _date_debutController = TextEditingController();
  TextEditingController _date_finController = TextEditingController();
  TextEditingController _heure_debutController = TextEditingController();
  TextEditingController _heure_finController = TextEditingController();
  TextEditingController _profil_rechercheController = TextEditingController();
  TextEditingController _motif_non_visibleController = TextEditingController();
  TextEditingController _remplacant_rechercheController = TextEditingController();

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  // Valeur par défaut
  String _selectedEtablissement = 'Choisir un établissement';
  String _selectedType = 'Vacation';
  String _selectedProfil = 'Choisir le profil';
  String _selectedMotif = 'Choisir le motif de remplacement';
  String _selectedRemplacant = 'Rempl1';

  List<String> _optionsEtablissement = [
    'Choisir un établissement',
    'Hopital Aristide Le Dantec CHU',
    'Hopital Général Grand Yoff CHU',
    'Centre Hospitalier Fann CHU',
    'Centre Hospitalier d\'enfants Albert Royer CHU',
    'Hopital Dalal Jamm de Guédiawaye',
    'Hopital Principal de Dakar Centre d\'instruction des armées',
    'Hopital Polyclinique de la Médina',
    'Hopital de Pikine',
    'Centre Hospitalier Nabil Choucaire',
    'Hopital des Enfants de Diamniadio CHU',
    'Centre hospitalier Abass Ndao',
    'Centre Hospitalier Abdoul Aziz Sy Parcelles Assainies',
    'Centre Hospitalier Roi Baudouin',
    'Centre Hospitalier Philippe Senghor',
    'Centre Hospitalier de Keur Massar',
    'Centre Hospitalier Youssou Mbergane Rufisque',
    'Hopital Régional de Thiès',
    'Hopital Régional de Louga',
    'Hopital Régional de Saint Louis',
    'Hopital Régional de Kaolack',
    'Hopital Régional de Tambacounda',
    'Hopital Régional de Kolda',
    'Hopital Régional de Bignona',
    'Hopital Régional de Kaffrine',
    'Hopital Régional de Tivaouane',
    'Hopital Régional de Linguère',
    'Hopital Régional de Fatick',
    'Hopital Régional de Mbour',
    'Hopital Régional de Ndioum',
    'Hopital Régional de Touba',
    'Hopital Régional de Matlaboul fawzayni',
    'Hopital Régional de Ndamatou',
    'Hopital Régional de Dianatou',
    'Hopital Régional de Daroukhoudos',
    'Hopital Régional Cheikhoul Khadim',
    'Clinique de la Madeleine',
    'Clinique du Cap Avenue Pasteur Dakar',
    'Clinique Pasteur Rue Carnot Dakar',
    'Clinique Amitié Grand Yoff à coté de la CBAO',
    'Clinique Belle Vue route de la Corniche en face terminus DDD Palais',
    'Clinique Niang Boulevard Général De gaule Colobane',
    'Clinique Rahma Mermoz Pyrotechnique',
    'Clinique YASALAM Coriche Ouest',
    'Clinique MEDIC\'KANE Sacré Coeur 3',
    'Clinique Cheikh Anta en face Fann',
    'Clinique La SAGESSE Thiès',
    'Clinique Vision Médicale Coumba Thiès',
    'Clinique El Hadji Adama Wade Saint Louis',
    'Clinique de la petite cote ADAMS Mbour',
    'Clinique DADO Mbour',
    'Clinique Cheikhoul Khadim'
  ];
  List<String> _optionsService = [
    'Choisir les Spécialités',
    'Pneumologie',
    'Gastro-entérologie',
    'Orthopédie Traumatologie',
    'Chirurgie Viscérale',
    'Service d\'oto-rhino-larynlogie(ORL)',
    'Medecine Infectueuse',
    'Neurologie',
    'Dermatologie',
    'Rhumatologie',
    'Service des urgences',
    'Pédiatrie',
    'Gynécologie et Obstétrique',
    'Gynécologie et Obstétrique',
    'Neurochirurgie',
    'Gériatrie',
    'Réanimation',
    'Unité de soins continue(USC)',
    'Service de réadaptation fonctionnelle',
    'Ophtalmologie',
    'Urologie',
    'Cardiologie',
    'Néphrologie',
    'Radiologie',
    'Laboratoire',
    'Chimiothérapie',
    'Néonatalogie',
    'Endocrinologie-diabétologie',
    'Kinésithérapie',
    'Dialyse'
  ];
  List<String> _optionsType = ['Vacation', 'Heures supplémentaires'];
  List<String> _optionsProfil = [
    'Choisir le profil',
    'Sage femme',
    'Infirmier/infirmière diplomé d\'état',
    'Infirmier/infirmière anesthésiste diplomé d\'état',
    'Infirmière de bloc opératoire',
    'Aide infirmier',
    'Agent de santé hospitalier',
    'Agent d\'entretien'
  ];
  List<String> _optionsMotif = [
    'Choisir le motif de remplacement',
    'Accident du travail/Maladie professionnelle',
    'Accroissement tempraire d\'activité',
    'Autorisation d\'absence pour événement familial(GTT)',
    'COVID19',
    'Congé maternité',
    'Congé paternité',
    'Congé bonifié'
  ];
  List<String> _optionsRemplacant = ['Rempl1', 'Autre'];


Future<void> declarerMission( newMission) async {
  String type = newMission.type;
  String structure = newMission.etablissement;
  String service = newMission.service;
  String motif = newMission.motif_non_visible;
  String nom_de_la_personne_a_remplacer = newMission.remplacant_recherche;
  

  // Construisez le corps de la requête avec les données de la mission
  final Map<String, dynamic> missionData = {
    'etablissement': _selectedEtablissement,
    'type': _selectedType,
    'service': _optionsService[0], 
    'date_debut': _startDateController.text,
    'heure_debut': _startTimeController.text,
    'date_fin': _endDateController.text,
    'heure_fin': _endTimeController.text,
    'profil_recherche': _selectedProfil,
    'motif_non_visible': _selectedMotif,
    'remplacant_recherche': _selectedRemplacant,
  };

  if (_typeController.text.isEmpty ||
       _etablissementController.text.isEmpty ||
       _serviceController.text.isEmpty ||
      _date_debutController.text.isEmpty ||
      _date_finController.text.isEmpty ||
      _heure_debutController.text.isEmpty ||
      _heure_finController.text.isEmpty ||
      _profil_rechercheController.text.isEmpty ||
      _motif_non_visibleController.text.isEmpty ||
      _remplacant_rechercheController.text.isEmpty) {
    
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/declarer-missions'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(missionData),
    );

    if (response.statusCode == 201) {
      // Succès
      print('Mission créée avec succès');

      // Vous pouvez également ajouter ici d'autres actions en cas de succès.
    } else {
      print('Erreur lors de la requête HTTP : ${response.statusCode}');
      print('Réponse serveur : ${response.body}');
      // Vous pouvez ajouter ici des actions en cas d'échec.
    }
  } catch (e) {
    print('Exception lors de la requête HTTP : $e');
    // Vous pouvez ajouter ici des actions en cas d'exception.
  }

}


Future<void> _selectDate(
      BuildContext context, TextEditingController startDateController) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController timeController) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Declarer une mission',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff009de1),
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 10.0,),
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
            SizedBox(height: 10.0,),
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
                Flexible(
                  child: TextFormField(
                    controller: _startDateController,
                    decoration: InputDecoration(
                      labelText: 'Date de Début',
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.calendar_today),
                        onTap: () {
                          _selectDate(context, _startDateController);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    controller: _startTimeController,
                    decoration: InputDecoration(
                      labelText: 'Heure Début',
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.access_time),
                        onTap: () {
                          _selectTime(context, _startTimeController);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                 Flexible(
                  child: TextFormField(
                    controller: _endDateController,
                    decoration: InputDecoration(
                      labelText: 'Date de Fin',
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.calendar_today),
                        onTap: () {
                          _selectDate(context, _endDateController);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _endTimeController,
                    decoration: InputDecoration(
                      labelText: 'Heure Fin',
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.access_time),
                        onTap: () {
                          _selectTime(context, _endTimeController);
                        },
                      ),
                    ),
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
              items: _optionsProfil.map((profil_recherche) {
                return DropdownMenuItem(
                  value: profil_recherche,
                  child: Text(profil_recherche),
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
              items: _optionsMotif.map((motif_non_visible) {
                return DropdownMenuItem(
                  value: motif_non_visible,
                  child: Text(motif_non_visible),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Remplaçant recherche :'),
            DropdownButton(
              isExpanded: true,
              value: _selectedRemplacant,
              onChanged: (value) {
                setState(() {
                  _selectedRemplacant = value.toString();
                });
              },
              items: _optionsRemplacant.map((remplacant_recherche) {
                return DropdownMenuItem(
                  value: remplacant_recherche,
                  child: Text(remplacant_recherche),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // ElevatedButton(
    //   onPressed: () async{
    //     declarerMission(); // Appel de la fonction pour déclarer la mission
    //    MissionData newMission = MissionData(
        // etablissement: _selectedEtablissement,
        // type: _selectedType,
        // service: _optionsService[0], 
        // date_debut: _startDateController.text, 
        // heure_debut: _startTimeController.text, 
        // date_fin: _endDateController.text,
        // heure_fin: _endTimeController.text, 
        // profil_recherche: _selectedProfil,
        // motif_non_visible: _selectedMotif,
        // remplacant_recherche: _selectedRemplacant,
    // );
    //   },
    //   child: Text("Déclarer la mission"),
    // ),
     ElevatedButton(
  onPressed: () async {
    // Récupérer les données saisies
    // MissionData newMission = MissionData(
    //     etablissement: _selectedEtablissement,
    //     type: _selectedType,
    //     service: _optionsService[0], 
    //     date_debut: _startDateController.text, 
    //     heure_debut: _startTimeController.text, 
    //     date_fin: _endDateController.text,
    //     heure_fin: _endTimeController.text, 
    //     profil_recherche: _selectedProfil,
    //     motif_non_visible: _selectedMotif,
    //     remplacant_recherche: _selectedRemplacant,
    // );

    // // Appeler la fonction pour poster la mission dans la base de données
    // await declarerMission(newMission);

    // // Utilisez la fonction de rappel pour ajouter la nouvelle mission
    // widget.onMissionCreated(newMission);

    // // Appeler la fonction pour poster la mission dans la base de données
    // declarerMission(newMission);

//     Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => MissionsManager(missions: [],),
//   ),
// );

  },
  child: Text("Déclarer une mission"),
),
    SizedBox(width: 10),
    ElevatedButton(
      onPressed: () {
        // Utilisez Navigator.pop pour revenir à l'écran précédent
        Navigator.pop(context);
      },
      child: Text("Retour"),
    ),
  ],
),

          ],
        ),
      ),
    );
  }
}
