import 'package:api_parba/pages/AccueilPage.dart';
import 'package:api_parba/pages/HomePage.dart';
import 'package:api_parba/pages/MesMissionsPage.dart';
import 'package:api_parba/pages/MissionsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MesAdmissionsPage extends StatefulWidget {
  const MesAdmissionsPage({super.key});

  @override
  State<MesAdmissionsPage> createState() => _MesAdmissionsPageState();
}

class _MesAdmissionsPageState extends State<MesAdmissionsPage> {
  int _currentIndex = 3; // Index de l'onglet actuellement sélectionné
  List<bool> _isSelected = [false, false, false, true]; // Indicateurs de sélection des icônes

  TextEditingController structureCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  List<String> structures = ['Choisir une structure','Hopital Aristide Le Dantec CHU', 'Hopital Général Grand Yoff CHU', 'Centre Hospitalier Fann CHU',
  'Centre Hospitalier d\'enfants Albert Royer CHU', 'Hopital Dalal Jamm de Guédiawaye','Hopital Principal de Dakar Centre d\'instruction des armées',
  'Hopital Polyclinique de la Médina','Hopital de Pikine','Centre Hospitalier Nabil Choucaire','Hopital des Enfants de Diamniadio CHU',
  'Centre hospitalier Abass Ndao','Centre Hospitalier Abdoul Aziz Sy Parcelles Assainies','Centre Hospitalier Roi Baudouin','Centre Hospitalier Philippe Senghor',
  'Centre Hospitalier de Keur Massar','Centre Hospitalier Youssou Mbergane Rufisque','Hopital Régional de Thiès',
  'Hopital Régional de Louga','Hopital Régional de Saint Louis','Hopital Régional de Kaolack','Hopital Régional de Tambacounda',
  'Hopital Régional de Kolda','Hopital Régional de Bignona','Hopital Régional de Kaffrine','Hopital Régional de Tivaouane',
  'Hopital Régional de Linguère','Hopital Régional de Fatick','Hopital Régional de Mbour','Hopital Régional de Ndioum',
  'Hopital Régional de Touba','Hopital Régional de Matlaboul fawzayni','Hopital Régional de Ndamatou','Hopital Régional de Dianatou',
  'Hopital Régional de Daroukhoudos','Hopital Régional Cheikhoul Khadim','Clinique de la Madeleine',
  'Clinique du Cap Avenue Pasteur Dakar','Clinique Pasteur Rue Carnot Dakar','Clinique Amitié Grand Yoff à coté de la CBAO',
  'Clinique Belle Vue route de la Corniche en face terminus DDD Palais','Clinique Niang Boulevard Général De gaule Colobane',
  'Clinique Rahma Mermoz Pyrotechnique','Clinique YASALAM Coriche Ouest','Clinique MEDIC\'KANE Sacré Coeur 3',
  'Clinique Cheikh Anta en face Fann','Clinique La SAGESSE Thiès','Clinique Vision Médicale Coumba Thiès','Clinique El Hadji Adama Wade Saint Louis',
  'Clinique de la petite cote ADAMS Mbour','Clinique DADO Mbour','Clinique Cheikhoul Khadim'];
  
  String selectedStructure = 'Choisir une structure';
  String? selectedReceiveOption;

  @override
void initState() {
  super.initState();
  selectedStructure = structures.first;
  // Autres initialisations si nécessaires
}


  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.blue), // Couleur de la bordure
  );

  @override
  void dispose() {
    structureCodeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> fetchAdmissions() async {
  final url = Uri.parse('https://parba.defarsci.fr/api/mes-admissions');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Traitement des données de réponse ici
    final admissions = jsonDecode(response.body);
    // Vous pouvez mettre à jour l'interface utilisateur avec les données récupérées.
  } else {
    throw Exception('Échec de la requête API');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Admissions'),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showProfilePopup(); // Cette méthode affiche le popup
                },
                child: Text('Voir Mon Profil'), // Texte affiché sur le bouton
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Bordure autour du champ
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedStructure,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStructure = newValue!;
                        });
                      },
                      items: structures.map((structure) {
                        return DropdownMenuItem<String>(
                          value: structure,
                          child: Text(structure),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5), // Espacement
          TextField(
            controller: structureCodeController,
            decoration: InputDecoration(
              labelText: 'Saisir le code de la structure',
              border: inputBorder,
            ),
          ),
          SizedBox(height: 5), // Espacement
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: inputBorder,
            ),
          ),
          Text(
            'Nous ne partagerons jamais votre email à qui ce soit',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 5), // Espacement
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Recevoir le code par :',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  InputChip(
                    label: Text('Email'),
                    selected: selectedReceiveOption == 'Email',
                    onSelected: (selected) {
                      setState(() {
                        selectedReceiveOption = selected ? 'Email' : null;
                      });
                    },
                  ),
                  InputChip(
                    label: Text('SMS'),
                    selected: selectedReceiveOption == 'SMS',
                    onSelected: (selected) {
                      setState(() {
                        selectedReceiveOption = selected ? 'SMS' : null;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10), // Espacement
          ElevatedButton(
            onPressed: () {
              fetchAdmissions(); // Appel de la fonction pour récupérer les admissions
            },
            child: Text('Demander une admission'),
          ),
        ],
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
          }else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MesAdmissionsPage()));
          } else if (index == 4) {
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
           BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Se déconnecter',
          ),
        ],
      ),
    );
  }

  // Fonction pour afficher le popup "Voir mon profil"
  void _showProfilePopup() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DefaultTabController(
          length: 5, // Nombre d'onglets
          child: Scaffold(
            appBar: AppBar(
              title: Text("Voir Mon Profil"),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Profile"),
                  Tab(text: "Service"),
                  Tab(text: "Disponibilités"),
                  Tab(text: "Missions"),
                  Tab(text: "Documents"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // Contenu de l'onglet Profile
                Center(child: Text("Contenu du Profile")),
                
                // Contenu de l'onglet Service
                Center(child: Text("Contenu du Service")),
                
                // Contenu de l'onglet Disponibilités
                Center(child: Text("Contenu des Disponibilités")),
                
                // Contenu de l'onglet Missions
                Center(child: Text("Contenu des Missions")),
                
                // Contenu de l'onglet Documents
                Center(child: Text("Contenu des Documents")),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deconnecter() {
    // Logique de déconnexion ici

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccueilPage()));
  }
}
