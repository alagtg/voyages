import 'package:flutter/material.dart';
class GlobalParams{
  static List<Map<String, dynamic>>menus=[
    {"title":"Accueil","icon":Icon(Icons.home,color:Colors.blueAccent,), "route":"/home"},
    {"title":"Météo", "icon": Icon(Icons. sunny_snowing, color: Colors.blueAccent,), "route":"/meteo"},
    {"title":"Gallerie","icon": Icon(Icons.photo,color: Colors.blueAccent,), "route":"/gallerie"},
    {"title":"Pays","icon": Icon(Icons. location_city,color: Colors.blueAccent,), "route":"/pays"},
    {"title":"Déconnexion","icon":Icon(Icons.logout,color:Colors.blueAccent,), "route":"/authentification"},
  ];
}