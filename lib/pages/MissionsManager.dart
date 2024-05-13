import 'dart:convert';
import 'package:api_parba/pages/AccueilPage.dart';
import 'package:api_parba/pages/DeclarerMission.dart';
import 'package:api_parba/pages/DetailMission.dart';
import 'package:http/http.dart' as http;
import 'package:api_parba/pages/ConnexionManager.dart';
import 'package:api_parba/pages/CreerMission.dart';
import 'package:api_parba/pages/DetailMissionManager.dart';
import 'package:api_parba/pages/Reseau.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Mission {
  bool? estPourvue;
  bool? estAnnule;
  bool? estRemplacant;
  bool? estService;
  bool? estMetier;
  bool? estDate;
  bool? estPourvueOuNon;
  bool? estAnnuleOuNon;
  bool? estAdministrateur;
  bool? estEtablissement;
  bool? estChoixDuMetier;
  bool? estJourNuit;

  Mission({
    this.estPourvue,
    this.estAnnule,
    this.estRemplacant,
    this.estService,
    this.estMetier,
    this.estDate,
    this.estPourvueOuNon,
    this.estAnnuleOuNon,
    this.estAdministrateur,
    this.estEtablissement,
    this.estChoixDuMetier,
    this.estJourNuit,

    
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      estPourvue: json['estPourvue'] ?? false,
      estAnnule: json['estAnnule'] ?? false,
      estRemplacant: json['estRemplacant'] ?? false,
      estService: json['estService'] ?? false,
      estMetier: json['estMetier'] ?? false,
      estPourvueOuNon: json['estPourvueOuNon'] ?? false,
      estAnnuleOuNon: json['estAnnuleOuNon'] ?? false,
      estDate: json['estDate'] ?? false,
      estAdministrateur: json['estAdministrateur'] ?? false,
      estEtablissement: json['estEtablissement'] ?? false,
      estChoixDuMetier: json['estChoixDuMetier'] ?? false,
      estJourNuit: json['estJourNuit'] ?? false,
    );
  }
}

class MissionsManager extends StatefulWidget {
  final List<MissionData> missions;

  const MissionsManager({Key? key, required this.missions}) : super(key: key);

  @override
  // State<MissionsManager> createState() => _MissionsManagerState();
  _MissionsManagerState createState() => _MissionsManagerState();

  void onMissionCreated(MissionData newMission) {}
  
}

class _MissionsManagerState extends State<MissionsManager> {



 

  // int _currentIndex = 3; // Index de l'onglet actuellement sélectionné
  int _currentIndex = 0;
  List<bool> _isSelected = [false, false, false, true];

  List<MissionData> missions = [];
  
  get DeclarerMissionData => null; // Liste pour stocker les missions

  // Ajoutez une fonction pour ajouter une mission
  void addMission(MissionData newMission) {
    setState(() {
      missions.add(newMission);
    });
  }

  List<Mission> missionsToDisplay = [];
  String searchQuery = '';
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  Mission selectedMission = Mission(
    estPourvue: true,
    estAnnule: false,
    estRemplacant: true,
    estAdministrateur: true,
    estService: true,
    estMetier: true,
    estDate: true,
    estPourvueOuNon: true,
    estAnnuleOuNon: true,
    estEtablissement: true,
    estChoixDuMetier: true,
    estJourNuit: true,
  );

  Future<void> _getFilteredMissions() async {
    // Vous devez implémenter la logique de filtrage ici en fonction des critères sélectionnés
    // par exemple, en utilisant les valeurs de selectedMission pour filtrer les missions

    List<Mission> filteredMissions = missionsToDisplay.where((mission) {
      // Mettez en œuvre votre logique de filtrage ici
      return (mission.estAnnule == selectedMission.estAnnule ||
              selectedMission.estAnnule == null) &&
          (mission.estRemplacant == selectedMission.estRemplacant ||
              selectedMission.estRemplacant == null) &&
          (mission.estAdministrateur == selectedMission.estAdministrateur ||
              selectedMission.estAdministrateur == null) &&
          (mission.estPourvue == selectedMission.estPourvue ||
              selectedMission.estPourvue == null) &&
          (mission.estService == selectedMission.estService ||
              selectedMission.estService == null) &&
          (mission.estMetier == selectedMission.estMetier ||
              selectedMission.estMetier == null) &&
          (mission.estDate == selectedMission.estDate ||
              selectedMission.estDate == null) &&
          (mission.estPourvueOuNon == selectedMission.estPourvueOuNon ||
              selectedMission.estPourvueOuNon == null) &&
          (mission.estAnnuleOuNon == selectedMission.estAnnuleOuNon ||
              selectedMission.estAnnuleOuNon == null) &&
          (mission.estEtablissement == selectedMission.estEtablissement ||
              selectedMission.estEtablissement == null) &&
          (mission.estChoixDuMetier == selectedMission.estChoixDuMetier ||
              selectedMission.estChoixDuMetier == null) &&
          (mission.estJourNuit == selectedMission.estJourNuit ||
              selectedMission.estJourNuit == null);
    }).toList();

    setState(() {
      // Mettez à jour la liste missionsToDisplay avec les missions filtrées
      missionsToDisplay = filteredMissions;
    });
  }

