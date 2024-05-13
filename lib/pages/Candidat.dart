import 'package:api_parba/pages/ConnexionManager.dart';
import 'package:api_parba/pages/MissionsManager.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MaterialApp(
    home: Candidat(),
  ));
}

class Candidat extends StatefulWidget {
  const Candidat({Key? key}) : super(key: key);

  @override
  State<Candidat> createState() => _CandidatState();
}

void _annulerRecrutement() {
  // Mettez ici votre logique pour annuler le recrutement
  // Par exemple : candidatService.annulerRecrutement(candidat);
  // Vous pouvez mettre à jour _rows pour refléter les changements
}

class _CandidatState extends State<Candidat> {
  int _currentIndex = 2;

  // Exemple de données pour votre tableau (remplacez-le par vos propres données)
  List<DataRow> _rows = [
    DataRow(
      cells: [
        DataCell(Text('Alpha')),
        DataCell(Text('Sow')),
        DataCell(Text('Structure1')),
        DataCell(Text('Métier1')),
        DataCell(Text('Oui')),
        DataCell(Text('Non')), // Remplacez 'Non' par 'Oui' si nécessaire
        DataCell(ElevatedButton(
          onPressed: _annulerRecrutement, // Utilisez la fonction ici sans ()
          child: Text('Annuler recrutement'),
        )),
      ],
    ),
    // Ajoutez d'autres lignes de données ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Candidat',
          style: TextStyle(
            color: Color(0xff009de1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Faites défiler verticalement
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Faites défiler horizontalement
          child: DataTable(
            columns: [
              DataColumn(label: Text('Nom')),
              DataColumn(label: Text('Prénom')),
              DataColumn(label: Text('Structure')),
              DataColumn(label: Text('Métier')),
              DataColumn(label: Text('Jour')),
              DataColumn(label: Text('Nuit')),
              DataColumn(label: Text('Action')),
            ],
            rows: _rows,
          ),
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
              MaterialPageRoute(builder: (context) => MissionsManager(missions: [],)),
            );
          } else if (index == 1) {
            // Rediriger vers Missions
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

  // Fonction pour la déconnexion
  void _deconnecter() {
    // Mettez ici votre logique de déconnexion
    // Par exemple : authService.deconnexion();
    // Redirigez vers la page de connexion
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ConnexionManager()));
  }
}