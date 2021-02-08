import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageView extends StatefulWidget {

  final String imgUrl;
  ImageView({@required this.imgUrl});
  
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Hero(
            tag: widget.imgUrl,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover,),
              ),
          ),

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36FFFFFF),
                          Color(0x0FFFFFFF)
                        ]),
                    ),
                    child: Column(
                      children: [
                        Text("Set Wallpaper",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white60),
                        ),
                        Text("Image will be saved in gallery",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white60),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Text("Cancel",
                      style: TextStyle(
                          color: Colors.white60),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }



  _save() async {
    if (Platform.isIOS) {
      await _askPermission();
    }
    await _askPermission();
    var response = await Dio().get(
        widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
          .requestPermissions([PermissionGroup.photos]);
    } else {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}
