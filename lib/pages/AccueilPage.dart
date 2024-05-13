import 'package:api_parba/pages/ConnexionAdmin.dart';
import 'package:api_parba/pages/ConnexionManager.dart';
import 'package:api_parba/pages/ConnexionRemplacant.dart';
import 'package:api_parba/pages/RegisterForm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sous-Menu Popup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccueilPage(),
    );
  }
}

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  int _currentIndex = 0;
  bool _showSubMenu = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Accueil'),
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
       child: Column(
         children: [
          SizedBox(height: 40.0,),
          Container(
            color: Colors.white, // Couleur de fond blanche
            padding: EdgeInsets.all(20.0), // Espace intérieur autour de l'image
            child: Image.asset(
              'assets/images/parba_logo.png',
              height: 130.0,
              width: 130.0,
            ),
          ),

           SizedBox(height: 20.0,),
           Container(
             padding: EdgeInsets.all(16.0),
             child: Center(
               child: Text(
                 'ParBa, la plateforme RH de gestion des remplaçants dans la santé au Sénégal',
                 style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold,
                 color: Colors.white),
               ),
             ),
           ),
           SizedBox(height: 10.0,),
           Container(
             padding: EdgeInsets.all(16.0),
             child: Center(
               child: Text(
                 'Un outil simple et ergonomique pour gérer ses remplacements et recrutements de soignants en toute simplicité',
                 style: TextStyle(fontSize: 14.0,color: Colors.white),
               ),
             ),
           ),
           SizedBox(height: 70), // Espacement
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Column(
  children: [
    ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConnexionRemplacant()),
          );
      },
      style: ElevatedButton.styleFrom(
         backgroundColor: Colors.green, // Couleur d'arrière-plan verte
        padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0), // Ajustez la taille ici
      ),
      child: Text(
        'Se connecter',
        style: TextStyle(
          color: Colors.white, // Texte en blanc
        ),
      ),
    ),
    SizedBox(height: 10.0), // Espace vertical entre les boutons
    OutlinedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterForm()),
          );
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0), // Ajustez la taille ici
        side: BorderSide(
          color: Colors.white, // Couleur de la bordure verte
        ),
      ),
      child: Text(
        "S'inscrire sur Parba",
        style: TextStyle(
          color: Colors.white, // Utilisez la couleur du fond
        ),
      ),
    ),
     SizedBox(height: 30),
    Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConnexionAdmin()),
          );
        },
        child: Text(
          'Se connecter en tant qu\'administrateur',
          style: TextStyle(
            // color: Color(0xff009de1),
            color: Colors.white,
            decoration: TextDecoration.underline,
            fontSize: 18.0,
          ),
        ),
      ),
    ),
  ],
)

  ],
)



              ],
            ),
          ),


           SizedBox(height: 16),
          
//            PopupMenuButton<String>(
//   onSelected: _onSubMenuSelected,
//   offset: Offset(0, 50), // Ajustez la position verticale si nécessaire
//   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//     PopupMenuItem<String>(
//       value: 'Remplaçant',
//       child: SizedBox(
//         width: 200, // Définissez la largeur souhaitée
//         child: Row(
//           children: [
//             Expanded(
//               child: Text('Remplaçant'),
//             ),
//           ],
//         ),
//       ),
//     ),
//     PopupMenuItem<String>(
//       value: 'Manager',
//       child: SizedBox(
//         width: 200, // Définissez la largeur souhaitée
//         child: Row(
//           children: [
//             Expanded(
//               child: Text('Manager'),
//             ),
//           ],
//         ),
//       ),
//     ),
//     PopupMenuItem<String>(
//       value: 'Administrateur',
//       child: SizedBox(
//         width: 200, // Définissez la largeur souhaitée
//         child: Row(
//           children: [
//             Expanded(
//               child: Text('Administrateur'),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ],
//   child: GestureDetector(
//     onTap: () {
//       // Clic sur l'icône ne fait rien ici, car le PopupMenuButton gère l'affichage du menu
//     },
//     child: Container(
//       // Icône ou texte de l'icône
//     ),
//   ),
// ),

          //  if (_showSubMenu) _buildSubMenu(),
         
          
         ],
       ),
     ),
    // backgroundColor: Colors.green, // Définir la couleur de fond du Scaffold
      
    backgroundColor: Color(0xff009de3),// bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onMenuItemTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Accueil',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.login),
      //       label: 'Connexion',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_add),
      //       label: 'Inscription Remplaçant',
      //     ),
      //   ],
      // ),
    );
  }

 void _onMenuItemTapped(int index) {
  if (index != 2) {
    // N'effectuer la navigation que si l'index n'est pas celui d'Inscription Remplaçant
    setState(() {
      _currentIndex = index;
      _showSubMenu = false;
    });

    // Afficher automatiquement le sous-menu si l'index est celui de Connexion
    if (index == 1) {
      setState(() {
        _showSubMenu = true;
      });
    }
  } else {
    // Si vous cliquez sur "Inscription Remplaçant", naviguez vers RegisterForm()
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterForm(),
      ),
    );
  }
}


 void _onSubMenuSelected(String value) {
  // Traiter la sélection du sous-menu ici
  print('Sous-menu sélectionné: $value');
  
  // Effectuez la navigation en fonction de la sélection
  if (value == 'Manager') {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConnexionManager(),
      ),
    );
  } else if (value == 'Remplaçant') {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConnexionRemplacant(),
      ),
    );
  }else if (value == 'Administrateur') {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConnexionAdmin(),
      ),
    );
  }
  
  setState(() {
    _showSubMenu = false;
  });
}


  Widget _buildSubMenu() {
    return Material(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSubMenuEntry('Remplaçant'),
          _buildSubMenuEntry('Manager'),
          _buildSubMenuEntry('Administrateur'),
        ],
      ),
    );
  }

  Widget _buildSubMenuEntry(String label) {
    return GestureDetector(
      onTap: () {
        _onSubMenuSelected(label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(label),
      ),
    );
  }
}