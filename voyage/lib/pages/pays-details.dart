import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaysDetails extends StatefulWidget {
  String Pays = "";
  PaysDetails(this.Pays);

  @override
  State<PaysDetails> createState() => _PaysDetailsState();
}

class _PaysDetailsState extends State<PaysDetails> {
  List<dynamic> paysData = [];
  List<dynamic> randomCountries = [];

  @override
  void initState() {
    super.initState();
    getPaysData(widget.Pays);
  }

  void getPaysData(String pays) {
    String url = "https://restcountries.com/v3.1/name/$pays";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.paysData = json.decode(resp.body);
        _getRandomCountries(paysData[0]['region'].toString());
      });
    });
  }

  void _getRandomCountries(String region) {
    String url = "https://restcountries.com/v3.1/region/$region";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        var countries = json.decode(resp.body);
        countries.shuffle();
        randomCountries = countries.take(4).toList();
      });
    });
  }

  void _showCountryDetails(dynamic country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryDetails(country),
      ),
    );
  }

  void _showCountryListDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryListDetails(randomCountries),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails du Pays')),
      body: (paysData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: paysData.length,
        itemBuilder: (context, index) {
          var pays = paysData[index];
          return Column(
            children: [
              Card(
                color: Colors.blue,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      pays['name']['common'],
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      subtitle: Image.network(
                        pays['flags']['png'],
                        height: 100,
                      ),
                    ),
                    ListTile(
                      title: Text('Capital'),
                      subtitle: Text(pays['capital'][0]),
                    ),
                    ListTile(
                      title: Text('Population'),
                      subtitle: Text(pays['population'].toString()),
                    ),
                    ListTile(
                      title: Text('subregion'),
                      subtitle: Text(pays['subregion'].toString()),
                    ),

                    ListTile(
                      title: Text('Region'),
                      subtitle: Text(pays['region'].toString()),
                    ),
                    ListTile(
                      title: Text('Area'),
                      subtitle: Text(pays['area'].toString()),
                    ),
                  ],
                ),
              ),
              if (randomCountries.isNotEmpty)
                GestureDetector(
                  onTap: _showCountryListDetails,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var country in randomCountries)
                            GestureDetector(
                              onTap: () {
                                _showCountryDetails(country);
                              },
                              child: Column(
                                children: [
                                  Text(country['name']['common']),
                                  Image.network(
                                    country['flags']['png'],
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CountryDetails extends StatelessWidget {
  final dynamic country;

  CountryDetails(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country['name']['common'])),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0), // Ajustez la valeur selon vos besoins
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                country['flags']['png'],
                height: 100,
              ),
              ListTile(
                title: Text('Capital'),
                subtitle: Text(country['capital'][0]),
              ),
              ListTile(
                title: Text('Population'),
                subtitle: Text(country['population'].toString()),
              ),
              ListTile(
                title: Text('Area'),
                subtitle: Text(country['area'].toString()),
              ),
              // Ajoutez d'autres détails selon vos besoins
            ],
          ),
        ),
      ),
    );

  }
}

class CountryListDetails extends StatelessWidget {
  final List<dynamic> countries;

  CountryListDetails(this.countries);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails des Pays')),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          var country = countries[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(country['name']['common']),
                  subtitle: Image.network(
                    country['flags']['png'],
                    height: 30,
                  ),
                ),
                // Ajoutez d'autres détails selon vos besoins
              ],
            ),
          );
        },
      ),
    );
  }
}