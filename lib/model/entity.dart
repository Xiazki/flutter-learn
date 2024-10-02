
class Entity {
  // ignore: constant_identifier_names
  static const String IMAGE = "image";

// ignore: constant_identifier_names
  static const String VIDEO = "video";


  Entity(this.id,this.url, this.type,{this.videUrl});

  String id;
  String url;
  String type;
  String? videUrl;
}
