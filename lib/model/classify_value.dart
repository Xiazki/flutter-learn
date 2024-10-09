import 'package:flutter_learn/model/entity.dart';

class ClassifyValue {
  ClassifyValue(this.id, this.title,
      {this.imageUrl, this.des, this.startTime, this.endTime});

  String id;
  //标题
  String title;
  //封面图
  String? imageUrl;
  //详情
  String? des;
  //开始时间
  String? startTime;
  //结束时间
  String? endTime;
  //精选图集
  List<Entity>? topEntities;
  int? imageCount = 0;
  int? videCount = 0;

  getTitle() => title;
  getImageUrls() => imageUrl;

  factory ClassifyValue.fromJson(Map<String, dynamic> jsonObject) {
    var id = jsonObject["id"] ?? '';
    var title = jsonObject["title"];
    var imageUrl = jsonObject["imageUrl"];
    var des = jsonObject["des"];
    var startTime = jsonObject["startTime"];
    var endTime = jsonObject["endTime"];
    List<dynamic>? topEntitiesJsonObj = jsonObject["topEntities"];
    List<Entity>? topEntities;
    if (topEntitiesJsonObj != null) {
      topEntities = topEntitiesJsonObj.map((e) => Entity.formJson(e)).toList();
    }
    ClassifyValue classifyValue = ClassifyValue(id, title,
        imageUrl: imageUrl, des: des, startTime: startTime, endTime: endTime);
    classifyValue.topEntities = topEntities;
    classifyValue.imageCount = jsonObject["imageCount"];
    classifyValue.videCount = jsonObject["videCount"];
    return classifyValue;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "imageUrl": imageUrl,
      "des": des,
      "startTime": startTime,
      "endTime": endTime,
      "topEntities": topEntities?.map((e) => e.toJson()).toList(),
      "imageCount": imageCount,
      "videCount": videCount
    };
  }

  DateTime? getStartDateTime(){
    if(startTime!=null){
      return DateTime.parse(startTime!);
    }
    return null;
  }

    DateTime? getEndDateTime(){
    if(endTime!=null){
      return DateTime.parse(endTime!);
    }
    return null;
  }
}
