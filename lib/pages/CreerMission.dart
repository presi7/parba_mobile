import 'package:api_parba/pages/MissionsManager.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MissionData {
  String type;
  String structure;
  String service;
  String debut;
  String fin;
  String heure_debut;
  String heure_fin;
  String profil;
  String motif;
  String nom_de_la_personne_a_remplacer;
  String prenom_de_la_personne_a_remplacer;

  MissionData({
    required this.type,
    required this.structure,
    required this.service,
    required this.debut,
    required this.fin,
    required this.heure_debut,
    required this.heure_fin,
    required this.profil,
    required this.motif,
    required this.nom_de_la_personne_a_remplacer,
    required this.prenom_de_la_personne_a_remplacer,
  });
  
    bool pourvue = false; 
    bool annule = false;
    bool pourvueounon = false;
    bool remplacant = false;
    bool administrateur = false;
    String metier = '';
    String etablissement = '';
    String date = '';
    String choixdumetier = '';
    String journuit = '';

  // Ajoutez la méthode fromJson ici
  factory MissionData.fromJson(Map<String, dynamic> json) {
    return MissionData(
      type: json['type'],
      structure: json['structure'],
      service: json['service'],
      debut: json['debut'],
      fin: json['fin'],
      heure_debut: json['heure_debut'],
      heure_fin: json['heure_fin'],
      profil: json['profil'],
      motif: json['motif'],
      nom_de_la_personne_a_remplacer: json['nom_de_la_personne_a_remplacer'],
      prenom_de_la_personne_a_remplacer: json['prenom_de_la_personne_a_remplacer'],
    );
  }
}

class CreerMission extends StatefulWidget {
  final Function(MissionData) onMissionCreated;

  final List<MissionData> missions = [];
  
  CreerMission({required this.onMissionCreated});

  @override
  _CreerMissionState createState() => _CreerMissionState();
  // State<CreerMission> createState() => _CreerMissionState();
}

class _CreerMissionState extends State<CreerMission> {
  TextEditingController _typeController = TextEditingController();
  TextEditingController _structureController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _debutController = TextEditingController();
  TextEditingController _finController = TextEditingController();
  TextEditingController _heure_debutController = TextEditingController();
  TextEditingController _heure_finController = TextEditingController();
  TextEditingController _profilController = TextEditingController();
  TextEditingController _motifController = TextEditingController();
  TextEditingController _nom_de_la_personne_a_remplacerController = TextEditingController();
  TextEditingController _prenom_de_la_personne_a_remplacerController = TextEditingController();

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  String _selectedProfil = '';
  String _selectedMotif = ''; 
  String _selectedService = '';
  String _selectedStructure = '';
  String _selectedType = 'Vacation'; // Valeur par défaut
  String _selectedExpressType = 'Standard'; // Valeur par défaut
  String _selectedDebut = '';
  String _selectedFin = '';
  String _selectedHeure_debut = '';
  String _selectedHeure_fin = '';
  String _selectedNom_de_la_personne_a_remplacer = '';
  String _selectedPrenom_de_la_personne_a_remplacer = '';

  List<String> _optionsStructure = [
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
  List<String> _optionsProfilRecherche = [
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

  Future<void> _fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/creer-missions'));
    

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<MissionData> missions = jsonData.map((data) => MissionData.fromJson(data)).toList();
      
      // Vider la liste existante avant de mettre à jour avec les nouvelles données
      widget.missions.clear();
      
      // Mettre à jour la liste widget.missions avec les données récupérées
      setState(() {
        widget.missions.addAll(missions);

        // Afficher la taille de la liste missions pour vérifier qu'elle est mise à jour
        print('Nombre de missions récupérées : ${widget.missions.length}');
      });
    } else {
      print('Erreur lors de la requête HTTP : ${response.statusCode}');
      print('Réponse serveur : ${response.body}');
    }
  } catch (e) {
    print('Exception lors de la requête HTTP : $e');
  }
}
  @override
