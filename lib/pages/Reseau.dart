import 'dart:convert';
import 'package:api_parba/pages/AccueilPage.dart';
import 'package:api_parba/pages/ConnexionManager.dart';
import 'package:api_parba/pages/MissionsManager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Reseau(),
  ));
}

class UserProfile {
  final String nom_de_la_personne_a_remplacer;
  final String prenom_de_la_personne_a_remplacer;
  final String service;
  final String horaire;

  UserProfile({required this.nom_de_la_personne_a_remplacer,required this.prenom_de_la_personne_a_remplacer, required this.service, required this.horaire});
}

class Reseau extends StatefulWidget {
  const Reseau({Key? key}) : super(key: key);

  @override
  State<Reseau> createState() => _ReseauState();
}

class _ReseauState extends State<Reseau> {
  TextEditingController _searchController = TextEditingController();
  int _currentIndex = 2;
  List<UserProfile> _userProfiles = [];

  @override
  void initState() {
    super.initState();
    _fetchUserProfiles();
  }

Future<void> _fetchUserProfiles() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/reseaux-managers'));
  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);

    if (data is List) {
      final List<UserProfile> userProfiles = data.map((item) {
        return UserProfile(
          nom_de_la_personne_a_remplacer: item['nom_de_la_personne_a_remplacer'],
          prenom_de_la_personne_a_remplacer: item['prenom_de_la_personne_a_remplacer'],
          service: item['service'],
          horaire: item['horaire'],
        );
      }).toList();

      setState(() {
        _userProfiles = userProfiles;
      });
     

    } else {
      print("Erreur de structure JSON");
       print(_userProfiles.length);
      print(_userProfiles); // Vérifiez le contenu des profils récupérés
    }
  } else {
    print("Erreur de requête : ${response.statusCode}");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Réseau',
          style: TextStyle(
            color: Color(0xff009de1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Rechercher...",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(height: 16.0, width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Gérer la recherche ici
                  },
                  child: Text("Rechercher"),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Expanded(
            //   child: ListView(
            //     children: _userProfiles.map((userProfile) => _buildProfileCard(userProfile)).toList(),
            //   ),
            // ),
            // _buildProfileCard("Alpha", "Sow", "Dentiste", "Jour"),
            Expanded(
              child: ListView(
                children: _userProfiles.map((userProfile) => _buildProfileCard(userProfile)).toList(),
              ),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MissionsManager(missions: [],)),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MissionsManager(missions: [],)),
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
 // Dans la méthode _buildProfileCard, utilisez les données utilisateur pour afficher les profils
Widget _buildProfileCard(UserProfile userProfile) {
  return Card(
    elevation: 4.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30.0,
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text("${userProfile.nom_de_la_personne_a_remplacer} ${userProfile.prenom_de_la_personne_a_remplacer}"),
                Text(userProfile.service),
              ],
            ),
          ),
          SizedBox(height: 16.0, width: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(userProfile.horaire),
              ),
              SizedBox(width: 100.0),
              ElevatedButton(
                onPressed: () {
                  _showProfilePopup();
                },
                child: Text("Plus d'infos"),
              ),
            ],
          ),
        ],
      ),
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
              title: Text("Plus d'infos"),
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccueilPage()));
  }
}