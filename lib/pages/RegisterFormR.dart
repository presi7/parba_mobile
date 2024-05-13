import 'package:api_parba/pages/ConnexionRemplacant.dart';
import 'package:flutter/material.dart';

class RegisterFormR extends StatefulWidget {
  const RegisterFormR({Key? key}) : super(key: key);

  @override
  _RegisterFormRState createState() => _RegisterFormRState();
}

class _RegisterFormRState extends State<RegisterFormR> {
  String? _selectedStructure;
  String? _selectedStatut;
  String? _selectedMetier;
  String? _selectedCompetence;
  bool isDayChecked = false;
  bool isNightChecked = false;

   List<String> _optionsStructure = [
    '---------',
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

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Erreur de validation"),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _onSignUpPressed() {
    if (_selectedStructure == null ||
        _selectedStatut == null ||
        _selectedMetier == null ||
        _selectedCompetence == null ||
        (!isDayChecked && !isNightChecked)) {
      _showValidationDialog("Veuillez remplir tous les champs");
    } else {
      // Ici, vous pouvez effectuer une action comme la navigation vers la page de connexion du remplaçant
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConnexionRemplacant()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParBa Sante'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Image.asset(
                  'assets/images/parba_logo.png',
                  height: 100.0,
                  width: 100.0,
                ),
                SizedBox(height: 30.0),
                Text(
                  'Inscription Remplaçant(2/2)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 250,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      
                       items: _optionsStructure.map((structure) {
                return DropdownMenuItem(
                  value: structure,
                  child: Text(structure),
                );
              }).toList(),

                      onChanged: (newValue) {
                        setState(() {
                          _selectedStructure = newValue as String?;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Structure',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 250,
                    child: DropdownButtonFormField(
                      value: '..........',
                      items: [
                        '..........',
                        'Salarié/Agent de l\'établissement',
                        'Vacataire externe',
                        
                      ].map((String statut) {
                        return DropdownMenuItem(
                          value: statut,
                          child: Text(statut),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedStatut = newValue as String?;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Statut',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 250,
                    child: DropdownButtonFormField(
                      value: '..........',
                      items: [
                        '..........',
                        'Sage femme',
                        'Infirmier/infirmière diplomé d\'état',
                        'Infirmier/infirmière anesthésiste diplomé d\'état',
                        'Infirmière de bloc opératoire',
                        'Aide infirmier',
                        'Agent de santé hospitalier',
                        'Agent d\'entretien'
                      ].map((String metier) {
                        return DropdownMenuItem(
                          value: metier,
                          child: Text(metier),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedMetier = newValue as String?;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Métiers',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 250,
                    child: DropdownButtonFormField(
                      value: '..........',
                      items: [
                        '..........',
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
                      ].map((String competence) {
                        return DropdownMenuItem(
                          value: competence,
                          child: Text(competence),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCompetence = newValue as String?;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Compétences',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isDayChecked,
                      onChanged: (value) {
                        setState(() {
                          isDayChecked = value ?? false;
                        });
                      },
                    ),
                    Text('Jour'),
                    SizedBox(width: 20),
                    Checkbox(
                      value: isNightChecked,
                      onChanged: (value) {
                        setState(() {
                          isNightChecked = value ?? false;
                        });
                      },
                    ),
                    Text('Nuit'),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _onSignUpPressed,
                  child: Text("Finaliser Inscription"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
