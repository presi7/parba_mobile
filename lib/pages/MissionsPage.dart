import 'package:api_parba/pages/AccueilPage.dart';
import 'package:api_parba/pages/HomePage.dart';
import 'package:api_parba/pages/MesAdmissionsPage.dart';
import 'package:api_parba/pages/MesMissionsPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Mission {
  bool? estPourvue;
  bool? estAnnule;
  bool? estRemplacant;
  bool? estService;
  bool? estMetier;

  Mission({
    this.estPourvue,
    this.estAnnule,
    this.estRemplacant,
    this.estService,
    this.estMetier,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      estPourvue: json['estPourvue'] ?? false,
      estAnnule: json['estAnnule'] ?? false,
      estRemplacant: json['estRemplacant'] ?? false,
      estService: json['estService'] ?? false,
      estMetier: json['estMetier'] ?? false,
    );
  }
}

void main() {
  runApp(MaterialApp(home: MissionsPage()));
}

class MissionsPage extends StatefulWidget {
  const MissionsPage({Key? key}) : super(key: key);

  @override
  State<MissionsPage> createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {

   int _currentIndex = 3; // Index de l'onglet actuellement sélectionné
  List<bool> _isSelected = [false, false, false, true]; // Indicateurs de sélection des icônes

  List<Mission> missionsToDisplay = [];
  String searchQuery = '';// Champ de recherche global
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  Mission selectedMission = Mission(  // Déclarez selectedMission ici
    estPourvue: true,
    estAnnule: false,
    estRemplacant: true,
    estService: true,
    estMetier: true,
  );

  @override
  void initState() {
    super.initState();
    _getMissions();
  }

   Future<void> _getFilteredMissions() async {
    // Vous devez implémenter la logique de filtrage ici en fonction des critères sélectionnés
    // par exemple, en utilisant les valeurs de selectedMission pour filtrer les missions

   List<Mission> filteredMissions = missionsToDisplay.where((mission) {
  // Mettez en œuvre votre logique de filtrage ici
  return (mission.estAnnule == selectedMission.estAnnule || selectedMission.estAnnule == null) &&
      (mission.estRemplacant == selectedMission.estRemplacant || selectedMission.estRemplacant == null) &&
      (mission.estPourvue == selectedMission.estPourvue || selectedMission.estPourvue == null) &&
      (mission.estService == selectedMission.estService || selectedMission.estService == null) &&
      (mission.estMetier == selectedMission.estMetier || selectedMission.estMetier == null);
}).toList();



    setState(() {
      // Mettez à jour la liste missionsToDisplay avec les missions filtrées
      missionsToDisplay = filteredMissions;
    });
  }

  void filterResults() {
    // Mettez en œuvre la logique de filtrage ici

    // Vous pouvez également effectuer une nouvelle requête HTTP pour obtenir des missions filtrées
    _getFilteredMissions();  // Remplacez cette ligne par votre logique de filtrage
  }

  void resetFilter() {
    setState(() {
      // Réinitialisez vos valeurs de filtre ici
      selectedMission = Mission(
        estPourvue: true,
        estAnnule: false,
        estRemplacant: true,
        estService: true,
        estMetier: true,
      );
    });

    // Réalimentez les missions sans filtre
    _getMissions();
  }

  Future<void> _getMissions() async {
    final url = Uri.parse('https://parba.defarsci.fr/api/missions'); // Remplacez par l'URL de votre API missions

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Mission> missions = data.map((item) => Mission.fromJson(item)).toList();

      setState(() {
        missionsToDisplay = missions;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erreur de chargement des missions'),
            content: Text('Impossible de charger les missions depuis l\'API.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void performSearch() {
    setState(() {
      searchQuery = _searchController.text; // Mise à jour de la requête de recherche
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missions'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      performSearch();
                    },
                    child: Text('Rechercher'),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        ],
                      ),
                      DropdownButton<bool>(
                        value: selectedMission.estAnnule,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMission.estAnnule = newValue!;
                          });
                        },
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: null,
                            child: Text('Annulé ou non'),
                          ),
                          DropdownMenuItem(
                            value: true,
                            child: Text('Toutes les cases'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Non annulé'),
                          ),
                        ],
                      ),

