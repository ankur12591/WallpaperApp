import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wallpaper",style: TextStyle(
                color: Colors.black
            ),),
            Text("App",
              style: TextStyle(
                  color: Colors.greenAccent[400]
              ),
            ),
          ],
        ),
      ),

      body: Container(
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
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.search_rounded))
                ],
              ),
            ),

            SizedBox(height: 14.0,),

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

            SizedBox(height: 10.0,),
            
          ],
        ),
      ),
    );
  }
}
