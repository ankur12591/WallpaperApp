import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/Data/data.dart';
import 'package:wallpaper_app/Models/category_models.dart';
import 'package:http/http.dart' as http ;
import 'package:wallpaper_app/Models/wallpaper_models.dart';
import 'package:wallpaper_app/Screens/category.dart';
import 'package:wallpaper_app/Screens/image_view.dart';
import 'package:wallpaper_app/Screens/search.dart';
import 'package:wallpaper_app/Widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = TextEditingController();

  getTrendingWallpaper () async {
    var response = await http.get("https://api.pexels.com/v1/curated?per_page=20&page=1",
        headers: {
          "Authorization": apiKey
        });
   // print(response.body.toString());

    Map<String, dynamic> jsonData = await jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      // print(element);
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {
    });
  }

  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: AppBarTitle(),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
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
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Search(
                                searchQuery: searchController.text,
                              )));
                        },
                        child: Icon(Icons.search_rounded))
                  ],
                ),
              ),

              SizedBox(height: 16.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Made by  ",style: TextStyle(
                      color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  ),),
                  Text("Ankur Sutariya",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500

                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0,),
              
              Container(
                height: 80,
                child: ListView.builder(
                  //padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                }),
              ),

              // SizedBox(height: 16.0,),

              wallpapersList(wallpapers: wallpapers, context: context),

            ],
          ),
        ),
      ),
    );
  }
}



  class CategoriesTile extends StatelessWidget {
  final String imgUrl,title;
  CategoriesTile({@required this.imgUrl,@required this.title});


    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              Categorie(
                  categorieNameQuery: title.toLowerCase())
          ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          child: Stack(
            children: <Widget> [

                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imgUrl,
                    height: 60,
                    width: 110,
                    fit: BoxFit.cover),
                ),

              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black12,
                  ),
                alignment: Alignment.center,
                  height: 60,
                  width: 110,
                  child: Text(title,
                      style: TextStyle(
                          color: Colors.white,
                      fontWeight: FontWeight.w400))),
            ],
          ),
        ),
      );
    }
  }



