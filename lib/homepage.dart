import 'package:flutter/material.dart';
import 'profile_page.dart';

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
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text(
    'Evaluation Flutter du 9 et 11 avril',
    textAlign: TextAlign.center,
    style: TextStyle(
    fontSize: 16,
    ),
    ),
    SizedBox(height: 20),
    ElevatedButton(
    onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(userEmail: 'user@example.com')));
    },
    child: Text('Aller à mon profil'),
    ),
    ],
    ),
    ),
    );
  }
}