void initState() {
  super.initState();
  _fetchData();
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
              'Poster une mission',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff009de1),
                fontSize: 24.0,
              ),
            ),
            // Text('Nombre de missions récupérées : ${widget.missions.length}'),
            SizedBox(height: 10.0),
            Text('1.Type de mission'),
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
            Text('2.Structure '),
            DropdownButton(
              isExpanded: true,
              value: _selectedStructure.isNotEmpty
                  ? _selectedStructure
                  : _optionsStructure[0],
              onChanged: (value) {
                // Gérer le changement de valeur du menu déroulant
                setState(() {
                  _selectedStructure = value.toString();
                });
              },
              items: _optionsStructure.map((structure) {
                return DropdownMenuItem(
                  value: structure,
                  child: Text(structure),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('3.Type '),
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
            Text('4.Service '),
            DropdownButton(
              isExpanded: true,
              value: _selectedService.isNotEmpty
                  ? _selectedService
                  : _optionsService[0],
              onChanged: (value) {
                // Gérer le changement de valeur du menu déroulant
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
            Text('5.Date et Horaire de la mission'),
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
            Text('6.Profil recherché '),
            DropdownButton(
              isExpanded: true,
              value: _selectedProfil.isNotEmpty
                  ? _selectedProfil
                  : _optionsProfilRecherche[0],
              onChanged: (value) {
                setState(() {
                  _selectedProfil = value.toString();
                });
              },
              items: _optionsProfilRecherche.map((profilrecherche) {
                return DropdownMenuItem(
                  value: profilrecherche,
                  child: Text(profilrecherche),
                );
              }).toList(),
            ),
            Text('7.Motif'),
            DropdownButton(
              isExpanded: true,
              value:
                  _selectedMotif.isNotEmpty ? _selectedMotif : _optionsMotif[0],
              onChanged: (value) {
                setState(() {
                  _selectedMotif =
                      value.toString(); // Mettez à jour la valeur sélectionnée
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
            TextField(
              controller: _nom_de_la_personne_a_remplacerController,
              decoration: InputDecoration(
                label: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          '8. Nom de la personne à remplacer',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextField(
              controller: _prenom_de_la_personne_a_remplacerController,
              decoration: InputDecoration(
                label: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          '9. Prenom de la personne à remplacer',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Utilisez Navigator.pop pour revenir à l'écran précédent
                    Navigator.pop(context);
                  },
                  child: Text("Retour"),
                ),
                SizedBox(width: 10),
                //               
               ElevatedButton(
  onPressed: () async {
    // Récupérer les données saisies
    MissionData newMission = MissionData(
      type: _selectedType,
      structure: _selectedStructure,
      service: _selectedService,
      debut: _startDateController.text,
      fin: _endDateController.text,
      heure_debut: _startTimeController.text,
      heure_fin: _endTimeController.text,
      profil: _selectedProfil,
      motif: _selectedMotif,
      nom_de_la_personne_a_remplacer: _nom_de_la_personne_a_remplacerController.text,
      prenom_de_la_personne_a_remplacer: _prenom_de_la_personne_a_remplacerController.text,
    );

    // Appeler la fonction pour poster la mission dans la base de données
    await _posterMission(newMission);

    // Actualiser les données après la création de la mission
    await _fetchData();

    // Naviguer vers la page MissionsManager avec la nouvelle liste des missions
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MissionsManager(missions: widget.missions),
      ),
    );
  },
  child: Text("Créer une mission"),
),


          // Affichage du nombre de missions récupérées
          // Text('Nombre de missions récupérées : ${widget.missions.length}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

 Future<void> _posterMission(MissionData newMission) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/creer-missions'),
      // Uri.parse('http://127.0.0.1:35053/api/creer-missions'),
      
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type': newMission.type,
        'structure': newMission.structure,
        'service': newMission.service,
        'debut': newMission.debut,
        'fin': newMission.fin,
        'heure_debut': newMission.heure_debut,
        'heure_fin': newMission.heure_fin,
        'profil': newMission.profil,
        'motif': newMission.motif,
        'nom_de_la_personne_a_remplacer': newMission.nom_de_la_personne_a_remplacer,
        'prenom_de_la_personne_a_remplacer': newMission.prenom_de_la_personne_a_remplacer,
      }),
    );

     if (response.statusCode == 201) {
      // Succès
      print('Mission créée avec succès');

      // Mettre à jour la liste des missions après la création de la mission
      await _fetchData();

      // Naviguer vers la page MissionsManager avec la nouvelle liste des missions
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MissionsManager(missions: widget.missions),
        ),
      );
      
    } else {
      print('Erreur lors de la requête HTTP : ${response.statusCode}');
      print('Réponse serveur : ${response.body}');
    }
  } catch (e) {
    print('Exception lors de la requête HTTP : $e');
  }
}
}
void main() {
  runApp(
    MaterialApp(
      home: CreerMission(
        onMissionCreated: (MissionData newMission) {
          // Ajoutez ici le code pour traiter la nouvelle mission
          print('Nouvelle mission créée:');
          print('Type: ${newMission.type}');
          print('Structure: ${newMission.structure}');
          print('Motif: ${newMission.motif}');
        },
      ),
    ),
  );
}