                      DropdownButton<bool>(
                        value: selectedMission.estRemplacant,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMission.estRemplacant = newValue!;
                          });
                        },
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Remplaçant'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('En attente'),
                          ),
                        ],
                      ),
                      DropdownButton<bool>(
                        value: selectedMission.estPourvue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMission.estPourvue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: null,
                            child: Text('Pourvue ou non'),
                          ),
                          DropdownMenuItem(
                            value: true,
                            child: Text('Toutes les cases'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Non pourvues'),
                          ),
                          // DropdownMenuItem(
                          //   value: true,
                          //   child: Text('Pourvue et non validée'),
                          // ),
                          // DropdownMenuItem(
                          //   value: true,
                          //   child: Text('Pourvue et validée'),
                          // ),
                          // DropdownMenuItem(
                          //   value: false,  // Ajoutez une option supplémentaire pour le cas 'Pourvue et annulée'
                          //   child: Text('Pourvue et annulée'),
                          // ),
                        ],
                      ),
                      DropdownButton<bool>(
                        value: selectedMission.estService,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMission.estService = newValue!;
                          });
                        },
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Etablissement'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('001 - Hopital Aristide Le Dantec CHU'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('002 - Hopital Général Grand Yoff CHU'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('003 - Centre Hospitalier Fann CHU'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('004 - Centre Hospitalier d\'enfants Albert Royer CHU'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('005 - Hopital Dalal Jamm de Guédiawaye'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('006 - Hopital Principal de Dakar Centre d\'instruction des armées'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('007 - Hopital Polyclinique de la Médina'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('008 - Hopital de Pikine'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('009 - Centre Hospitalier Nabil Choucaire'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('010 - Hopital des Enfants de Diamniadio CHU'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('011 - Centre hospitalier Abass Ndao'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('012 - Centre Hospitalier Abdoul Aziz Sy Parcelles Assainies'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('013 - Centre Hospitalier Roi Baudouin'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('014 - Centre Hospitalier Philippe Senghor'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('015 - Centre Hospitalier de Keur Massar'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('016 - Centre Hospitalier Youssou Mbergane Rufisque'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('017 - Hopital Régional de Thiès'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('018 - Hopital Régional de Louga'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('019 - Hopital Régional de Saint Louis'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('020 - Hopital Régional de Kaolack'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('021 - Hopital Régional de Tambacounda'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('022 - Hopital Régional de Kolda'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('023 - Hopital Régional de Bignona'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('024 - Hopital Régional de Kaffrine'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('025 - Hopital Régional de Tivaouane'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('026 - Hopital Régional de Linguère'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('027 - Hopital Régional de Fatick'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('028 - Hopital Régional de Mbour'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('029 - Hopital Régional de Ndioum'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('030 - Hopital Régional de Touba'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('031 - Hopital Régional de Matlaboul fawzayni'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('032 - Hopital Régional de Ndamatou'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('033 - Hopital Régional de Dianatou'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('034 - Hopital Régional de Daroukhoudos'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('035 - Hopital Régional Cheikhoul Khadim'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('036 - Clinique de la Madeleine'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('037 - Clinique du Cap Avenue Pasteur Dakar'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('038 - Clinique Pasteur Rue Carnot Dakar'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('039 - Clinique Amitié Grand Yoff à coté de la CBAO'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('040 - Clinique Belle Vue route de la Corniche en face terminus DDD Palais'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('041 - Clinique Niang Boulevard Général De gaule Colobane'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('042 - Clinique Rahma Mermoz Pyrotechnique'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('043 - Clinique YASALAM Coriche Ouest'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('044 - Clinique MEDIC\'KANE Sacré Coeur 3'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('045 - Clinique Cheikh Anta en face Fann'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('046 - Clinique La SAGESSE Thiès'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('047 - Clinique Vision Médicale Coumba Thiès'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('048 - Clinique El Hadji Adama Wade Saint Louis'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('049 - Clinique de la petite cote ADAMS Mbour'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('050 - Clinique DADO Mbour'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('051 - Clinique Cheikhoul Khadim'),
                          ),
                        ],
                      ),
                      DropdownButton<bool>(
                        value: selectedMission.estMetier,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMission.estMetier = newValue!;
                          });
                        },
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Choisir les Métiers'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Sage Femme'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Infirmier/Infirmière'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Anesthésiste diplomé d\'état'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Infirmière de bloc opératoire'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Aide Infirmier'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Agent santé hospitalier'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Agent d\'entretien'),
                          ),
                        ],
                      ),
                      DropdownButton<bool>(
                        value: selectedMission.estMetier,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMission.estMetier = newValue!;
                          });
                        },
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Choisir les Spécialités'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Pneumologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Gastro-entérologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Orthopédie Traumatologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Chirurgie Viscérale'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Service d\'oto-rhino-larynlogie(ORL)'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Medecine Infectueuse'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Neurologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Dermatologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Rhumatologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Service des urgences'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Pédiatrie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Gynécologie et Obstétrique'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Neurochirurgie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Gériatrie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Réanimation'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Unité de soins continue(USC)'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Service de réadaptation fonctionnelle'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Ophtalmologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Urologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Cardiologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Néphrologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Radiologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Laboratoire'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Chimiothérapie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Néonatalogie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Endocrinologie-diabétologie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Kinésithérapie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Dialyse'),
                          ),
                        ],
                      ),
                      DropdownButton<bool>(
                        value: selectedMission.estMetier,
                        onChanged: (newValue) {
                          setState(() {
                            selectedMission.estMetier = newValue!;
                          });
                        },
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Jour/Nuit'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Jour'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Nuit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    filterResults();
                  },
                  child: Text('Filtrer'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    resetFilter();
                  },
                  child: Text('Réinitialiser Filtre'),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            // Mettre à jour l'état de sélection des icônes
            for (int i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = (i == index);
            }

            // Mettre à jour l'index actuel
            _currentIndex = index;
          });

          // Naviguer vers la page correspondante
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MissionsPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MesMissionsPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MesAdmissionsPage()),
            );
          } else if (index == 4) {
            // Déconnexion
            _deconnecter();
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Mes missions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mes admissions',
          ),
        ],
      ),
    );
  }


  Future<void> _selectDate(BuildContext context, TextEditingController startDateController) async {
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

   // Fonction pour la déconnexion
  void _deconnecter() {
    // Mettez ici votre logique de déconnexion
    // Par exemple : authService.deconnexion();
    // Redirigez vers la page de connexion
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccueilPage()));
  }
}