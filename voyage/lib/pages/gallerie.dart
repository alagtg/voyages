import 'package:flutter/material.dart';

import 'gallerie-details.dart';

class GalleriePage extends StatelessWidget {
  final TextEditingController txt_gallerie = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              controller: txt_gallerie, // Assign the controller to the TextFormField
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.image),
                hintText: 'Keyword',
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
                _onGetGallerieDetails(context);
              },
              child: Text("Rechercher", style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
          ),
        ],
      ),
    );
  }

  void _onGetGallerieDetails(BuildContext context) {
    String keyword = txt_gallerie.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerieDetails(keyword),
      ),
    );
    txt_gallerie.text = "";
  }
}
