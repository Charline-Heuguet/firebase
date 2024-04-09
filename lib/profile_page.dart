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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Streambuilder est un écouteur de màj en temps réel
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('profil').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final documents = snapshot.data!.docs;
                return ListView(
                  shrinkWrap: true,
                  children: documents.map((doc) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.00),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bonjour ${doc['lastname']} ${doc['name']}',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Nom : ${doc['lastname']}',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4), // espace entre les lignes
                          Text(
                            'Prénom : ${doc['name']}',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Email : ${widget.userEmail}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.signOut();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                    } catch (e) {
                      // Msg d'erreur en cas de bug lors de la deco
                      print("Erreur lors de la déconnexion : $e");
                    }
                  },
                  child: Text('Se déconnecter'),
                ),


                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigue vers la HomePage
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Retour à la page d\'accueil'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}