import 'dart:convert';
import 'dart:typed_data';

class Entity {
  // ignore: constant_identifier_names
  static const String IMAGE = "image";

// ignore: constant_identifier_names
  static const String VIDEO = "video";

  Entity(this.id, this.url, this.type, {this.videUrl});

  String id;
  String url;
  String type;
  String? videUrl;
  Duration? duration;
  Uint8List? thumbnailData;
  DateTime? crateTime;
  double? lat;
  double? long;

  factory Entity.formJson(Map<String, dynamic> jsonObject) {
    var id = jsonObject["id"];
    var url = jsonObject["url"];
    var type = jsonObject["type"];
    var videUrl = jsonObject["videUrl"];
    var durationTimestamp = jsonObject["duration"];
    var thumbnailDataOri = jsonObject["thumbnailData"];
    var lat = jsonObject["lat"];
    var long = jsonObject["long"];

    Uint8List? thumbnailData;
    if (thumbnailDataOri != null) {
      thumbnailData = base64Decode(thumbnailDataOri);
    }
    var entity = Entity(id, url, type, videUrl: videUrl);
    if (durationTimestamp != null && durationTimestamp != 0) {
      entity.duration = Duration(milliseconds: durationTimestamp);
    }
    entity.thumbnailData = thumbnailData;
    var timestamp = jsonObject["crateTime"];
    if (timestamp != null) {
      entity.crateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    entity.lat = lat;
    entity.long = long;
    return entity;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "url": url,
      "type": type,
      "videUrl": videUrl,
      "long": long,
      "lat": lat,
      "crateTime": crateTime?.millisecondsSinceEpoch,
      "duration": duration?.inMilliseconds,
      "thumbnailData": thumbnailData == null ? null : base64Encode(thumbnailData!)
    };
  }
}
