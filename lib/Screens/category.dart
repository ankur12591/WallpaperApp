import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:wallpaper_app/Data/data.dart';
import 'package:wallpaper_app/Models/wallpaper_models.dart';
import 'package:wallpaper_app/Widgets/widgets.dart';


class Categorie extends StatefulWidget {

  final String categorieNameQuery;
  Categorie({this.categorieNameQuery});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpapers = new List();


  getSearchWallpaper (String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=40&page=1" ,
        //"https://api.pexels.com/v1/search?query=$query&per_page=1",
        headers: {
          "Authorization": apiKey
        });
    // print(response.body.toString());

    Map<String, dynamic> jsonData = await jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //  print(element);
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {
    });
  }

  @override
  void initState() {
    getSearchWallpaper(widget.categorieNameQuery);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[400],
          elevation: 0.0,
          title: AppBarTitle()
      ),


      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
          child: Column(
            children: [
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
