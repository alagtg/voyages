import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GallerieDetails extends StatefulWidget {
  String keyword = "";
  GallerieDetails(this.keyword);

  @override
  State<GallerieDetails> createState() => _GallerieDetailsState();
}

class _GallerieDetailsState extends State<GallerieDetails> {
  int currentPage = 1;
  int size = 10;
  int totalPages = 1;
  ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  var galleryData;

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  void getGalleryData(String keyword) {
    print("Image de $keyword");
    String url =
        "https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=$keyword&page=$currentPage&per_page=$size";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.galleryData = json.decode(resp.body);
        hits.addAll(galleryData['hits']);
        totalPages = (galleryData['totalHits'] / size).ceil();
        print(hits);
      });
    });
  }

  void goToPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        hits.clear();
        getGalleryData(widget.keyword);
      });
    }
  }

  void goToNextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
        hits.clear();
        getGalleryData(widget.keyword);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(totalPages == 0
            ? 'Pas de résultats'
            : "${widget.keyword}, Page $currentPage/$totalPages"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: goToPreviousPage,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: goToNextPage,
          ),
        ],
      ),
      body: (galleryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: hits.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                color: Colors.blue,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      hits[index]['tags'],
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
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Image.network(
                    hits[index]['webformatURL'],
                    fit: BoxFit.fitWidth,
                  ),
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
    _scrollController.dispose();
    super.dispose();
  }
}
