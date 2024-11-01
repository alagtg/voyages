import 'package:flutter/material.dart';

import 'meteo-details.dart';

class MeteoPage extends StatelessWidget {
  final TextEditingController txt_ville = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_ville,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                hintText: 'Ville',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                _onGetMeteoDetails(context); // Call the function with the correct context
              },
              child: Text("Rechercher", style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
          ),
        ],
      ),
    );
  }

  void _onGetMeteoDetails(BuildContext context) {
    String v=txt_ville.text;
    Navigator.push(
        context,
        MaterialPageRoute (
            builder: (context) => MeteoDetails(v))) ;
    txt_ville.text = "";

  }
}