  void filterResults() {
    // Mettez en œuvre la logique de filtrage ici

    // Vous pouvez également effectuer une nouvelle requête HTTP pour obtenir des missions filtrées
    _getFilteredMissions(); // Remplacez cette ligne par votre logique de filtrage
  }

  void resetFilter() {
    setState(() {
      // Réinitialisez vos valeurs de filtre ici
      selectedMission = Mission(
        estPourvue: true,
        estAnnule: false,
        estRemplacant: true,
        estAdministrateur: true,
        estService: true,
        estMetier: true,
        estDate: true,
        estPourvueOuNon: true,
        estAnnuleOuNon: true,
        estEtablissement: true,
        estChoixDuMetier: true,
        estJourNuit: true,
      );
    });

    // Réalimentez les missions sans filtre
    fetchMissions();
  }

  List<TextEditingController> _inputControllers = [];

  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3'
        'Item 4',
  ];

  List<String> _filteredItems = [];

  List<MissionData> missionList = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
    _inputControllers =
        List.generate(_items.length, (index) => TextEditingController());
    fetchMissions(); // Appel de la fonction pour récupérer les missions
    _fetchData(); // Appeler la méthode pour charger les données initiales
  }

  Future<void> fetchMissions() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/missions-manager'));

    if (response.statusCode == 200) {
      // Conversion de la réponse JSON en liste de MissionData
      List<dynamic> data = json.decode(response.body);
    //   final List<DeclarerMissionData> missions = data != null
    // ? data.map((mission) => DeclarerMissionData.fromJson(mission)).toList()
    // : [];

      // Mettre à jour l'état avec les missions récupérées
      setState(() {
    //    final List<DeclarerMissionData> missions = data != null
    // ? data.map((mission) => DeclarerMissionData.fromJson(mission)).toList()
    // : [];

      });
    } else {
      // Gérer l'erreur de requête
    }
  }

  void _appliquerFiltre(String query) {
    setState(() {
      _filteredItems = _items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _resetFilter() {
    setState(() {
      _searchController.clear();
      _filteredItems = _items;
    });
  }

  void performSearch(String query) {
    // Faites quelque chose avec la requête de recherche (query)
    // Par exemple, si vous avez une liste de missions et que vous souhaitez filtrer en fonction du nom de la mission :

    List<MissionData> filteredMissions = missionList.where((mission) {
      return mission.type.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Utilisez maintenant la liste filtrée (filteredMissions) comme source de données pour votre widget d'affichage.
    // Par exemple, si vous avez une ListView :
    setState(() {
      missionList = filteredMissions;
    });
  }

  List<MissionData> createdMissions = [];

  // Cette fonction sera appelée chaque fois qu'une nouvelle mission est créée
  void handleMissionCreated(MissionData newMission) {
    setState(() {
      // Ajoutez la nouvelle mission à la liste
      createdMissions.add(newMission);
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mission Manager',
          style: TextStyle(
            color: Color(0xff009de1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreerMission(
                          onMissionCreated: (MissionData) {},
                        ),
                      ),
                    );
                  },
                  child: Text("Créer une mission"),
                ),
                SizedBox(width: 10), // Ajoute de l'espace horizontal entre les boutons
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => DeclarerMission()),
                    // );
                  },
                  child: Text("Déclarer une mission"),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        // Utilisez la valeur du TextField pour effectuer la recherche
                        performSearch(value);
                      },
                    ),
                  ),
                ),
              ],
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
                            child: Text(
                                '004 - Centre Hospitalier d\'enfants Albert Royer CHU'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('005 - Hopital Dalal Jamm de Guédiawaye'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '006 - Hopital Principal de Dakar Centre d\'instruction des armées'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('007 - Hopital Polyclinique de la Médina'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('008 - Hopital de Pikine'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '009 - Centre Hospitalier Nabil Choucaire'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '010 - Hopital des Enfants de Diamniadio CHU'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('011 - Centre hospitalier Abass Ndao'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '012 - Centre Hospitalier Abdoul Aziz Sy Parcelles Assainies'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('013 - Centre Hospitalier Roi Baudouin'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '014 - Centre Hospitalier Philippe Senghor'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('015 - Centre Hospitalier de Keur Massar'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '016 - Centre Hospitalier Youssou Mbergane Rufisque'),
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
                            child:
                                Text('019 - Hopital Régional de Saint Louis'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('020 - Hopital Régional de Kaolack'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('021 - Hopital Régional de Tambacounda'),
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
                            child: Text(
                                '031 - Hopital Régional de Matlaboul fawzayni'),
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
                            child:
                                Text('034 - Hopital Régional de Daroukhoudos'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('035 - Hopital Régional Cheikhoul Khadim'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('036 - Clinique de la Madeleine'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '037 - Clinique du Cap Avenue Pasteur Dakar'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('038 - Clinique Pasteur Rue Carnot Dakar'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '039 - Clinique Amitié Grand Yoff à coté de la CBAO'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '040 - Clinique Belle Vue route de la Corniche en face terminus DDD Palais'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '041 - Clinique Niang Boulevard Général De gaule Colobane'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '042 - Clinique Rahma Mermoz Pyrotechnique'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('043 - Clinique YASALAM Coriche Ouest'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '044 - Clinique MEDIC\'KANE Sacré Coeur 3'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child:
                                Text('045 - Clinique Cheikh Anta en face Fann'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('046 - Clinique La SAGESSE Thiès'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '047 - Clinique Vision Médicale Coumba Thiès'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '048 - Clinique El Hadji Adama Wade Saint Louis'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text(
                                '049 - Clinique de la petite cote ADAMS Mbour'),
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
                            // SizedBox(height: 10),
                            child: Text('Neurochirurgie'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Gériatrie'),
                          ), // SizedBox(height: 10),
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
                            child:
                                Text('Service de réadaptation fonctionnelle'),
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
            
            SizedBox(height: 10), // Reduced space between list and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _appliquerFiltreButton,
                  child: Text("Filtrer"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetFilter,
                  child: Text("Réinitialiser le filtre"),
                ),
                SizedBox(height: 16),
         Text(
              'Nombre de missions : ${widget.missions.length}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff009de1),
                fontSize: 16.0,
              ),
            ),
// ListView pour afficher les tuiles de mission
    Expanded(
  child: ListView.builder(
    shrinkWrap: true,
    itemCount: widget.missions.length,
    itemBuilder: (context, index) {
      MissionData mission = widget.missions[index];
      return ListTile(
        title: Text('Type: ${mission.type}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Structure: ${mission.structure}'),
            Text('Motif: ${mission.motif}'),
            Text('Début: ${mission.debut}'),
            Text('Heure début: ${mission.heure_debut}'),
            Text('Heure fin: ${mission.heure_fin}'),
            Text('Pourvue: ${mission.pourvue}'),
            Text('Annulé: ${mission.annule}'),
            Text('Pourvue ou non: ${mission.pourvueounon}'),
            Text('Remplaçant: ${mission.remplacant}'),
            Text('Administrateur: ${mission.administrateur}'),
            Text('Service: ${mission.service}'),
            Text('Métier: ${mission.metier}'),
            Text('Etablissement: ${mission.etablissement}'),
            Text('Date: ${mission.date}'),
            Text('Choix du métier: ${mission.choixdumetier}'),
            Text('Jour/Nuit: ${mission.journuit}'),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMission(mission: mission),
            ),
          );
        },
      );
    },
  ),
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
            _currentIndex = index;
          });

          if (index == 0) {
            // Rediriger vers MissionsManager
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccueilPage()),
            );
          } else if (index == 1) {
            // Rediriger vers MissionsManager
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MissionsManager(
                        missions: [],
                      )),
            );
          } else if (index == 2) {
            // Rediriger vers la page Reseau
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Reseau()),
            );
          } else if (index == 3) {
            // Déconnexion
            _deconnecter();
          }
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xff009de1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Missions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Réseau',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Se déconnecter',
          ),
        ],
      ),
    );
  }

  // Fonction pour l'input de recherche
  void _appliquerFiltreInput(String query) {
    _appliquerFiltre(query);
  }

  // Fonction pour le bouton de filtre
  void _appliquerFiltreButton() {
    _appliquerFiltre(_searchController.text);
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

  // Fonction pour la déconnexion
  void _deconnecter() {
    // Mettez ici votre logique de déconnexion
    // Par exemple : authService.deconnexion();
    // Redirigez vers la page de connexion
    Navigator.pushReplacement(context as BuildContext,
        MaterialPageRoute(builder: (context) => ConnexionManager()));
  }
}

class MySearchResultsWidget extends StatefulWidget {
  final String searchQuery;

  const MySearchResultsWidget({required this.searchQuery});

  @override
  _MySearchResultsWidgetState createState() => _MySearchResultsWidgetState();
}

class _MySearchResultsWidgetState extends State<MySearchResultsWidget> {
  @override
  Widget build(BuildContext context) {
    // Utilisez widget.searchQuery pour afficher les résultats en fonction de la recherche
    return Container(
        // ... Votre code d'interface utilisateur ici
        );
  }
}
