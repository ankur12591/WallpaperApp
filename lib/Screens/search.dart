
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:wallpaper_app/Data/data.dart';
import 'package:wallpaper_app/Models/wallpaper_models.dart';
import 'package:wallpaper_app/Widgets/widgets.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = TextEditingController();

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
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:// AppBarTitle(),
      AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[400],
          elevation: 0.0,
          title: AppBarTitle()
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:EdgeInsets.symmetric(horizontal: 16, ),
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search wallpaper",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          getSearchWallpaper(searchController.text);

                        },
                        child: Icon(Icons.search_rounded))
                  ],
                ),
              ),

              SizedBox(height: 16.0,),

              wallpapersList(wallpapers: wallpapers, context: context),

            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
