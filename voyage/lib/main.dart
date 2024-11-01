import 'package:flutter/material.dart';
import 'package:voyage/pages/auth.dart';
import 'package:voyage/pages/gallerie.dart';
import 'package:voyage/pages/home.dart';
import 'package:voyage/pages/inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/pages/meteo.dart';
import 'package:voyage/pages/pays.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/parametres.page.dart';

void main()  =>runApp(MyApp());
final routes ={
  '/home':(context)=> HomePage(),
  '/insc': (context) =>InscriptionPage(),
  '/auth':(context) => AuthPage(),
  '/meteo':(context) =>MeteoPage(),
  '/gallerie':(context) =>GalleriePage(),
  '/pays':(context) =>PaysPage(),
  '/contact':(context) =>contactPage(),
  '/parametres':(context) =>ParametrePage(),



};
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context,snapshot)
          {
            if(snapshot.hasData){
              bool conn = snapshot.data?.getBool('connecte') ?? false;
              if(conn)
                return HomePage();
            }
            return AuthPage();
          }
      ),

    );
  }
}
