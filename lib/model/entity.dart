class Entity {
  // ignore: constant_identifier_names
  static const String IMAGE = "image";

// ignore: constant_identifier_names
  static const String VIDEO = "video";

  Entity(this.id,this.url, this.type);

  String id;
  String url;
  String type;
}
