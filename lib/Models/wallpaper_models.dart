class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;

  WallpaperModel({this.photographer,this.photographer_id,this.photographer_url,this.src});

  factory WallpaperModel.fromMap(Map<String,dynamic> parsedJson){
    return WallpaperModel(
      src: SrcModel.fromMap(parsedJson["src"]),
        photographer_url: parsedJson["photographer_url"] ,
        photographer_id: parsedJson["photographer_id"],
        photographer: parsedJson["photographer"],
         );
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({this.original,this.portrait,this.small});

  factory SrcModel.fromMap(Map<String,dynamic> parsedJson){
    return SrcModel(
      original: parsedJson["original"],
      portrait: parsedJson["portrait"] ,
      small: parsedJson["small"],
    );
  }
}