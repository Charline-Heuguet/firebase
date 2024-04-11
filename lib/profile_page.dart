import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;

  ProfilePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Column(
        children: <Widget>[
          // Partie utilisateur dynamique
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('profil').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final documents = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var doc = documents[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.00),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            'Bonjour ${doc['lastname']} ${doc['name']}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Voici vos informations personnelles renseignées lors de l'inscription:",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          Text('Nom : ${doc['lastname']}', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                          SizedBox(height: 4), // espace
                          Text('Prénom : ${doc['name']}', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                          Text('Email : ${widget.userEmail}', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Boutons en bas
          ElevatedButton(
            onPressed: () {
              // vers la HomePage
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text('Retour à la page d\'accueil'),
          ),
          Spacer(),
          SizedBox(height: 60),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                await _auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
              } catch (e) {
                print("Erreur lors de la déconnexion : $e");
              }
            },
            icon: Icon(Icons.logout), // Icône de déco
            label: Text('Se déconnecter'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(7),
            ),
          ),
          SizedBox(height: 20), // Espace supplémentaire en bas pour l'esthétique
        ],
      ),
    );
  }
}
