import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatelessWidget {
  late SharedPreferences prefs;

  TextEditingController txt_login = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page d'Authentification")),


      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Identifiant',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.safety_check),
                  hintText: 'Mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                _onauth(context);
              },
              child: Text(
                "Authentifier",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
          ),
          TextButton(
              child: Text("Nouvel Utilisateur", style: TextStyle(fontSize: 22)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/insc');
              }),
        ],
      ),
    );
  }

  Future<void> _onauth(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", true);
    String log = prefs.getString("login") ?? '';
    String passw = prefs.getString("password") ?? '';
    if (txt_login.text == log && password.text == passw) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } else {
      const snackBar = SnackBar(
        content: Text('verifier votre id et mot de passe'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
