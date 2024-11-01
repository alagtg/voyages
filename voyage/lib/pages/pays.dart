import 'package:flutter/material.dart';

import 'pays-details.dart';

class PaysPage extends StatelessWidget {
  final TextEditingController txt_pays = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pays'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_pays, // Assign the controller to the TextFormField
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                hintText: 'Pays',
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
                _onGetPaysDetails(context);
              },
              child: Text("Rechercher", style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
          ),
        ],
      ),
    );
  }

  void _onGetPaysDetails(BuildContext context) {
    String keyword = txt_pays.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaysDetails(keyword),
      ),
    );
    txt_pays.text = "";
  }
}
