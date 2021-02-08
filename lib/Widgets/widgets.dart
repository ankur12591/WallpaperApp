import 'package:flutter/material.dart';
import 'package:wallpaper_app/Models/wallpaper_models.dart';
import 'package:wallpaper_app/Screens/image_view.dart';

Widget AppBarTitle() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black)),
        TextSpan(text: 'App', style: TextStyle(color: Colors.greenAccent[400])),
      ],
    ),
  );
}

Widget wallpapersList ({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      ImageView(imgUrl: wallpaper.src.portrait,)));
        },

              child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(wallpaper.src.portrait,
                    fit: BoxFit.cover,),
                  ),
                ),
              ),
            )
        );
      }).toList(),
    ),
  );
}