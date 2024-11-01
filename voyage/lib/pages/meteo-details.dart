import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MeteoDetails extends StatefulWidget {
  final String ville;

  MeteoDetails(this.ville);

  @override
  State<MeteoDetails> createState() => _MeteoDetailsState();
}

class _MeteoDetailsState extends State<MeteoDetails> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    print("Méteo de la ville de " + ville);
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=4e78823ec83152ef8e3b8c2c02bd3a7f";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {


      this.meteoData = json.decode(resp.body);
      print(this.meteoData);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Meteo Details ${widget.ville}')),
      body: ListView.builder(
        itemCount: (meteoData == null) ? 0 : meteoData['list'].length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(5.0), // Vous pouvez ajuster la valeur selon vos besoins
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        "images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${new DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000000))}",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000000))}",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${(meteoData['list'][index]['main']['temp'] - 273.15).toStringAsFixed(2)} °C",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}
