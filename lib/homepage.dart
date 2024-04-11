import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homepage',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding( // Ajoute un Padding autour de tout le contenu du SingleChildScrollView
          padding: const EdgeInsets.all(20), // Ajoute un padding de 20 pixels sur tous les côtés
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                "Évaluation Flutter du 9 et 11 avril",
                style: TextStyle(
                    fontSize: 24, decoration: TextDecoration.underline
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Bonjour",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10), // Espace entre le texte et l'icône
                  Icon(
                    Icons.waving_hand, // Icône de main qui salue
                    size: 24,
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                "Si tu veux accéder à ton profil, cliques sur le bouton ci-dessous:",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Bouton pour aller sur le profil
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(userEmail: FirebaseAuth.instance.currentUser?.email ?? 'Aucun email trouvé')));
                },
                child: Text('Aller à mon profil'),
              ),
              SizedBox(height: 80),
              Text(
                "Tu es déjà connecté mais si tu veux te créer un nouveau compte, déconnecte-toi en cliquant sur le bouton ici et tu seras redirigé vers une page de création de compte",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Bouton de déconnexion
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.logout), // Icône de déconnexion
                label: Text('Se déconnecter'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
