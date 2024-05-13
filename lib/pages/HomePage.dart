import 'package:api_parba/pages/AccueilPage.dart';
import 'package:api_parba/pages/MesAdmissionsPage.dart';
import 'package:api_parba/pages/MesMissionsPage.dart';
import 'package:api_parba/pages/MissionsPage.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Index de l'élément actuellement sélectionné dans la barre de navigation

  List<bool> _isSelected = [true, false, false, false]; // Indique l'état de sélection des icônes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.asset(
              'assets/images/parba_hero_img.jpg',
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'ParBa, la plateforme RH de gestion des remplaçants dans la santé au Sénégal',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Un outil simple et ergonomique pour gérer ses remplacements et recrutements de soignants en toute simplicité',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ),
          // Ajoutez d'autres widgets ici...
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
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Se déconnecter',
          ),
        ],
      ),
    );
  }

  // Fonction pour la déconnexion
  void _deconnecter() {
    // Mettez ici votre logique de déconnexion
    // Par exemple : authService.deconnexion();
    // Redirigez vers la page de connexion
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AccueilPage()));
  }
}
