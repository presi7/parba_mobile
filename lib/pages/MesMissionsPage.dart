import 'package:api_parba/pages/AccueilPage.dart';
import 'package:api_parba/pages/HomePage.dart';
import 'package:api_parba/pages/MesAdmissionsPage.dart';
import 'package:api_parba/pages/MissionsPage.dart';
import 'package:api_parba/pages/VoirMissions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Mission {
  final int id;
  final String title;
  final String description;

  Mission({required this.id, required this.title, required this.description});
}

class MesMissionsPage extends StatefulWidget {
  const MesMissionsPage({Key? key}) : super(key: key);

  @override
  State<MesMissionsPage> createState() => _MesMissionsPageState();
}

class _MesMissionsPageState extends State<MesMissionsPage> {
  int _currentIndex = 0;

  List<Mission> missions = []; 
  
  List<bool> _isSelected = [false, true, false, false];

  TextEditingController referentielController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController debutController = TextEditingController();
  TextEditingController structureController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController etatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMissions(); // Récupérer les missions depuis l'API lors de l'initialisation de la page
  }

  Future<void> fetchMissions() async {
    final response = await http.get(Uri.parse('https://parba.defarsci.fr/api/mes-missions'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        missions = data.map((mission) {
          return Mission(
            id: mission['id'],
            title: mission['title'],
            description: mission['description'],
          );
        }).toList();
      });
    } else {
      throw Exception('Échec de la récupération des missions');
    }
  }

  @override
  void dispose() {
    referentielController.dispose();
    dateController.dispose();
    debutController.dispose();
    structureController.dispose();
    serviceController.dispose();
    etatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Missions'),
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
                  _showProfilePopup();
                },
                child: Text('Voir Mon Profil'),
              ),
            ],
          ),
          TextFormField(
            controller: referentielController,
            decoration: InputDecoration(labelText: 'Référence'),
          ),
          TextFormField(
            controller: dateController,
            decoration: InputDecoration(labelText: 'Date'),
          ),
          TextFormField(
            controller: debutController,
            decoration: InputDecoration(labelText: 'Début'),
          ),
          TextFormField(
            controller: structureController,
            decoration: InputDecoration(labelText: 'Structure'),
          ),
          TextFormField(
            controller: serviceController,
            decoration: InputDecoration(labelText: 'Service'),
          ),
          TextFormField(
            controller: etatController,
            decoration: InputDecoration(labelText: 'État'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Logique de filtrage des missions ici
          //     String referentiel = referentielController.text;
          //     String date = dateController.text;
          //     String debut = debutController.text;
          //     String structure = structureController.text;
          //     String service = serviceController.text;
          //     String etat = etatController.text;

          //     print('Référentiel: $referentiel');
          //     print('Date: $date');
          //     print('Début: $debut');
          //     print('Structure: $structure');
          //     print('Service: $service');
          //     print('État: $etat');

          //     // Mettez ici la logique pour filtrer les missions en fonction des champs de filtrage
          //   },
          //   child: Text('Voir'),
          // ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: missions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(missions[index].title),
                subtitle: Text(missions[index].description),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            for (int i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = (i == index);
            }
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MissionsPage()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MesMissionsPage()));
          } else if (index == 3) {
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

  void _showProfilePopup() {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return DefaultTabController(
        length: 5,
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
            actions: [
              // Ajouter un bouton Fermer ici
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer le popup
                  },
                ),
              ),
            ],
          ),

          body: TabBarView(
            children: [
              Center(child: Text("Contenu du Profile")),
              Center(child: Text("Contenu du Service")),
              Center(child: Text("Contenu des Disponibilités")),
              Center(child: Text("Contenu des Missions")),
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
