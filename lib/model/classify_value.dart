import 'package:flutter_learn/model/entity.dart';

class ClassifyValue {
  ClassifyValue(String this.title, String this.imageUrl, String this.des,
      String this.startTime, String this.endTime);

  //标题
  String? title;
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

  getTitle() => title;
  getImageUrls() => imageUrl;
}
