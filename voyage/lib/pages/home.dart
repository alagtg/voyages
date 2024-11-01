import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.widget.dart';


class HomePage extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Page Home")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  InkWell(
                    onTap: () {
                      _deconnexion(context);
                    },
                    child: Ink.image(
                      height: 100,
                      width: 100,
                      image: AssetImage('images/deconnexion.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/meteo');
                    },
                    child: Ink.image(
                      height: 100,
                      width: 100,
                      image: AssetImage('images/meteo.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/contact');
                    },
                    child: Ink.image(
                      height: 100,
                      width: 100,
                      image: AssetImage('images/contact.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/pays');
                    },
                    child: Ink.image(
                      height: 100,
                      width: 100,
                      image: AssetImage('images/pays.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/gallerie');
                    },
                    child: Ink.image(
                      height: 100,
                      width: 100,
                      image: AssetImage('images/gallerie.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/parametres');
                    },
                    child: Ink.image(
                      height: 100,
                      width: 100,
                      image: AssetImage('images/parametres.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deconnexion(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);
    Navigator.pushReplacementNamed(context, '/insc');
  }
}
